<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Jurnal extends MyController {
		private $masuk_keluar;
	
		public function __construct() {
			log_message('DEBUG', 'akun::Jurnal Class Initialized');
			parent::__construct();
			$masuk_keluar = null;
		}
		
		public function index($id_akmt_jurnal = '', $redirect = 0) {
			$metodenya = $this->uri->segment(3);
		
			if ($metodenya!='terima' && $metodenya!='keluar')
				$this->password->getUrlAccess();
			
			switch ($metodenya) {
				case 'terima':
					$sql_1 = "id_akdd_kodifikasi_jurnal IN (1)";
					break;
				case 'keluar':
					$sql_1 = "id_akdd_kodifikasi_jurnal IN (2)";
					break;
				default:
					$metodenya = 'all';
					$sql_1 = "id_akdd_kodifikasi_jurnal IN (3, 4, 5, 6)";
					break;
			}
			
			$this->load->helper(array('date', 'number'));
			
			$id_akmt_periode = $this->db->getField('id_akmt_periode', 'SELECT id_akmt_periode FROM akun.akmt_periode WHERE flag_temp = 2');
			
			$id_akmt_jurnal =& $this->getInitVar('id_akmt_jurnal', $id_akmt_jurnal);
			
			$required = 'required';	// defaultnya
			if (is_numeric($id_akmt_jurnal)) {
				$arr_detail =& $this->db->getRows('
											      SELECT
											      a.id_akmt_jurnal_det,
												  a.jumlah,
												  a.flag_position,
												  b.id_akdd_detail_coa,
												  b.coa_number,
											      b.uraian
											      FROM
											      akun.akmt_jurnal_det a
											      INNER JOIN akun.akdd_detail_coa b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
											      WHERE
											      a.id_akmt_jurnal = ?
											      ORDER BY
											      a.flag_position,
											      b.coa_number,
											      b.uraian
											      ', array($id_akmt_jurnal));
											   
				$jurnal = $this->db->getRow('
											SELECT
											no_bukti,
											tanggal,
											keterangan,
											flag_temp
											FROM
											akun.akmt_jurnal
											WHERE
											id_akmt_jurnal = ?
											AND
											flag_jurnal = 0
											', array($id_akmt_jurnal));
				$no_bukti 	   = $jurnal['no_bukti'];
				$tgl_transaksi = $jurnal['tanggal'];
				$uraian 	   = $jurnal['keterangan'];
				$flag_temp	   = $jurnal['flag_temp'];
				$required	   = '';
			} else {
				$no_bukti 	   = '';
				$tgl_transaksi = '';
				$uraian 	   = '';
				$flag_temp	   = '';
				$arr_detail    = array();
				$required	   = 'required';
			}
			
			$sql = 	"
					SELECT
					kode,
					notes
					FROM
					akun.akdd_kodifikasi_jurnal
					WHERE
					$sql_1
					ORDER BY
					kode,
					notes
					";
			$arr_kodifikasi =& $this->db->getRows($sql);
		
			$data 			   		 = array();
			$data['id_akmt_jurnal']	 = $id_akmt_jurnal;
			$data['redirect']		 = $redirect;
			$data['no_bukti']		 = $no_bukti;
			$data['tgl_transaksi']	 = $tgl_transaksi;
			$data['uraian']			 = $uraian;
			$data['flag_temp']		 = $flag_temp;
			$data['arr_detail']		 = $arr_detail;
			$data['id_akmt_periode'] = $id_akmt_periode;
			$data['arr_kodifikasi']	 = $arr_kodifikasi;
			$data['metodenya']		 = $metodenya;
			$data['required']		 = $required;
			$this->load->viewPage('akun/jurnal_umum', $data);
		}
		
		public function terima($id_akmt_jurnal = '', $redirect = 0) {
			$this->password->getUrlAccess();
			$this->index($id_akmt_jurnal, $redirect);
		}
		
		public function keluar($id_akmt_jurnal = '', $redirect = 0) {
			$this->password->getUrlAccess();
			$this->index($id_akmt_jurnal, $redirect);
		}
		
		public function all($id_akmt_jurnal = '', $redirect = 0) {
			$this->password->getUrlAccess();
			$this->index($id_akmt_jurnal, $redirect);
		}
		
		public function daftar() {
			$this->password->getUrlAccess();
			
			$this->load->helper('date');
			$this->load->helper('number');
			
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$keyword =& $this->getInitVar('keyword');
			$tgl_1 	 =& $this->getInitVar('tgl_1');			
			$tgl_2 	 =& $this->getInitVar('tgl_2');			
			$tanggal =& $this->getInitVar('tanggal');

			// Default where...
			$sql_plus = '1=1';
			$params   = array();			

			// Keyword checking...
			if (!empty($keyword)) {
				$low_keyword = strtolower($keyword);
				$sql_plus = 'lower(a.no_bukti) LIKE ? OR lower(a.keterangan) LIKE ?';
				$params[] = "%{$low_keyword}%";
				$params[] = "%{$low_keyword}%";
			}
						
			$tgl_1Day 	= '';
			$tgl_1Month = '';
			$tgl_1Year 	= '';
			
			$tgl_2Day 	= '';
			$tgl_2Month = '';
			$tgl_2Year 	= '';
			
			if (!empty($tanggal)) {
				$sql_plus .= ' AND a.tanggal BETWEEN ? AND ?';
				$params[]  = $tgl_1;
				$params[]  = $tgl_2;
				
				$tgl_1Day 	= intval(substr($tgl_1, -2));
				$tgl_1Month = intval(substr($tgl_1, 5, 2));
				$tgl_1Year 	= intval(substr($tgl_1, 0, 4));
				
				$tgl_2Day 	= intval(substr($tgl_2, -2));
				$tgl_2Month = intval(substr($tgl_2, 5, 2));
				$tgl_2Year 	= intval(substr($tgl_2, 0, 4));					
			}
			
			switch ($this->masuk_keluar) {
				case 'm':
					$rPrefix = $this->db->getRows("SELECT kode FROM akun.akdd_kodifikasi_jurnal WHERE id_akdd_kodifikasi_jurnal IN (1)");
					$link_tambah = "akun/jurnal/terima/new/1";
					$link_edit = "akun/jurnal/terima";
					break;
				case 'k':
					$rPrefix = $this->db->getRows("SELECT kode FROM akun.akdd_kodifikasi_jurnal WHERE id_akdd_kodifikasi_jurnal IN (2)");
					$link_tambah = "akun/jurnal/keluar/new/1";
					$link_edit = "akun/jurnal/keluar";
					break;
				default:
					$rPrefix = $this->db->getRows("SELECT kode FROM akun.akdd_kodifikasi_jurnal WHERE id_akdd_kodifikasi_jurnal IN (3, 4, 5, 6)");
					$link_tambah = "akun/jurnal/index/new/1";
					$link_edit = "akun/jurnal/index";
					break;
			}
			$sqlprefix = "";
			foreach ($rPrefix as $r)
				$sqlprefix .= (strlen($sqlprefix) > 0 ? " OR " : "") . "a.no_bukti LIKE '{$r['kode']}%'";
			if (strlen($sqlprefix) > 0)
				$sql_plus .= " AND ({$sqlprefix})";
			
			$sql = "
				   SELECT
				   a.*,
				   b.id_akmt_jurnal_det,
				   b.jumlah,
				   b.flag_position,
				   c.id_akdd_detail_coa,
				   c.coa_number,
				   c.uraian
				   FROM
				   akun.akmt_jurnal a
				   LEFT JOIN akun.akmt_jurnal_det b ON a.id_akmt_jurnal = b.id_akmt_jurnal
				   LEFT JOIN akun.akdd_detail_coa c ON b.id_akdd_detail_coa = c.id_akdd_detail_coa
				   WHERE
				   a.flag_jurnal = 0
				   AND
				   {$sql_plus}
				   ORDER BY
				   a.flag_temp,
				   a.tanggal DESC,
				   a.no_bukti ASC,
				   b.flag_position
				   ";
			
			try {
				$arr_jurnal =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			
			$this->setHidden('keyword', $keyword);
			$this->setHidden('tanggal', $tanggal);
			if (!empty($tanggal)) {
				$this->setHidden('tgl_1', $tgl_1);
				$this->setHidden('tgl_2', $tgl_2);			
			}
			
			$data 			  	  = array();
			$data['keyword']  	  = $keyword;	
			$data['arr_jurnal']   = $arr_jurnal;
			$data['masuk_keluar'] = $this->masuk_keluar;
			$data['link_tambah']  = $link_tambah;
			$data['link_edit'] 	  = $link_edit;
			$data['tanggal']	  = $tanggal;
			$data['tgl_1']		  = $tgl_1;
			$data['tgl_2']		  = $tgl_2;
			$data['day1']	  	  = $tgl_1Day;
			$data['month1']	  	  = $tgl_1Month;
			$data['year1']	  	  = $tgl_1Year;
			$data['day2']	  	  = $tgl_2Day;
			$data['month2']	  	  = $tgl_2Month;
			$data['year2']	  	  = $tgl_2Year;			
			$this->load->viewPage('akun/jurnal_umum_listing', $data);
		}

		public function daftarTerima() {
			$this->password->getUrlAccess();
			$this->masuk_keluar = 'm';
			$this->daftar();
		}

		public function daftarKeluar() {
			$this->password->getUrlAccess();
			$this->masuk_keluar = 'k';
			$this->daftar();
		}

		public function del() {
			$this->password->getUrlAccess('/akun/jurnal', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$id_akmt_jurnal = $this->getVar('id_akmt_jurnal', TRUE);
								
				$this->db->delete('akun.akmt_jurnal_det', 'id_akmt_jurnal = ?', array($id_akmt_jurnal));				
				$this->db->resetSequence('akun.akmt_jurnal_det', 'id_akmt_jurnal_det', 'akun.akmt_jurnal_det_id_akmt_jurnal_det_seq');
				
				$this->db->delete('akun.akmt_jurnal', 'id_akmt_jurnal = ?', array($id_akmt_jurnal));				
				$this->db->resetSequence('akun.akmt_jurnal', 'id_akmt_jurnal', 'akun.akmt_jurnal_id_akmt_jurnal_seq');

				$this->setFinish($id_akmt_jurnal);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data jurnal\n\nPenjelasan Teknis:\n{$e->getMessage()}");
				$this->session->set_flashdata('id_akmt_jurnal', $id_akmt_jurnal);
			}
			
			redirect('/akun/jurnal' . (!empty($metodenya) ? ('/' . $metodenya) : ''));
		}
		
		public function delSub() {
			$this->password->getUrlAccess('/akun/jurnal', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$id_akmt_jurnal = $this->getVar('id_akmt_jurnal', TRUE);
				$id_list		= $this->getVar('id_list', TRUE);
				$metodenya		= $this->getVar('metodenya', TRUE);						
				
				$where_delete = str_repeat('?,', count($id_list));
				$where_delete = 'id_akmt_jurnal_det IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('akun.akmt_jurnal_det', $where_delete, $id_list);
				$this->db->resetSequence('akun.akmt_jurnal_det', 'id_akmt_jurnal_det', 'akun.akmt_jurnal_det_id_akmt_jurnal_det_seq');
				
				$this->setFinish($id_akmt_jurnal);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data detail jurnal\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			$this->session->set_flashdata('id_akmt_jurnal', $id_akmt_jurnal);
			redirect('/akun/jurnal' . (!empty($metodenya) ? ('/' . $metodenya) : ''));
		}
		
		public function delAll() {
			$this->password->getUrlAccess('/akun/jurnal', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_akmt_jurnal = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_akmt_jurnal));
				$where_delete = 'id_akmt_jurnal IN (' . substr($where_delete, 0, -1) . ')';
																
				$this->db->delete('akun.akmt_jurnal_det', $where_delete, $arr_id_akmt_jurnal);
				$this->db->resetSequence('akun.akmt_jurnal_det', 'id_akmt_jurnal_det', 'akun.akmt_jurnal_det_id_akmt_jurnal_det_seq');
				
				$this->db->delete('akun.akmt_jurnal', $where_delete, $arr_id_akmt_jurnal);
				$this->db->resetSequence('akun.akmt_jurnal', 'id_akmt_jurnal', 'akun.akmt_jurnal_id_akmt_jurnal_seq');
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data jurnal\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/akun/jurnal/daftar');
		}
		
		public function addGabung() {
			$this->password->getUrlAccess('/akun/jurnal', 'tambah');

			try {
				$this->load->helper('number');
				$this->db->beginTrans();
				
				$id_akmt_jurnal 	= $this->getVar('id_akmt_jurnal', TRUE);
				$kodifikasi 		= $this->getVar('kodifikasi', TRUE);
				$no_bukti 			= $this->getVar('no_bukti', TRUE);
				$tgl_transaksi  	= $this->getVar('tgl_transaksi', TRUE);
				$prev_transaksi	 	= $this->getVar('prev_transaksi', TRUE);
				$uraian		    	= $this->getVar('uraian', TRUE);
				$metodenya	    	= $this->getVar('metodenya', TRUE);
				$id_akdd_detail_coa = $this->getVar('id_akdd_detail_coa', TRUE);
				$jumlah 			= $this->getVar('jumlah', TRUE);
				$flag_position 		= $this->getVar('flag_position', TRUE);
				
				/* Penyusunan sistem kodifikasi jurnal secara automatis */
				$kode_jurnal = $kodifikasi;
				
				$tahun = substr($tgl_transaksi, 0, 4);
				$bulan = substr($tgl_transaksi, 5, 2);
				
				if (is_numeric($id_akmt_jurnal)) {
					$tahun_bukti = substr($no_bukti, 2, 4);
					$bulan_bukti = substr($no_bukti, 6, 2);
					
					if (($tahun != $tahun_bukti) || ($bulan != $bulan_bukti)) {
						$no_bukti = $this->db->getField('no_bukti', "SELECT SUBSTRING(no_bukti from 9 for 8) AS no_bukti FROM akun.akmt_jurnal WHERE SUBSTRING(no_bukti from 1 for 2) = ? AND DATE_PART('MONTH', tanggal) = ? AND DATE_PART('YEAR', tanggal) = ? AND flag_jurnal = 0 ORDER BY no_bukti DESC, tanggal DESC OFFSET 0 LIMIT 1", array($kode_jurnal, intval($bulan), $tahun));	// AND flag_jurnal = 0 
						$no_bukti = intval($no_bukti);
						$no_bukti = $kode_jurnal . $tahun . str_pad($bulan, 2, '0', STR_PAD_LEFT) . str_pad(++$no_bukti, 8, '0', STR_PAD_LEFT);
					}
				} else {
					$no_bukti = $this->db->getField('no_bukti', "SELECT SUBSTRING(no_bukti from 9 for 8) AS no_bukti FROM akun.akmt_jurnal WHERE SUBSTRING(no_bukti from 1 for 2) = ? AND DATE_PART('MONTH', tanggal) = ? AND DATE_PART('YEAR', tanggal) = ? ORDER BY no_bukti DESC, tanggal DESC OFFSET 0 LIMIT 1", array($kode_jurnal, intval($bulan), $tahun));	// AND flag_jurnal = 0 
					$no_bukti = intval($no_bukti);
					$no_bukti = $kode_jurnal . $tahun . str_pad($bulan, 2, '0', STR_PAD_LEFT) . str_pad(++$no_bukti, 8, '0', STR_PAD_LEFT);
				}
				/* Penyusunan sistem kodifikasi jurnal secara automatis */
							
				// Periksa apakah sistem sudah melakukan tutup buku untuk periode tersebut...
				$month = substr($tgl_transaksi, 5, 2);
				$year  = substr($tgl_transaksi, 0, 4);

				$posted = $this->db->getField('posted',
												  'SELECT COUNT(*) AS posted FROM akun.akmt_periode WHERE bulan = ? AND tahun = ? AND flag_temp = 2',
												  array($month, $year));
												  
				if ($posted == 1) 
					throw new Exception('Transaksi untuk periode tersebut sudah tutup buku');
				
				if (is_numeric($id_akmt_jurnal)) {
					if (($prev_transaksi != $tgl_transaksi) && (!empty($prev_transaksi))) {
						$prev_month = substr($prev_transaksi, 5, 2);
						$prev_year  = substr($prev_transaksi, 0, 4);
					
						// Berikan tanda perlu perhitungan ulang pada periode buku tersebut...
						$update 			 = array();
						$update['flag_temp'] = 0;
						$this->db->update('akun.akmt_periode', $update, 'tahun = ? AND bulan = ? AND flag_temp <> 2', array(intval($prev_year), intval($prev_month)));						
					}
					
					$update    			  = array();
					$update['no_bukti']   = $no_bukti;
					$update['tanggal']    = $tgl_transaksi;
					$update['flag_temp']  = 0;
					$update['keterangan'] = $uraian;
					$this->db->update('akun.akmt_jurnal', $update, 'id_akmt_jurnal = ?', array($id_akmt_jurnal));
				} else {
					$insert 				= array();
					$insert['no_bukti'] 	= $no_bukti;
					$insert['tanggal'] 		= $tgl_transaksi;
					$insert['flag_jurnal'] 	= 0;
					$insert['flag_temp'] 	= 0;
					$insert['flag_posting'] = 0;
					$insert['keterangan'] 	= $uraian;
					$this->db->insert('akun.akmt_jurnal', $insert);
					
					$id_akmt_jurnal = $this->db->getLastID('akun.akmt_jurnal_id_akmt_jurnal_seq');
				}
				
				// --- nyimpen detailnya ---------------------				
								
				if (is_numeric($id_akdd_detail_coa)) {
					$insert 					  = array();
					$insert['id_akmt_jurnal'] 	  = $id_akmt_jurnal;
					$insert['id_akdd_detail_coa'] = $id_akdd_detail_coa;
					$insert['jumlah'] 			  = numValue($jumlah);
					$insert['flag_position'] 	  = $flag_position;
					$this->db->insert('akun.akmt_jurnal_det', $insert);
					
				}
				$this->setFinish($id_akmt_jurnal);
								
				$this->db->endTrans();
				
				$this->session->set_flashdata('id_akmt_jurnal', $id_akmt_jurnal);
								
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menyimpan data jurnal\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/akun/jurnal' . (!empty($metodenya) ? ('/' . $metodenya) : ''));
		}
		
		public function edit($metodenya, $id_akmt_jurnal_det, $id_akmt_jurnal) {
			$this->password->getUrlAccess('/akun/jurnal', 'edit');
			
			$this->load->helper('number');
			$jurnal_detail = $this->db->getRow('
											   SELECT
											   a.jumlah,
											   a.flag_position,
											   b.id_akdd_detail_coa,
											   b.coa_number,
											   b.uraian
											   FROM
											   akun.akmt_jurnal_det a
											   INNER JOIN akun.akdd_detail_coa b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
											   WHERE
											   a.id_akmt_jurnal_det = ?
											   ', array($id_akmt_jurnal_det));
			$data		       			= array();
			$data['title'] 	   			= 'Edit Akun';
			$data['id_akmt_jurnal_det'] = $id_akmt_jurnal_det;
			$data['id_akmt_jurnal']		= $id_akmt_jurnal;
			$data['jurnal_detail']		= $jurnal_detail;
			$data['metodenya']			= $metodenya;
			$this->load->viewPage('akun/jurnal_umum_edit', $data);					
		}
		
		public function editAct() {
			$this->password->getUrlAccess('/akun/jurnal', 'edit');
			
			try {
				$this->load->helper('number');
				
				$this->db->beginTrans();

				$id_akdd_detail_coa = $this->getVar('id_akdd_detail_coa', TRUE);
				$jumlah 			= $this->getVar('jumlah', TRUE);
				$flag_position 		= $this->getVar('flag_position', TRUE);
				$id_akmt_jurnal 	= $this->getVar('id_akmt_jurnal', TRUE);
				$id_akmt_jurnal_det = $this->getVar('id_akmt_jurnal_det', TRUE);
				
				$update 					  = array();
				$update['id_akdd_detail_coa'] = $id_akdd_detail_coa;
				$update['jumlah'] 			  = numValue($jumlah);
				$update['flag_position']	  = $flag_position;
				$this->db->update('akun.akmt_jurnal_det', $update, 'id_akmt_jurnal_det = ?', array($id_akmt_jurnal_det));
								
				$this->setFinish($id_akmt_jurnal);
								
				$this->db->endTrans();
				
				$this->session->set_flashdata('id_akmt_jurnal', $id_akmt_jurnal);
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat merubah data detail jurnal\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}		
		}
		
		private function setFinish($id_akmt_jurnal, $approval = false) {
			$data = $this->db->getRow("
									  SELECT 
									  sum((CASE WHEN flag_position = 'd' THEN 1 ELSE -1 END) * jumlah) AS balans,
									  count(*) AS total
									  FROM 
									  akun.akmt_jurnal_det 
									  WHERE 
									  id_akmt_jurnal = ?
									  ", array($id_akmt_jurnal));
			
			if ((floatval($data['balans']) == 0) && ($data['total'] > 0)) {
				$update 			 = array();				
				if ($approval) 
					$update['flag_temp'] = 2;
				else
					$update['flag_temp'] = 1;				
				$this->db->update('akun.akmt_jurnal', $update, 'id_akmt_jurnal = ?', array($id_akmt_jurnal));
			} else {
				$update 			 = array();
				$update['flag_temp'] = 0;
				$this->db->update('akun.akmt_jurnal', $update, 'id_akmt_jurnal = ?', array($id_akmt_jurnal));
			}
		}
		
		public function voucher($id_akmt_jurnal) {
			$this->password->getUrlAccess('/akun/jurnal', 'cetak');
			
			$this->load->helper('date');
			$this->load->helper('number');
			
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
			
			$this->report->Image($this->getImgFolder() . '/logo.jpg', 15, 8, 21);
			
			$this->report->Ln(5);
			
			$this->report->SetFont('Arial', 'B', 12);
			$this->report->MultiCell(0, 0, 'VOUCHER JURNAL UMUM', 0, 'R');
			
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
		
		public function report($masuk_keluar, $tgl_1, $tgl_2, $keyword = '') {
			$this->password->getUrlAccess('/akun/jurnal', 'cetak');

			/**************************** BEGIN HEAD ****************************/

			$mainCols = array();

			$arrCol = array();
			$arrCol['title'] = 'NO.';
			$arrCol['width'] = 10;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'NO. BUKTI';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'TANGGAL';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'KODE AKUN';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrSubCols = array();
			
			$arrSubCol = array();
			$arrSubCol['title'] = 'DEBET';
			$arrSubCol['width'] = 30;
			$arrSubCol['align'] = 'C';
			$arrSubCol['calign'] = 'R';
			$arrSubCol['span'] = 1;
			$arrSubCol['sub'] = null;

			array_push($arrSubCols, $arrSubCol);
			
			$arrSubCol = array();
			$arrSubCol['title'] = 'KREDIT';
			$arrSubCol['width'] = 30;
			$arrSubCol['align'] = 'C';
			$arrSubCol['calign'] = 'R';
			$arrSubCol['span'] = 1;
			$arrSubCol['sub'] = null;

			array_push($arrSubCols, $arrSubCol);			

			$arrCol = array();
			$arrCol['title'] = 'JUMLAH';
			$arrCol['width'] = 60;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 1;
			$arrCol['sub'] = $arrSubCols;

			array_push($mainCols, $arrCol);

			/**************************** END HEAD ****************************/
			
			$params = array();
			$params['arrHead'] = $mainCols;
			$params['orientation'] = 'P';
			$params['format'] = 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');
			$this->load->helper('number');

			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(25);

			$this->report->SetReportMainTitle('LAPORAN JURNAL PENERIMAAN UMUM');
			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->Open();
			$this->report->AddPage();

			/**************************** BEGIN CONTENT ****************************/
			
			
			// Default where...
			$sql_plus = '1=1';
			$params   = array();			

			// Keyword checking...
			if (!empty($keyword)) {
				$low_keyword = strtolower($keyword);
				$sql_plus = 'lower(a.no_bukti) LIKE ? OR lower(a.keterangan) LIKE ?';
				$params[] = "%{$low_keyword}%";
				$params[] = "%{$low_keyword}%";
			}
									
			if (!empty($tgl_1)) {
				$sql_plus .= ' AND a.tanggal BETWEEN ? AND ?';
				$params[]  = $tgl_1;
				$params[]  = $tgl_2;
			}
			
			switch ($masuk_keluar) {
				case 'm':
					$rPrefix = $this->db->getRows("SELECT kode FROM akun.akdd_kodifikasi_jurnal WHERE id_akdd_kodifikasi_jurnal IN (1)");
					break;
				case 'k':
					$rPrefix = $this->db->getRows("SELECT kode FROM akun.akdd_kodifikasi_jurnal WHERE id_akdd_kodifikasi_jurnal IN (2)");
					break;
				default:
					$rPrefix = $this->db->getRows("SELECT kode FROM akun.akdd_kodifikasi_jurnal WHERE id_akdd_kodifikasi_jurnal IN (3, 4, 5, 6)");
					break;
			}
			$sqlprefix = "";
			foreach ($rPrefix as $r)
				$sqlprefix .= (strlen($sqlprefix) > 0 ? " OR " : "") . "a.no_bukti LIKE '{$r['kode']}%'";
			if (strlen($sqlprefix) > 0)
				$sql_plus .= " AND ({$sqlprefix})";			
			
			$sql = "
				   SELECT
				   a.*,
				   b.id_akmt_jurnal_det,
				   b.jumlah,
				   b.flag_position,
				   c.id_akdd_detail_coa,
				   c.coa_number,
				   c.uraian
				   FROM
				   akun.akmt_jurnal a
				   LEFT JOIN akun.akmt_jurnal_det b ON a.id_akmt_jurnal = b.id_akmt_jurnal
				   LEFT JOIN akun.akdd_detail_coa c ON b.id_akdd_detail_coa = c.id_akdd_detail_coa
				   WHERE
				   a.flag_jurnal = 0
				   AND
				   {$sql_plus}		
				   ORDER BY
				   a.flag_temp,
				   a.tanggal DESC,
				   a.no_bukti ASC,
				   b.flag_position
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i 	  = 1;
			$prev = '';
			foreach ($rows as $row) {
			
				if ($prev != $row['id_akmt_jurnal']) {
					$prev = $row['id_akmt_jurnal'];
				} else {
					$row['no_bukti'] = '';
					$row['tanggal']  = '';
				}
				
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['no_bukti'];
				$arrData[] = (empty($row['tanggal']) ? '' : getLocalDate($row['tanggal']));
				$arrData[] = $row['coa_number'] . ' - ' . $row['uraian'];
				$arrData[] = ($row['flag_position'] == 'd' ? numFormat($row['jumlah']) : '-');
				$arrData[] = ($row['flag_position'] == 'k' ? numFormat($row['jumlah']) : '-');
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		
		}		
	}
	
/* End of file jurnal.php */
/* Location: ./system/application/controllers/akun/jurnal.php */
