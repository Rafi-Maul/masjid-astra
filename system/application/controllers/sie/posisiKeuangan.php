<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class PosisiKeuangan extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'sie::PosisiKeuangan Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			$this->load->helper('date');
			
			$arr_level =& $this->db->getRows('
											 SELECT
											 level_number
											 FROM
											 akun.akdd_level_coa
											 ORDER BY
											 level_number
											 ');
											 
			$arr_years =& $this->db->getRows('SELECT DISTINCT tahun FROM akun.akmt_periode ORDER BY tahun');
			
			$data 			   = array();
			$data['arr_level'] = $arr_level;
			$data['arr_years'] = $arr_years;
			$this->load->viewPage('sie/list_posisi', $data);							
		}
		
		public function level() {
			$this->password->getUrlAccess('/sie/posisiKeuangan', 'cetak');

			$kode_format	= $this->getVar('kode_format', TRUE);						
			$month 	   		= $this->getVar('month', TRUE);
			$year  	   		= $this->getVar('year', TRUE);
			$level_coa 		= $this->getVar('level_coa', TRUE);

			$this->load->library('Closing');			
			$this->closing->generate();
			
			if ($kode_format != 1) {
				$this->levelExcel($month, $year, $level_coa);
				exit(0);
			} 						
			
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
			
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg', 17);
			$this->report->SetReportMainTitle('LAPORAN POSISI KEUANGAN PER LEVEL PER PERIODE');

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
			
			$arr_saldo =& $this->db->getRows("
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
												id_akmt_buku_besar IN (
													SELECT
													MAX(id_akmt_buku_besar) AS id_akmt_buku_besar
													FROM
													akun.akmt_buku_besar
													WHERE
													id_akmt_periode = (SELECT id_akmt_periode FROM akun.akmt_periode WHERE (tahun::VARCHAR(4) || lpad(bulan::VARCHAR(2), 2, '0'))::INTEGER <= ? ORDER BY id_akmt_periode DESC LIMIT 1)
													GROUP BY
													id_akdd_detail_coa
												)
											 ) b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
											 INNER JOIN akun.akdd_level_coa c ON a.id_akdd_level_coa = c.id_akdd_level_coa
											 INNER JOIN akun.akdd_main_coa d ON a.id_akdd_main_coa = d.id_akdd_main_coa
											 WHERE
											 d.binary_code IN (1, 2, 3)
											 ORDER BY
											 a.coa_number ASC
											 ", array($year . str_pad($month, 2, '0', STR_PAD_LEFT)));
	
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
				
				$saldo = (is_numeric($value['saldo']) ? $value['saldo'] : (isset($arr_rekap[$coa]) ? $arr_rekap[$coa] : 0)) * ($value['acc_type'] == 'd' ? 1 : -1);

				$spasi = ($value['level'] - 1) * INDENT_LN;
				
				$this->report->SetX($spasi + LEFT_MARGIN);
				
				if ($value['level'] <= $level_coa) {
					$this->report->Cell($left_width - $spasi, DEFAULT_LN, strtoupper($coa . '-' . $value['uraian']), 0, 0);
					if ($saldo >= 0)
						$this->report->Cell(0, DEFAULT_LN, numFormat($saldo), 0, 1, 'R');
					else
						$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($saldo)) . ')', 0, 1, 'R');
				}
					
				$prev_code = $value['code'];
			}
			
			$this->report->SetX(LEFT_MARGIN);
			$this->report->Cell($left_width, DEFAULT_LN, 'TOTAL KEWAJIBAN & SALDO DANA', 'TB', 0);
			if ($kewajiban_saldo >= 0)
				$this->report->Cell(0, DEFAULT_LN, numFormat($kewajiban_saldo), 'TB', 1, 'R');
			else
				$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($kewajiban_saldo)) . ')', 'TB', 1, 'R');
						
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);								
		}
		
		private function levelExcel($month, $year, $level_coa) {
			$this->load->helper('date');
			$this->load->helper('number');
								
			/********************** BEGIN : GENERATE EXCEL **********************/
			$this->load->library('Excel');
			
			$objExcel = new Excel();
			
			$objExcel->setActiveSheetIndex(0)
					 ->mergeCells('A1:D1')
					 ->mergeCells('A5:C5');
					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A1:D1')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A5:D5')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 
			$objExcel->getActiveSheet()		
					 ->setCellValue('A1', 'LAPORAN POSISI KEUANGAN PER LEVEL PER PERIODE')
					 ->setCellValue('A3', 'TANGGAL CETAK')
					 ->setCellValue('A4', 'PERIODE')
					 ->setCellValue('B3', ':')
					 ->setCellValue('B4', ':')
					 ->setCellValue('C3', strtoupper(getCurrentDate(FALSE)))
					 ->setCellValue('C4', getMonthString($month) . ', ' . $year)
					 ->setCellValue('A5', 'KODE PERKIRAAN')
					 ->setCellValue('D5', 'NOMINAL (Rp.)')
					 ->setTitle('Report - Posisi Keuangan');
					 
					 					 
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
			
			$arr_saldo =& $this->db->getRows("
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
												id_akmt_buku_besar IN (
													SELECT
													MAX(id_akmt_buku_besar) AS id_akmt_buku_besar
													FROM
													akun.akmt_buku_besar
													WHERE
													id_akmt_periode = (SELECT id_akmt_periode FROM akun.akmt_periode WHERE (tahun::VARCHAR(4) || lpad(bulan::VARCHAR(2), 2, '0'))::INTEGER <= ? ORDER BY id_akmt_periode DESC LIMIT 1)
													GROUP BY
													id_akdd_detail_coa
												)
											 ) b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
											 INNER JOIN akun.akdd_level_coa c ON a.id_akdd_level_coa = c.id_akdd_level_coa
											 INNER JOIN akun.akdd_main_coa d ON a.id_akdd_main_coa = d.id_akdd_main_coa
											 WHERE
											 d.binary_code IN (1, 2, 3)
											 ORDER BY
											 a.coa_number ASC
											 ", array($year . str_pad($month, 2, '0', STR_PAD_LEFT)));
			
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
			$row			 = 6;
			foreach ($arr_coa as $coa => $value) {
				
				if (is_numeric($value['saldo'])) {
					if ($value['code'] == 1) {
						$asset += $value['saldo'] * ($value['acc_type'] == 'd' ? 1 : -1);
					} else {
						$kewajiban_saldo += $value['saldo'] * ($value['acc_type'] == 'd' ? 1 : -1);
					}
				} 
				
				if (($prev_code == 1) && ($value['code'] != 1)) {
					$objExcel->getActiveSheet()
							 ->setCellValue('A' . $row, 'TOTAL ASSET')
							 ->setCellValueExplicit('D' . $row++, $asset, PHPExcel_Cell_DataType::TYPE_NUMERIC);				
				}
				
				$saldo = (is_numeric($value['saldo']) ? $value['saldo'] : $arr_rekap[$coa]) * ($value['acc_type'] == 'd' ? 1 : -1);
				
				if ($value['level'] <= $level_coa) {
					$objExcel->getActiveSheet()
							 ->setCellValue('A' . $row, strtoupper($coa . '-' . $value['uraian']))
							 ->setCellValueExplicit('D' . $row++, $saldo, PHPExcel_Cell_DataType::TYPE_NUMERIC);
				}
					
				$prev_code = $value['code'];
			}
							
			$objExcel->getActiveSheet()
					 ->setCellValue('A' . $row, 'TOTAL KEWAJIBAN & SALDO DANA')
					 ->setCellValueExplicit('D' . $row++, $kewajiban_saldo, PHPExcel_Cell_DataType::TYPE_NUMERIC);

			$objExcel->showExcel($this->session->userdata('session_id') . '_' . time());
			/********************** END   : GENERATE EXCEL **********************/			
		}
		
		public function template() {			
			$this->password->getUrlAccess('/sie/posisiKeuangan', 'cetak');
			
			$kode_format	= $this->getVar('kode_format', TRUE);						
			$month 	   		= $this->getVar('month', TRUE);
			$year  	   		= $this->getVar('year', TRUE);

			$this->load->library('Closing');			
			$this->closing->generate();
			
			if ($kode_format != 1) {
				$this->templateExcel($month, $year);
				exit(0);
			} 						

			define('DEFAULT_LN', 6);
			define('INDENT_LN', 5);
			define('FONT_SIZE', 8);
			define('MARGIN_DEF', 25);
			define('LEFT_MARGIN', 15);
			define('NOMINAL_WD', 45);		
			
			$params 			   = array();
			$params['orientation'] = 'P';
			$params['format'] 	   = 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');
			$this->load->helper('number');
			
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg', 30);
			$this->report->SetReportMainTitle('LAPORAN POSISI KEUANGAN');

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
			$this->report->Cell($left_width, DEFAULT_LN, 'URAIAN', 'TB', 0, 'C', 1);
			$this->report->SetFillColor(245, 245, 245);
			$this->report->Cell(0, DEFAULT_LN, 'NOMINAL (Rp.)', 'TB', 1, 'C', 1);
			
			$sql =	"
					SELECT
					c.coa_number,
					a.akhir
					FROM
					akun.akmt_buku_besar a
					INNER JOIN (
						SELECT
						MAX(b1.id_akmt_buku_besar) AS id_akmt_buku_besar
						FROM
						akun.akmt_buku_besar b1
						INNER JOIN akun.akmt_periode b2 ON b1.id_akmt_periode = b2.id_akmt_periode
						WHERE
						b2.id_akmt_periode = (
							SELECT 
							id_akmt_periode 
							FROM 
							akun.akmt_periode 
							WHERE 
							(tahun::VARCHAR(4) || lpad(bulan::VARCHAR(2), 2, '0'))::INTEGER <= ? 
							ORDER BY 
							id_akmt_periode DESC 
							LIMIT 1)
						GROUP BY
						b1.id_akdd_detail_coa
					) b ON a.id_akmt_buku_besar = b.id_akmt_buku_besar
					INNER JOIN akun.akdd_detail_coa c ON a.id_akdd_detail_coa = c.id_akdd_detail_coa
					";
			
			$arr_saldo =& $this->db->getRows($sql, array($year . str_pad($month, 2, '0', STR_PAD_LEFT)));
			
			$arr_nominal = array();
			foreach ($arr_saldo as $saldo) {
				$coa_number = $saldo['coa_number'];
				$akhir		= $saldo['akhir'];
				
				$arr_nominal[$coa_number] = $akhir;
			}			

			$sql = 	"
					SELECT
					*
					FROM
					akun.akdd_posisi_keuangan
					ORDER BY
					order_number
					";
					
			$arr_templates =& $this->db->getRows($sql);
			
			$total 	   = 0;						
			$head  	   = '';
			$prev_type = '';
			foreach ($arr_templates as $template) {
				$id_akdd_posisi_keuangan 	 = $template['id_akdd_posisi_keuangan'];
				$id_akdd_posisi_keuangan_ref = $template['id_akdd_posisi_keuangan_ref'];
				$uraian 					 = $template['uraian'];
				$coa_range 					 = str_replace(' ', '', $template['coa_range']);
				$order_number 				 = $template['order_number'];
				$acc_type 					 = $template['acc_type'];
				
				$nominal = 0;
				
				$arr_coa = explode(',', $coa_range);				
				foreach ($arr_coa as $coa) {
					list($begin, $end) = explode('~', $coa);
					for ($i = $begin; $i <= $end; $i++) {
						$nominal += (isset($arr_nominal[$i]) ? $arr_nominal[$i] : 0);
					}
				}					

				$spasi = (strlen(trim($order_number, '0')) - 1) * INDENT_LN;				
				
				if ($spasi == 0) {
					if ($head != $uraian) {
						if ($head != '') {
							$this->report->SetX(LEFT_MARGIN);		
							$this->report->Cell($left_width - INDENT_LN, DEFAULT_LN, $head, 'TB', 0, 'L');							
							$total = $total * (($prev_type == 'd') ? 1 : -1);
							if ($total < 0) {
								$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($total)) . ')', 'TB', 1, 'R');
							} else {
								$this->report->Cell(0, DEFAULT_LN, numFormat($total), 'TB', 1, 'R');
							}		

							$total = 0;
						}
						$head 	   = $uraian;						
						$prev_type = $acc_type;
					} 
				}				
				
				$this->report->SetX($spasi + LEFT_MARGIN);
				
				$this->report->Cell($left_width - $spasi, DEFAULT_LN, $uraian, 0, 0);
				
				if ($spasi == 0) {						
					$total += $nominal;
				}				
				
				$nominal = $nominal * (($acc_type == 'd') ? 1 : -1);

				if ($nominal < 0) {
					$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($nominal)) . ')', 0, 1, 'R');
				} else {
					$this->report->Cell(0, DEFAULT_LN, numFormat($nominal), 0, 1, 'R');
				}		
				
			}
			
			$this->report->SetX(LEFT_MARGIN);		
			$this->report->Cell($left_width - INDENT_LN, DEFAULT_LN, $head, 'TB', 0, 'L');							
			$total = $total * (($prev_type == 'd') ? 1 : -1);
			if ($total < 0) {
				$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($total)) . ')', 'TB', 1, 'R');
			} else {
				$this->report->Cell(0, DEFAULT_LN, numFormat($total), 'TB', 1, 'R');
			}		
			
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);															
		}
		
		private function templateExcel($month, $year) {
			$this->load->helper('date');
			$this->load->helper('number');
								
			/********************** BEGIN : GENERATE EXCEL **********************/
			$this->load->library('Excel');
			
			$objExcel = new Excel();
			
			$objExcel->setActiveSheetIndex(0)
					 ->mergeCells('A1:D1')
					 ->mergeCells('A5:C5');
					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A1:D1')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A5:D5')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 
			$objExcel->getActiveSheet()		
					 ->setCellValue('A1', 'LAPORAN POSISI KEUANGAN')
					 ->setCellValue('A3', 'TANGGAL CETAK')
					 ->setCellValue('A4', 'PERIODE')
					 ->setCellValue('B3', ':')
					 ->setCellValue('B4', ':')
					 ->setCellValue('C3', strtoupper(getCurrentDate(FALSE)))
					 ->setCellValue('C4', getMonthString($month) . ', ' . $year)
					 ->setCellValue('A5', 'URAIAN')
					 ->setCellValue('D5', 'NOMINAL (Rp.)')
					 ->setTitle('Report - Posisi Keuangan');
					 
			$sql =	"
					SELECT
					c.coa_number,
					a.akhir
					FROM
					akun.akmt_buku_besar a
					INNER JOIN (
						SELECT
						MAX(b1.id_akmt_buku_besar) AS id_akmt_buku_besar
						FROM
						akun.akmt_buku_besar b1
						INNER JOIN akun.akmt_periode b2 ON b1.id_akmt_periode = b2.id_akmt_periode
						WHERE
						b2.id_akmt_periode = (
							SELECT 
							id_akmt_periode 
							FROM 
							akun.akmt_periode 
							WHERE 
							(tahun::VARCHAR(4) || lpad(bulan::VARCHAR(2), 2, '0'))::INTEGER <= ? 
							ORDER BY 
							id_akmt_periode DESC 
							LIMIT 1)
						GROUP BY
						b1.id_akdd_detail_coa
					) b ON a.id_akmt_buku_besar = b.id_akmt_buku_besar
					INNER JOIN akun.akdd_detail_coa c ON a.id_akdd_detail_coa = c.id_akdd_detail_coa
					";
			
			$arr_saldo =& $this->db->getRows($sql, array($year . str_pad($month, 2, '0', STR_PAD_LEFT)));
			
			$arr_nominal = array();
			foreach ($arr_saldo as $saldo) {
				$coa_number = $saldo['coa_number'];
				$akhir		= $saldo['akhir'];
				
				$arr_nominal[$coa_number] = $akhir;
			}			

			$sql = 	"
					SELECT
					*
					FROM
					akun.akdd_posisi_keuangan
					ORDER BY
					order_number
					";
					
			$arr_templates =& $this->db->getRows($sql);
			
			$total 	   = 0;						
			$head  	   = '';
			$prev_type = '';
			$row	   = 6;
			foreach ($arr_templates as $template) {
				$id_akdd_posisi_keuangan 	 = $template['id_akdd_posisi_keuangan'];
				$id_akdd_posisi_keuangan_ref = $template['id_akdd_posisi_keuangan_ref'];
				$uraian 					 = $template['uraian'];
				$coa_range 					 = str_replace(' ', '', $template['coa_range']);
				$order_number 				 = $template['order_number'];
				$acc_type 					 = $template['acc_type'];
				
				$nominal = 0;
				
				$arr_coa = explode(',', $coa_range);				
				foreach ($arr_coa as $coa) {
					list($begin, $end) = explode('~', $coa);
					for ($i = $begin; $i <= $end; $i++) {
						$nominal += (isset($arr_nominal[$i]) ? $arr_nominal[$i] : 0);
					}
				}					

				$spasi = (strlen(trim($order_number, '0')) - 1);				
				
				if ($spasi == 0) {
					if ($head != $uraian) {
						if ($head != '') {
							$total = $total * (($prev_type == 'd') ? 1 : -1);
							$objExcel->getActiveSheet()
									 ->setCellValue('A' . $row, $head)
									 ->setCellValueExplicit('D' . $row++, $total, PHPExcel_Cell_DataType::TYPE_NUMERIC);
													
							$total = 0;
						}
						$head 	   = $uraian;						
						$prev_type = $acc_type;
					} 
				}				

				if ($spasi == 0) {						
					$total += $nominal;
				}				
				
				$nominal = $nominal * (($acc_type == 'd') ? 1 : -1);
				
				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $row, $uraian)
						 ->setCellValueExplicit('D' . $row++, $nominal, PHPExcel_Cell_DataType::TYPE_NUMERIC);
			}
						
			$total = $total * (($prev_type == 'd') ? 1 : -1);			
			$objExcel->getActiveSheet()
					 ->setCellValue('A' . $row, $head)
					 ->setCellValueExplicit('D' . $row++, $total, PHPExcel_Cell_DataType::TYPE_NUMERIC);
					 
			$objExcel->showExcel($this->session->userdata('session_id') . '_' . time());
			/********************** END   : GENERATE EXCEL **********************/						 
		}
		
	}
	
/* End of file posisiKeuangan.php */
/* Location: ./system/application/controllers/sie/posisiKeuangan.php */		
