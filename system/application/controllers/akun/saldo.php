<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Saldo extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'akun::Saldo Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			// Load helper...
			$this->load->helper('number');

			// Periksa periode posting selain saldo awal
			$flag_posted = $this->db->getField('flag_posted', 'SELECT COUNT(*) AS flag_posted FROM akun.akmt_periode WHERE bulan <> 0');
			
			$arr_tahun = array();
			for ($i = (date('Y') - 1); $i <= date('Y'); $i++) {
				$arr_tahun[] = $i;
			}			
			
			// Max level
			$max_level = $this->db->getField('max_level', 'SELECT max(level_number) AS max_level FROM akun.akdd_level_coa');
			
			if (is_numeric($max_level)) {

				// Get tahun saldo awal
				$row = $this->db->getRow('
					SELECT
					id_akmt_periode,
					tahun
					FROM
					akun.akmt_periode
					WHERE
					bulan = 0
					ORDER BY
					tahun ASC,
					bulan ASC
				');
				
				if (count($row) > 0) {
					$tahun_sa 		 = $row['tahun'];
					$id_akmt_periode = $row['id_akmt_periode'];
				} else {
					$tahun_sa 		 = null;
					$id_akmt_periode = null;
				}
				
				// Default where...
				$sql_plus = 'id_akdd_main_coa IN (1, 2, 3) AND level_number = ?';
				$params   = array();
				$params[] = $max_level;			

				if (is_numeric($id_akmt_periode)) {
					if ($flag_posted > 0) {
						$sql_plus .= ' AND id_akmt_periode = ?';
						$params[] = $id_akmt_periode;
					}
				} else
					$tahun_sa = date('Y');

				// Tahun saldo...	
				$tahun = $tahun_sa;
				
				$rows =& $this->db->getRows("
				SELECT
				*
				FROM
				akun.akmt_buku_besar_periode_v
				WHERE
				{$sql_plus}
				ORDER BY
				coa_number
				",
				$params
				);

		
			} else {
			
				$rows 			 = array();
				$tahun_sa 		 = null;
				$id_akmt_periode = null;
			
			}

			$data 					 = array();
			$data['rows']  	     	 = $rows;
			$data['tahun_sa']    	 = $tahun_sa;
			$data['arr_tahun']   	 = $arr_tahun;
			$data['flag_posted'] 	 = $flag_posted;
			$data['id_akmt_periode'] = $id_akmt_periode;
			$this->load->viewPage('akun/list_saldo', $data);					
		}
		
		public function process() {
			$this->password->getUrlAccess('/akun/saldo', 'proses');
			
			// Load helper...
			$this->load->helper('number');
		
			try {
				$this->db->beginTrans();
				
				$id_akmt_periode 	= $this->getVar('id_akmt_periode', TRUE);
				$tahun				= $this->getVar('tahun', TRUE);
				$id_akdd_detail_coa	= $this->getVar('id_akdd_detail_coa', TRUE);
				$acc_type			= $this->getVar('acc_type', TRUE);
				$nominal			= $this->getVar('nominal', TRUE);
				
				
				if (is_numeric($id_akmt_periode)) {
					$update 			 = array();
					$update['tahun'] 	 = $tahun;
					$update['bulan'] 	 = 0;
					$update['uraian'] 	 = 'Saldo awal ' . $tahun;
					$update['flag_temp'] = 2;
					$this->db->update('akun.akmt_periode', $update, 'id_akmt_periode = ?', array($id_akmt_periode));
				} else {
					$insert 			 = array();
					$insert['tahun'] 	 = $tahun;
					$insert['bulan'] 	 = 0;
					$insert['uraian'] 	 = 'Saldo awal ' . $tahun;
					$insert['flag_temp'] = 2;
					$this->db->insert('akun.akmt_periode', $insert);
					
					$id_akmt_periode = $this->db->getLastID('akun.akmt_periode_id_akmt_periode_seq');
				}
				
				$this->db->delete('akun.akmt_buku_besar', 'id_akmt_periode = ?', array($id_akmt_periode));
				
				$this->db->resetSequence('akun.akmt_buku_besar', 'id_akmt_periode', 'akun.akmt_periode_id_akmt_periode_seq');
				
				foreach ($id_akdd_detail_coa as $key => $id) {
					$saldo = numValue($nominal[$key]);
					$saldo = ((floatval($saldo) == 0) ? 0 : ($saldo * (($acc_type[$key] == 'd') ? 1 : -1)));
					$insert 					  = array();
					$insert['id_akmt_periode'] 	  = $id_akmt_periode;
					$insert['id_akdd_detail_coa'] = $id;
					$insert['no_bukti'] 		  = 'Saldo awal ' . $tahun;
					$insert['tanggal'] 			  = $tahun . '-01-01';
					$insert['keterangan'] 		  = 'Saldo awal ' . $tahun;
					$insert['awal'] 			  = $saldo;
					$insert['mutasi_debet'] 	  = 0;
					$insert['mutasi_kredit'] 	  = 0;
					$insert['akhir'] 			  = $saldo;
					$this->db->insert('akun.akmt_buku_besar', $insert);
				}
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memproses saldo awal\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}			
		}
		
		public function report() {
			$this->password->getUrlAccess('/akun/saldo', 'cetak');
		
			// Load helper...
			$this->load->helper('number');

		
			/**************************** BEGIN HEAD ****************************/

			$main_cols = array();

			$arr_col = array();
			$arr_col['title'] = 'NO.';
			$arr_col['width'] = 10;
			$arr_col['align'] = 'C';
			$arr_col['calign'] = 'R';
			$arr_col['span'] = 2;
			$arr_col['sub'] = null;

			array_push($main_cols, $arr_col);

			$arr_col = array();
			$arr_col['title'] = 'KODE PERKIRAAN';
			$arr_col['width'] = 150;
			$arr_col['align'] = 'C';
			$arr_col['calign'] = 'L';
			$arr_col['span'] = 2;
			$arr_col['sub'] = null;

			array_push($main_cols, $arr_col);

			$arr_col = array();
			$arr_col['title'] = 'NOMINAL';
			$arr_col['width'] = 50;
			$arr_col['align'] = 'C';
			$arr_col['calign'] = 'R';
			$arr_col['span'] = 2;
			$arr_col['sub'] = null;

			array_push($main_cols, $arr_col);
				
			/**************************** END HEAD ****************************/
			
			$params = array();
			$params['arrHead'] = $main_cols;
			$params['orientation'] = 'P';
			$params['format'] = 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');

			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(12);

			$this->report->SetReportMainTitle('LAPORAN SALDO AWAL');
			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->Open();
			$this->report->AddPage();

			/**************************** BEGIN CONTENT ****************************/


			// Periksa periode posting selain saldo awal
			$flag_posted = $this->db->getField('flag_posted', 'SELECT COUNT(*) AS flag_posted FROM akun.akmt_periode WHERE bulan <> 0');

			// Max level
			$max_level = $this->db->getField('max_level', 'SELECT max(level_number) AS max_level FROM akun.akdd_level_coa');

			// Get tahun saldo awal
			$row = $this->db->getRow('
				SELECT
				id_akmt_periode,
				tahun
				FROM
				akun.akmt_periode
				WHERE
				bulan = 0
				ORDER BY
				tahun ASC,
				bulan ASC
			');
			
			if (count($row) > 0) {
				$tahun_sa 		 = $row['tahun'];
				$id_akmt_periode = $row['id_akmt_periode'];
			} else {
				$tahun_sa 		 = null;
				$id_akmt_periode = null;
			}
			
			// Default where...
			$sql_plus = 'id_akdd_main_coa IN (1, 2, 3) AND level_number = ?';
			$params   = array();
			$params[] = $max_level;			

			if (is_numeric($id_akmt_periode)) {
				if ($flag_posted > 0) {
					$sql_plus .= ' AND id_akmt_periode = ?';
					$params[] = $id_akmt_periode;
				}
			} else
				$tahun_sa = date('Y');

			// Tahun saldo...	
			$tahun = $tahun_sa;

			$arr_tahun = array();
			for ($i = (date('Y') - 1); $i <= date('Y'); $i++) {
				$arr_tahun[] = $i;
			}			
			
			$rows =& $this->db->getRows("
										SELECT
										*
										FROM
										akun.akmt_buku_besar_periode_v
										WHERE
										{$sql_plus}
										ORDER BY
										coa_number
										", $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['coa_number'] . ' - ' . $row['coa_uraian'];
				$arrData[] = numFormat($row['akhir'] * ($row['acc_type'] == 'd' ? 1 : -1));
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}
		
		public function posisiSaldo($year, $month) {
			$this->password->getUrlAccess('/akun/saldo', 'cetak');
			
			define('DEFAULT_LN', 6);
			define('INDENT_LN', 5);
			define('FONT_SIZE', 8);
			define('MARGIN_DEF', 25);
			define('LEFT_MARGIN', 15);
			define('NOMINAL_WD', 25);		
			
			$params 			   = array();
			$params['orientation'] = 'P';
			$params['format'] 	   = 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');
			$this->load->helper('number');
			
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg', 15);
			$this->report->SetReportMainTitle('POSISI SALDO AWAL');

			$current_width = $this->report->GetWidth();

			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			if (empty($month))
				$this->report->setReportTitle('PERIODE', $year);
			else
				$this->report->SetReportTitle('PERIODE', strtoupper(getMonthString($month) . ', ' . $year));
			
			$this->report->Open();
			$this->report->AddPage();
			
			$this->report->SetFontSize(FONT_SIZE);

			$start_x = $this->report->GetX();
			$start_y = $this->report->GetY();
			
			$left_width = $current_width - MARGIN_DEF - NOMINAL_WD;

			$this->report->SetFillColor(230, 230, 230);
			$this->report->Cell($left_width, DEFAULT_LN, 'KODE PERKIRAAN', 'TB', 0, 'C', 1);
			$this->report->SetFillColor(245, 245, 245);
			$this->report->Cell(0, DEFAULT_LN, 'NOMINAL (Rp.)', 'TB', 1, 'C', 1);

			$arr_level =& $this->db->getRows('
											 SELECT
											 level_number,
											 level_length
											 FROM
											 akun.akdd_level_coa
											 ORDER BY
											 level_number
											 ');
											 
			$max_length   = 0;
			$level_length = array();
			foreach ($arr_level as $level) {
				$level_length[$level['level_number']] = $level['level_length'] + (count($level_length) > 0 ? $level_length[$level['level_number'] - 1]: 0); 				
				$max_length += $level['level_length'];
			}			
			
			$arr_saldo =& $this->db->getRows('
											 SELECT
											 d.binary_code,
											 a.id_akdd_detail_coa,
											 d.acc_type,
											 c.level_number,
											 a.coa_number,
											 a.uraian,
											 b.akhir
											 FROM
											 akun.akdd_detail_coa a
											 LEFT JOIN (
												SELECT
												*
												FROM
												akun.akmt_buku_besar_periode_v 
												WHERE
												id_akmt_periode = (SELECT id_akmt_periode FROM akun.akmt_periode WHERE bulan = 0 ORDER BY id_akmt_periode ASC LIMIT 1)											 											 
											 ) b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
											 INNER JOIN akun.akdd_level_coa c ON a.id_akdd_level_coa = c.id_akdd_level_coa
											 INNER JOIN akun.akdd_main_coa d ON a.id_akdd_main_coa = d.id_akdd_main_coa
											 WHERE
											 d.binary_code IN (1, 2, 3)
											 ORDER BY
											 a.coa_number ASC
											 ');
			
			$arr_coa   = array();
			$arr_rekap = array();
			foreach ($arr_saldo as $saldo) {
				$code				= $saldo['binary_code'];
				$id_akdd_detail_coa = $saldo['id_akdd_detail_coa'];
				$acc_type			= $saldo['acc_type'];
				$level_number		= $saldo['level_number'];
				$coa_number			= $saldo['coa_number'];
				$uraian				= $saldo['uraian'];
				$akhir				= $saldo['akhir'];
				
				$arr_coa[$coa_number] = array('id' => $id_akdd_detail_coa,
											  'code' => $code,
											  'acc_type' => $acc_type,
											  'level' => $level_number,
											  'uraian' => $uraian,
											  'saldo' => $akhir);
											  
				if ($level_number > 1) {
					for ($i = ($level_number - 1); $i > 0; $i--) {
						$coa_rekap = str_pad(substr($coa_number, 0, $level_length[$i]), $max_length, '0');
						if (!isset($arr_rekap[$coa_rekap]))
							$arr_rekap[$coa_rekap] = 0;
						$arr_rekap[$coa_rekap] += floatval($akhir);
					}
				}
			}
				
			$asset 			 = 0;
			$kewajiban_saldo = 0;
			$prev_code		 = 0;
			foreach ($arr_coa as $coa => $value) {
				
				if (is_numeric($value['saldo'])) {
					if ($value['code'] == 1) {
						$asset += $value['saldo'] * ($value['acc_type'] == 'd' ? 1 : -1);
					} else {
						$kewajiban_saldo += $value['saldo'] * ($value['acc_type'] == 'd' ? 1 : -1);
					}
				} 
				
				if (($prev_code == 1) && ($value['code'] != 1)) {
					$this->report->SetX(LEFT_MARGIN);
					$this->report->Cell($left_width, DEFAULT_LN, 'TOTAL ASSET', 'TB', 0);
					if ($asset >= 0)
						$this->report->Cell(0, DEFAULT_LN, numFormat($asset), 'TB', 1, 'R');
					else
						$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($asset)) . ')', 'TB', 1, 'R');
				}
				
				$saldo = (is_numeric($value['saldo']) ? $value['saldo'] : $arr_rekap[$coa]) * ($value['acc_type'] == 'd' ? 1 : -1);

				$spasi = ($value['level'] - 1) * INDENT_LN;
				
				$this->report->SetX($spasi + LEFT_MARGIN);
				
				
				$this->report->Cell($left_width - $spasi, DEFAULT_LN, strtoupper($coa . '-' . $value['uraian']), 0, 0);
				if ($saldo >= 0)
					$this->report->Cell(0, DEFAULT_LN, numFormat($saldo), 0, 1, 'R');
				else
					$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($saldo)) . ')', 0, 1, 'R');
					
				$prev_code = $value['code'];
			}
			
			$this->report->SetX(LEFT_MARGIN);
			$this->report->Cell($left_width, DEFAULT_LN, 'TOTAL KEWAJIBAN & SALDO DANA', 'TB', 0);
			if ($kewajiban_saldo >= 0)
				$this->report->Cell(0, DEFAULT_LN, numFormat($kewajiban_saldo), 'TB', 1, 'R');
			else
				$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($kewajiban_saldo)) . ')', 'TB', 1, 'R');
						
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);//					
		}		
		
	}
	
/* End of file saldo.php */
/* Location: ./system/application/controllers/akun/saldo.php */
