<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class ArusKas extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'sie::ArusKas Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			$this->load->helper('date');

			$arr_years =& $this->db->getRows('SELECT DISTINCT tahun FROM akun.akmt_periode ORDER BY tahun');
			
			$data 			   = array();
			$data['arr_years'] = $arr_years;
			$this->load->viewPage('sie/list_kas', $data);												
		}
		
		public function kas() {
			$this->password->getUrlAccess('/sie/arusKas', 'cetak');
			
			$kode_format	= $this->getVar('kode_format', TRUE);									
			$month 	   		= $this->getVar('month', TRUE);
			$year  	   		= $this->getVar('year', TRUE);

			$this->load->library('Closing');			
			$this->closing->generate();
			
			if ($kode_format != 1) {
				$this->kasExcel($month, $year);
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
			
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg', 17);
			$this->report->SetReportMainTitle('LAPORAN ARUS KAS');

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
			
			/************************ BEGIN : SALDO AWAL PERIODE ************************/	
			
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
						INNER JOIN akun.akdd_detail_coa b3 ON b1.id_akdd_detail_coa = b3.id_akdd_detail_coa
						INNER JOIN akun.akdd_main_coa b4 ON b3.id_akdd_main_coa = b4.id_akdd_main_coa
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
						AND
						b4.binary_code IN (1, 2, 3)
						GROUP BY
						b1.id_akdd_detail_coa
					) b ON a.id_akmt_buku_besar = b.id_akmt_buku_besar
					INNER JOIN akun.akdd_detail_coa c ON a.id_akdd_detail_coa = c.id_akdd_detail_coa
					";

			$arr_saldo =& $this->db->getRows($sql, array($year . '00'));
			
			$arr_nominal0 = array();
			foreach ($arr_saldo as $saldo) {
				$coa_number = $saldo['coa_number'];
				$akhir		= $saldo['akhir'];
				
				$arr_nominal0[$coa_number] = array('akhir' => $akhir);
			}			

			/************************ END : SALDO AWAL PERIODE ************************/
			
			$sql =	"
					SELECT
					c.coa_number,
					b.mutasi_debet,
					b.mutasi_kredit,
					a.akhir
					FROM
					akun.akmt_buku_besar a
					INNER JOIN (
						SELECT
						MAX(b1.id_akmt_buku_besar) AS id_akmt_buku_besar,
						SUM(b1.mutasi_debet) AS mutasi_debet,
						SUM(b1.mutasi_kredit) AS mutasi_kredit
						FROM
						akun.akmt_buku_besar b1
						INNER JOIN akun.akmt_periode b2 ON b1.id_akmt_periode = b2.id_akmt_periode
						WHERE
						b2.id_akmt_periode IN (
								SELECT 
								id_akmt_periode 
								FROM 
								akun.akmt_periode 
								WHERE 
								(tahun::VARCHAR(4) || lpad(bulan::VARCHAR(2), 2, '0'))::INTEGER >= ? 
								AND
								(tahun::VARCHAR(4) || lpad(bulan::VARCHAR(2), 2, '0'))::INTEGER <= ? 
							)
						GROUP BY
						b1.id_akdd_detail_coa
					) b ON a.id_akmt_buku_besar = b.id_akmt_buku_besar
					INNER JOIN akun.akdd_detail_coa c ON a.id_akdd_detail_coa = c.id_akdd_detail_coa
					";

			$arr_saldo =& $this->db->getRows($sql, array($year . '00', $year . str_pad($month, 2, '0', STR_PAD_LEFT)));
			
			$arr_nominal = array();
			foreach ($arr_saldo as $saldo) {
				$coa_number = $saldo['coa_number'];
				$debet		= $saldo['mutasi_debet'];
				$kredit		= $saldo['mutasi_kredit'];				
				$akhir		= $saldo['akhir'];
				
				$arr_nominal[$coa_number] = array('debet' => $debet, 'kredit' => $kredit, 'akhir' => $akhir);
			}						
			
			$sql = 	"
					SELECT
					*
					FROM
					akun.akdd_arus_kas
					ORDER BY
					order_number
					";
					
			$arr_templates =& $this->db->getRows($sql);
			
			$total = 0;		
			$awal  = 0;
			$akhir = 0;
			$prev  = '';
			foreach ($arr_templates as $key => $template) {
				$id_akdd_arus_kas 	  = $template['id_akdd_arus_kas'];
				$id_akdd_arus_kas_ref = $template['id_akdd_arus_kas_ref'];
				$uraian 			  = $template['uraian'];
				$coa_range 			  = str_replace(' ', '', $template['coa_range']);
				$order_number 		  = $template['order_number'];
				$kalkulasi 			  = $template['kalkulasi'];
				$kalibrasi 			  = $template['kalibrasi'];
				
				$seri = substr($order_number, 0, 1);
				
				switch ($seri) {
					case 1 :
					case 2 :
					case 3 :
						$nominal = 0;
						
						$arr_coa = explode(',', $coa_range);				
						foreach ($arr_coa as $coa) {
							list($begin, $end) = explode('~', $coa);
							for ($i = $begin; $i <= $end; $i++) {
								if ($kalkulasi == 'a')
									$nominal += (isset($arr_nominal[$i]['akhir']) ? $arr_nominal[$i]['akhir'] : 0);
								else if ($kalkulasi == 'b')
									$nominal += ((isset($arr_nominal[$i]['akhir']) ? $arr_nominal[$i]['akhir'] : 0) - (isset($arr_nominal0[$i]['akhir']) ? $arr_nominal0[$i]['akhir'] : 0));
								else if ($kalkulasi == 'c')
									$nominal += (isset($arr_nominal[$i]['debet']) ? $arr_nominal[$i]['debet'] : 0);
								else if ($kalkulasi == 'd')
									$nominal += (isset($arr_nominal[$i]['kredit']) ? $arr_nominal[$i]['kredit'] : 0);
								else
									die('Weird !!!');
							}
						}			
						
						if ($prev != $seri) {
							$this->report->SetX(LEFT_MARGIN);
							switch ($seri) {
								case 1 :
									$head = 'AKTIVITAS OPERASI';
									break;
								case 2 :
									$head = 'AKTIVITAS INVESTASI';
									break;
								case 3 :
									$head = 'AKTIVITAS PENDANAAN';
									break;
								default :
									show_error('Invalid');
							}
							$this->report->Cell($left_width, DEFAULT_LN, $head, 0, 1);
							$prev = $seri;
						}

						$spasi = (strlen(trim($order_number, '0')) - 1) * INDENT_LN;
						$this->report->SetX($spasi + LEFT_MARGIN);
						
						$this->report->Cell($left_width - $spasi, DEFAULT_LN, $uraian, 0, 0);
						
						$nominal *= $kalibrasi;
						
						if ($nominal < 0) {
							$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($nominal)) . ')', 0, 1, 'R');
						} else {
							$this->report->Cell(0, DEFAULT_LN, numFormat($nominal), 0, 1, 'R');
						}								
						
						$total += $nominal;
						break;
					case 4 :
						$this->report->Ln(2);
						
						$spasi = 0;
						$this->report->SetX($spasi + LEFT_MARGIN);
						
						$this->report->Cell($left_width - $spasi, DEFAULT_LN, strtoupper($uraian), 0, 0);
						
						$total *= $kalibrasi;
						
						if ($total < 0) {
							$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($total)) . ')', 0, 1, 'R');
						} else {
							$this->report->Cell(0, DEFAULT_LN, numFormat($total), 0, 1, 'R');
						}														
						break;
					case 5 :
						$nominal = 0;
						
						$arr_coa = explode(',', $coa_range);				
						foreach ($arr_coa as $coa) {
							list($begin, $end) = explode('~', $coa);
							for ($i = $begin; $i <= $end; $i++) {
								$nominal += (isset($arr_nominal0[$i]['akhir']) ? $arr_nominal0[$i]['akhir'] : 0);
							}
						}			

						$this->report->Ln(2);
						
						$spasi = 0;
						$this->report->SetX($spasi + LEFT_MARGIN);
						
						$this->report->Cell($left_width - $spasi, DEFAULT_LN, strtoupper($uraian), 0, 0);
						
						$nominal *= $kalibrasi;
						
						if ($nominal < 0) {
							$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($nominal)) . ')', 0, 1, 'R');
						} else {
							$this->report->Cell(0, DEFAULT_LN, numFormat($nominal), 0, 1, 'R');
						}			

						$awal = $nominal;
						break;
					case 6 :
						$nominal = 0;
						
						$arr_coa = explode(',', $coa_range);				
						foreach ($arr_coa as $coa) {
							list($begin, $end) = explode('~', $coa);
							for ($i = $begin; $i <= $end; $i++) {
								$nominal += (isset($arr_nominal[$i]['akhir']) ? $arr_nominal[$i]['akhir'] : 0);
							}
						}			

						$this->report->Ln(2);
						
						$spasi = 0;
						$this->report->SetX($spasi + LEFT_MARGIN);
						
						$this->report->Cell($left_width - $spasi, DEFAULT_LN, strtoupper($uraian), 0, 0);
						
						$nominal *= $kalibrasi;
						
						if ($nominal < 0) {
							$this->report->Cell(0, DEFAULT_LN, '(' . numFormat(abs($nominal)) . ')', 0, 1, 'R');
						} else {
							$this->report->Cell(0, DEFAULT_LN, numFormat($nominal), 0, 1, 'R');
						}				

						$akhir = $nominal;
						break;
					default :
						show_error('Invalid !!!');
				}
			}
			
			/*if (numFormat($total + $awal) != numFormat($akhir)) {
				$this->report->Ln();
				$this->report->Cell($left_width, DEFAULT_LN, '*) Terdapat selisih, periksa kembali template laporan, saldo kas & setara kas akhir seharusnya Rp. ' . numFormat($total + $awal), 0, 0);
			}*/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);															
		}
		
		private function kasExcel($month, $year) {
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
					 ->setCellValue('A1', 'LAPORAN ARUS KAS')
					 ->setCellValue('A3', 'TANGGAL CETAK')
					 ->setCellValue('A4', 'PERIODE')
					 ->setCellValue('B3', ':')
					 ->setCellValue('B4', ':')
					 ->setCellValue('C3', strtoupper(getCurrentDate(FALSE)))
					 ->setCellValue('C4', getMonthString($month) . ', ' . $year)
					 ->setCellValue('A5', 'URAIAN')
					 ->setCellValue('D5', 'NOMINAL (Rp.)')
					 ->setTitle('Report - Arus Kas');
					 
			/************************ BEGIN : SALDO AWAL PERIODE ************************/	
			
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
						INNER JOIN akun.akdd_detail_coa b3 ON b1.id_akdd_detail_coa = b3.id_akdd_detail_coa
						INNER JOIN akun.akdd_main_coa b4 ON b3.id_akdd_main_coa = b4.id_akdd_main_coa
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
						AND
						b4.binary_code IN (1, 2, 3)
						GROUP BY
						b1.id_akdd_detail_coa
					) b ON a.id_akmt_buku_besar = b.id_akmt_buku_besar
					INNER JOIN akun.akdd_detail_coa c ON a.id_akdd_detail_coa = c.id_akdd_detail_coa
					";

			$arr_saldo =& $this->db->getRows($sql, array($year . '00'));
			
			$arr_nominal0 = array();
			foreach ($arr_saldo as $saldo) {
				$coa_number = $saldo['coa_number'];
				$akhir		= $saldo['akhir'];
				
				$arr_nominal0[$coa_number] = array('akhir' => $akhir);
			}			

			/************************ END : SALDO AWAL PERIODE ************************/
			
			$sql =	"
					SELECT
					c.coa_number,
					b.mutasi_debet,
					b.mutasi_kredit,
					a.akhir
					FROM
					akun.akmt_buku_besar a
					INNER JOIN (
						SELECT
						MAX(b1.id_akmt_buku_besar) AS id_akmt_buku_besar,
						SUM(b1.mutasi_debet) AS mutasi_debet,
						SUM(b1.mutasi_kredit) AS mutasi_kredit
						FROM
						akun.akmt_buku_besar b1
						INNER JOIN akun.akmt_periode b2 ON b1.id_akmt_periode = b2.id_akmt_periode
						WHERE
						b2.id_akmt_periode IN (
								SELECT 
								id_akmt_periode 
								FROM 
								akun.akmt_periode 
								WHERE 
								(tahun::VARCHAR(4) || lpad(bulan::VARCHAR(2), 2, '0'))::INTEGER >= ? 
								AND
								(tahun::VARCHAR(4) || lpad(bulan::VARCHAR(2), 2, '0'))::INTEGER <= ? 
							)
						GROUP BY
						b1.id_akdd_detail_coa
					) b ON a.id_akmt_buku_besar = b.id_akmt_buku_besar
					INNER JOIN akun.akdd_detail_coa c ON a.id_akdd_detail_coa = c.id_akdd_detail_coa
					";

			$arr_saldo =& $this->db->getRows($sql, array($year . '00', $year . str_pad($month, 2, '0', STR_PAD_LEFT)));
			
			$arr_nominal = array();
			foreach ($arr_saldo as $saldo) {
				$coa_number = $saldo['coa_number'];
				$debet		= $saldo['mutasi_debet'];
				$kredit		= $saldo['mutasi_kredit'];				
				$akhir		= $saldo['akhir'];
				
				$arr_nominal[$coa_number] = array('debet' => $debet, 'kredit' => $kredit, 'akhir' => $akhir);
			}						
			
			$sql = 	"
					SELECT
					*
					FROM
					akun.akdd_arus_kas
					ORDER BY
					order_number
					";
					
			$arr_templates =& $this->db->getRows($sql);
			
			$total = 0;		
			$awal  = 0;
			$akhir = 0;
			$prev  = '';
			$row   = 6;
			foreach ($arr_templates as $key => $template) {
				$id_akdd_arus_kas 	  = $template['id_akdd_arus_kas'];
				$id_akdd_arus_kas_ref = $template['id_akdd_arus_kas_ref'];
				$uraian 			  = $template['uraian'];
				$coa_range 			  = str_replace(' ', '', $template['coa_range']);
				$order_number 		  = $template['order_number'];
				$kalkulasi 			  = $template['kalkulasi'];
				$kalibrasi 			  = $template['kalibrasi'];
				
				$seri = substr($order_number, 0, 1);
				
				switch ($seri) {
					case 1 :
					case 2 :
					case 3 :
						$nominal = 0;
						
						$arr_coa = explode(',', $coa_range);				
						foreach ($arr_coa as $coa) {
							list($begin, $end) = explode('~', $coa);
							for ($i = $begin; $i <= $end; $i++) {
								if ($kalkulasi == 'a')
									$nominal += (isset($arr_nominal[$i]['akhir']) ? $arr_nominal[$i]['akhir'] : 0);
								else if ($kalkulasi == 'b')
									$nominal += ((isset($arr_nominal[$i]['akhir']) ? $arr_nominal[$i]['akhir'] : 0) - (isset($arr_nominal0[$i]['akhir']) ? $arr_nominal0[$i]['akhir'] : 0));
								else if ($kalkulasi == 'c')
									$nominal += (isset($arr_nominal[$i]['debet']) ? $arr_nominal[$i]['debet'] : 0);
								else if ($kalkulasi == 'd')
									$nominal += (isset($arr_nominal[$i]['kredit']) ? $arr_nominal[$i]['kredit'] : 0);
								else
									die('Weird !!!');
							}
						}			
						
						if ($prev != $seri) {
							switch ($seri) {
								case 1 :
									$head = 'AKTIVITAS OPERASI';
									break;
								case 2 :
									$head = 'AKTIVITAS INVESTASI';
									break;
								case 3 :
									$head = 'AKTIVITAS PENDANAAN';
									break;
								default :
									show_error('Invalid');
							}
							$objExcel->getActiveSheet()
									 ->setCellValue('A' . $row++, $head);
							$prev = $seri;
						}

						$spasi = (strlen(trim($order_number, '0')) - 1);
						
						$objExcel->getActiveSheet()
								 ->setCellValue('A' . $row, $uraian);
												
						$nominal *= $kalibrasi;
						
						$objExcel->getActiveSheet()
								 ->setCellValueExplicit('D' . $row++, $nominal, PHPExcel_Cell_DataType::TYPE_NUMERIC);						

						$total += $nominal;
						break;
					case 4 :
						++$row;
						
						$spasi = 0;
						
						$total *= $kalibrasi;
						
						$objExcel->getActiveSheet()
								 ->setCellValue('A' . $row, strtoupper($uraian))
								 ->setCellValueExplicit('D' . $row++, $total, PHPExcel_Cell_DataType::TYPE_NUMERIC);
									
						break;
					case 5 :
						$nominal = 0;
						
						$arr_coa = explode(',', $coa_range);				
						foreach ($arr_coa as $coa) {
							list($begin, $end) = explode('~', $coa);
							for ($i = $begin; $i <= $end; $i++) {
								$nominal += (isset($arr_nominal0[$i]['akhir']) ? $arr_nominal0[$i]['akhir'] : 0);
							}
						}			

						++$row;
						
						$spasi = 0;
											
						$nominal *= $kalibrasi;

						$objExcel->getActiveSheet()
								 ->setCellValue('A' . $row, strtoupper($uraian))
								 ->setCellValueExplicit('D' . $row++, $nominal, PHPExcel_Cell_DataType::TYPE_NUMERIC);

						$awal = $nominal;
						break;
					case 6 :
						$nominal = 0;
						
						$arr_coa = explode(',', $coa_range);				
						foreach ($arr_coa as $coa) {
							list($begin, $end) = explode('~', $coa);
							for ($i = $begin; $i <= $end; $i++) {
								$nominal += (isset($arr_nominal[$i]['akhir']) ? $arr_nominal[$i]['akhir'] : 0);
							}
						}			

						++$row;
						
						$spasi = 0;
											
						$nominal *= $kalibrasi;

						$objExcel->getActiveSheet()
								 ->setCellValue('A' . $row, strtoupper($uraian))
								 ->setCellValueExplicit('D' . $row++, $nominal, PHPExcel_Cell_DataType::TYPE_NUMERIC);						

						$akhir = $nominal;
						break;
					default :
						show_error('Invalid !!!');
				}
			}
			
			/*if (numFormat($total + $awal) != numFormat($akhir)) {
				++$row;
				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $row, '*) Terdapat selisih, periksa kembali template laporan, saldo kas & setara kas akhir seharusnya Rp. ' . numFormat($total + $awal));
			} */
					 
			$objExcel->showExcel($this->session->userdata('session_id') . '_' . time());
			/********************** END   : GENERATE EXCEL **********************/				
		}		
		
	}
	
/* End of file arusKas.php */
/* Location: ./system/application/controllers/sie/arusKas.php */		
