<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Persetujuan extends MyController {
		
		public function __construct() {
			log_message('DEBUG', 'akun::persetujuan Class Initialized');
			parent::__construct();
		}		
		
		public function index() {
			$this->password->getUrlAccess();						
			$this->listPersetujuan(0);
		}
		
		public function penerimaan() {
			$this->password->getUrlAccess('/akun/persetujuan/penerimaan');			
			$this->listPersetujuan(1);
		}
		
		public function pengeluaran() {
			$this->password->getUrlAccess('/akun/persetujuan/pengeluaran');			
			$this->listPersetujuan(2);				
		}
		
		private function listPersetujuan($flag) {
			$this->load->helper(array('date', 'number'));
			
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$filter  =& $this->getInitVar('filter', 1);
			$keyword =& $this->getInitVar('keyword');
			
			// Default where...
			$sql_plus = '1=1';
			$params   = array();
			
			// Filter checking...
			if (!empty($keyword)) {
				switch ($filter) {
					case 1 :
						$sql_plus = 'a.no_bukti ILIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			try {			
				$redirect_url = '';
				
				// Tipe persetujuan...
				switch ($flag) {
					case 0 :
						// Jurnal Umum...
						$sql_plus 	   .= ' AND a.flag_jurnal = ?';
						$params[]  		= 0;
						$redirect_url	= '/akun/persetujuan/';
						break;
					case 1 :
						// Jurnal Penerimaan...
						$sql_plus 	   .= ' AND i.flag_in_out = ?';
						$params[]  		= 'i';
						$redirect_url	= '/akun/persetujuan/penerimaan';
						break;
					case 2 :
						// Jurnal Pengeluaran...
						$sql_plus 	   .= ' AND i.flag_in_out = ?';
						$params[]  		= 'o';
						$redirect_url	= '/akun/persetujuan/pengeluaran';
						break;						
					default :
						throw new Exception('Parameter jenis persetujuan invalid!');
				}
				
				$sql =	"
						SELECT
						a.id_akmt_jurnal,
						a.flag_temp,
						a.no_bukti,
						a.tanggal,
						a.keterangan,
						SUM(CASE WHEN b.flag_position = 'd' THEN b.jumlah ELSE 0 END) AS nominal
						FROM
						akun.akmt_jurnal a
						INNER JOIN akun.akmt_jurnal_det b ON a.id_akmt_jurnal = b.id_akmt_jurnal
						LEFT JOIN trans.mapping_transaksi_jurnal c ON a.id_akmt_jurnal = c.id_akmt_jurnal
						LEFT JOIN trans.transaksi d ON c.id_transaksi = d.id_transaksi
						LEFT JOIN trans.sub_transaksi e ON d.id_transaksi = e.id_transaksi
						LEFT JOIN trans.mapping_kode_akun f ON e.id_mapping_kode_akun = f.id_mapping_kode_akun AND b.id_akdd_detail_coa = f.id_akdd_detail_coa
						LEFT JOIN trans.jenis_transaksi g ON f.id_jenis_transaksi = g.id_jenis_transaksi
						LEFT JOIN trans.sub_kode_kas h ON g.id_sub_kode_kas = h.id_sub_kode_kas
						LEFT JOIN trans.kode_kas i ON h.id_kode_kas = i.id_kode_kas
						WHERE
						a.flag_posting < 2
						AND
						a.flag_temp > 0
						AND
						{$sql_plus}
						GROUP BY
						a.id_akmt_jurnal,
						a.flag_temp,
						a.no_bukti,
						a.tanggal,
						a.keterangan
						ORDER BY
						a.flag_temp,
						a.no_bukti
						";								
				$arr_jurnal =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				$this->session->set_flashdata('s4b_error', "Tidak dapat menampilkan sesuai yang anda inginkan.");				
				redirect($redirect_url);
				return;
			}					
					
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 		= array();
			$data['page']	 		= $page;
			$data['filter']	 		= $filter;
			$data['keyword'] 		= $keyword;
			$data['flag']			= $flag;
			$data['arr_jurnal'] 	= $arr_jurnal;
			$this->load->viewPage('akun/list_persetujuan', $data);
		}
		
		public function edit($id_akmt_jurnal, $flag, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/akun/persetujuan/penerimaan', 'edit');
			
			$this->load->helper(array('number', 'date'));
				
			$sql = 	"
					SELECT
					a.id_akmt_jurnal,
					a.no_bukti,
					a.tanggal,
					a.keterangan,
					SUM(b.jumlah) AS nominal,
					a.flag_temp
					FROM
					akun.akmt_jurnal a
					INNER JOIN akun.akmt_jurnal_det b ON a.id_akmt_jurnal = b.id_akmt_jurnal
					WHERE
					a.id_akmt_jurnal = ?
					AND
					b.flag_position = 'd'
					GROUP BY
					a.id_akmt_jurnal,
					a.no_bukti,
					a.tanggal,
					a.keterangan,
					a.flag_temp
					";				
			$jurnal = $this->db->getRow($sql, array($id_akmt_jurnal));
				
			$sql = 	'
					SELECT
					SUM(a.jumlah) AS jumlah,
					a.flag_position,
					b.coa_number,
					b.uraian
					FROM
					akun.akmt_jurnal_det a
					INNER JOIN akun.akdd_detail_coa b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
					WHERE
					a.id_akmt_jurnal = ?
					GROUP BY
					a.flag_position,
					b.coa_number,
					b.uraian
					ORDER BY
					a.flag_position,
					b.coa_number
					';
				
			$arr_persetujuan =& $this->db->getRows($sql, array($id_akmt_jurnal));
			
			$data		  		 	 = array();
			$data['title'] 		     = 'Persetujuan';
			$data['jurnal']		 	 = $jurnal;
			$data['arr_persetujuan'] = $arr_persetujuan;
			$data['page']			 = $page;
			$data['filter']			 = $filter;
			$data['keyword']		 = $keyword;
			$this->load->viewPage('akun/list_persetujuan_edit', $data);				
		}
		
		public function editAct() {
			$this->password->getUrlAccess('/akun/persetujuan/penerimaan', 'edit');
				
			try {
				$this->load->helper('number');
		
				$this->db->beginTrans();
					
				$id_akmt_jurnal 	= $this->getVar('id_akmt_jurnal', TRUE);
				$tanggal			= $this->getVar('tanggal', TRUE);
				$persetujuan		= $this->getVar('persetujuan', TRUE);
				$page				= $this->getVar('page', TRUE);
				$filter				= $this->getVar('filter', TRUE);
				$keyword			= $this->getVar('keyword', TRUE);
				
				// Periksa apakah sistem sudah melakukan tutup buku untuk periode tersebut...
				$month = substr($tanggal, 5, 2);
				$year  = substr($tanggal, 0, 4);
				
				$posted = $this->db->getField('posted',
						'SELECT COUNT(*) AS posted FROM akun.akmt_periode WHERE bulan = ? AND tahun = ? AND flag_temp = 2',
						array($month, $year));
				
				if ($posted == 1)
					throw new Exception('Transaksi untuk periode tersebut sudah tutup buku');				
		
				$update 			 = array();
				$update['flag_temp'] = $persetujuan;
				$this->db->update('akun.akmt_jurnal', $update, 'id_akmt_jurnal = ?', array($id_akmt_jurnal));
		
				// Berikan tanda perlu perhitungan ulang pada periode buku tersebut...
				$update 			 = array();
				$update['flag_temp'] = 0;
				$this->db->update('akun.akmt_periode', $update, "(tahun::VARCHAR(4) || bulan::VARCHAR(2))::VARCHAR(6) IN (SELECT (DATE_PART('YEAR', tanggal)::VARCHAR(4) || DATE_PART('MONTH', tanggal)::VARCHAR(2))::VARCHAR(6) FROM akun.akmt_jurnal WHERE id_akmt_jurnal = ?)", array($id_akmt_jurnal));
		
				$this->db->endTrans();
		
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat merubah status persetujuan\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}		
		
		public function voucher($id_akmt_jurnal, $flag = 0) {
			$this->password->getUrlAccess('/akun/persetujuan', 'cetak');
				
			$this->load->helper(array('date', 'number'));
				
			$jurnal = $this->db->getRow('
					SELECT
					no_bukti,
					tanggal,
					keterangan
					FROM
					akun.akmt_jurnal
					WHERE
					id_akmt_jurnal = ?
					', array($id_akmt_jurnal));
		
			$jurnal_detail =& $this->db->getRows('
					SELECT
					a.jumlah,
					a.flag_position,
					b.coa_number,
					b.uraian
					FROM
					akun.akmt_jurnal_det a
					INNER JOIN akun.akdd_detail_coa b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
					WHERE
					a.id_akmt_jurnal = ?
					', array($id_akmt_jurnal));
				
			$params 			   = array();
			$params['orientation'] = 'P';
			//$params['format']	   = 'A4';
			$params['format']	   = array(210, 135);
				
			$this->load->library('Report', $params);
				
			$this->report->Open();
			$this->report->AddPage();
			$this->report->SetFooter(false);
				
			$this->report->Image($this->getImgFolder() . '/logo.jpg', 15, 8, 12);
				
			$this->report->Ln(5);
				
			$this->report->SetFont('Arial', 'B', 12);
			$this->report->MultiCell(0, 0, 'BUKTI PEMBUKUAN', 0, 'R');
				
			$this->report->Ln(5);
				
			$y = $this->report->GetY();
			$this->report->Line(15, $y, 200, $y);
				
			$this->report->Ln(0.5);
		
			$y = $this->report->GetY();
			$this->report->Line(15, $y, 200, $y);
				
			$this->report->Ln(2);
				
			$this->report->SetFont('Arial', '', 10);
			$y = $this->report->GetY();
			$this->report->MultiCell(30, 2, 'TANGGAL', 0, 'L');
			$this->report->SetXY(45, $y);
			$this->report->MultiCell(5, 2, ':', 0, 'L');
			$this->report->SetXY(50, $y);
			$this->report->MultiCell(60, 2, getLocalDate($jurnal['tanggal']), 0, 'L');
			$this->report->SetXY(110, $y);
			$this->report->MultiCell(40, 2, 'KODE TRANSAKSI', 0, 'L');
			$this->report->SetXY(150, $y);
			$this->report->MultiCell(5, 2, ':', 0, 'L');
			$this->report->SetXY(155, $y);
			$this->report->MultiCell(55, 2, $jurnal['no_bukti'], 0, 'L');
				
			$this->report->Ln(2);
				
			$y = $this->report->GetY();
			$this->report->MultiCell(30, 2, 'KETERANGAN', 0, 'L');
			$this->report->SetXY(45, $y);
			$this->report->MultiCell(0, 2, ':', 0, 'L');
				
			$this->report->Ln(5);
				
			$y = $this->report->GetY();
			$this->report->MultiCell(20, 5, 'NO. AKUN', 'TB', 'C');
			$this->report->SetXY(35, $y);
			$this->report->MultiCell(50, 5, 'NAMA AKUN', 'TB', 'C');
			$this->report->SetXY(85, $y);
			$this->report->MultiCell(55, 5, 'KETERANGAN', 'TB', 'C');
			$this->report->SetXY(140, $y);
			$this->report->MultiCell(30, 5, 'DEBET', 'TB', 'C');
			$this->report->SetXY(170, $y);
			$this->report->MultiCell(30, 5, 'KREDIT', 'TB', 'C');
				
			$this->report->Ln(2);
				
			$jumlah_debet  = 0;
			$jumlah_kredit = 0;
				
			foreach ($jurnal_detail as $detail) {
		
				$nb = max($this->report->NbLines(50, $detail['uraian']), $this->report->NbLines(55, $jurnal['keterangan']));
				$height = 3 * $nb;
		
				$y = $this->report->GetY();
		
				$this->report->MultiCell(20, 4, $detail['coa_number'], 0, 'C');
				$this->report->SetXY(35, $y);
				$this->report->MultiCell(50, 4, $detail['uraian'], 0, 'L');
				$this->report->SetXY(85, $y);
				$this->report->MultiCell(55, 4, $jurnal['keterangan'], 0, 'L');
				$this->report->SetXY(140, $y);
				$this->report->MultiCell(30, 4, ($detail['flag_position'] == 'd' ? numFormat($detail['jumlah']) : '-'), 0, 'R');
				$this->report->SetXY(170, $y);
				$this->report->MultiCell(30, 4, ($detail['flag_position'] == 'k' ? numFormat($detail['jumlah']) : '-'), 0, 'R');
		
				$this->report->Ln($height);
		
				$jumlah_debet  += ($detail['flag_position'] == 'd' ? $detail['jumlah'] : 0);
				$jumlah_kredit += ($detail['flag_position'] == 'k' ? $detail['jumlah'] : 0);
			}
				
			$y = $this->report->GetY();
		
			$this->report->Line(15, $y, 200, $y);
		
			$this->report->SetXY(85, $y);
			$this->report->MultiCell(55, 5, 'JUMLAH', 0, 'R');
			$this->report->SetXY(140, $y);
			$this->report->MultiCell(30, 5, numFormat($jumlah_debet), 0, 'R');
			$this->report->SetXY(170, $y);
			$this->report->MultiCell(30, 5, numFormat($jumlah_kredit), 0, 'R');
		
			$y = $this->report->GetY();
				
			$this->report->Line(15, $y, 200, $y);
				
			$this->report->Ln(5);
		
			$y = $this->report->GetY();
			$this->report->MultiCell(80, 2, 'MEMBUAT', 0, 'C');
			$this->report->SetXY(95, $y);
			$this->report->MultiCell(80, 2, 'MENGETAHUI', 0, 'C');
		
			$this->report->Ln(2);
				
			$y = $this->report->GetY();
			$this->report->MultiCell(80, 2, 'KEUANGAN / AKUNTANSI', 0, 'C');
				
			$this->report->Ln(15);
				
			$y = $this->report->GetY();
				
			$this->report->MultiCell(80, 2, '(                                )', 0, 'C');
			$this->report->SetXY(95, $y);
			$this->report->MultiCell(80, 2, '(                                )', 0, 'C');
				
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}		
		
		public function report($flag, $filter, $keyword = '') {
			
		}
		
	}
	
/* End of file persetujuan.php */
/* Location: ./system/application/controllers/akun/persetujuan.php */
	
