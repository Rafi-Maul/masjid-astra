<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class BukuBesar extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'sie::BukuBesar Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			$this->load->helper('date');
														 
			$arr_years =& $this->db->getRows('SELECT DISTINCT tahun FROM akun.akmt_periode ORDER BY tahun');
			
			$data 			   = array();
			$data['arr_years'] = $arr_years;
			$this->load->viewPage('sie/list_buku', $data);											
		}
		
		public function history() {
			$this->password->getUrlAccess('/sie/bukuBesar', 'cetak');
			
			$kode_format		= $this->getVar('kode_format', TRUE);			
			$month1 			= $this->getVar('month1', TRUE);
			$month2 			= $this->getVar('month2', TRUE);
			$year1				= $this->getVar('year1', TRUE);
			$year2 				= $this->getVar('year2', TRUE);
			$id_akdd_detail_coa = $this->getVar('id_akdd_detail_coa', TRUE);
			
			$this->load->library('Closing');			
			$this->closing->generate();
			
			/****************************  BEGIN SQL ****************************/
			
			$coa = $this->db->getRow("
									 SELECT
									 (a.coa_number || ' - '::VARCHAR(2) || a.uraian) AS uraian,
									 ((CASE WHEN b.akhir IS NULL THEN 0 ELSE b.akhir END) * (CASE WHEN c.acc_type = 'd' THEN 1 ELSE -1 END)) AS saldo
									 FROM
									 akun.akdd_detail_coa a
									 LEFT JOIN (
										SELECT
										id_akdd_detail_coa,
										akhir
										FROM
										akun.akmt_buku_besar
										WHERE
										id_akdd_detail_coa = ?
										AND
										tanggal <= ?
										ORDER BY
										tanggal DESC
										LIMIT 1
									 ) b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
									 INNER JOIN akun.akdd_main_coa c ON a.id_akdd_main_coa = c.id_akdd_main_coa
									 WHERE
									 a.id_akdd_detail_coa = ?
									 ", array($id_akdd_detail_coa, $year1 . '-' . str_pad($month1, 2, '0', STR_PAD_LEFT) . '-01', $id_akdd_detail_coa));
									 
			$max_day = str_pad(date('t', mktime(0, 0, 0, intval($month2), 1, intval($year2))), 2, '0', STR_PAD_LEFT);						 
									 
			$arr_saldo =& $this->db->getRows("
											 SELECT
											 b.tanggal,
											 b.no_bukti,
											 b.keterangan,
											 ((CASE WHEN c.acc_type = 'd' THEN 1 ELSE -1 END) * MIN(b.awal)) AS awal,
											 SUM(b.mutasi_debet) AS mutasi_debet,
											 SUM(b.mutasi_kredit) AS mutasi_kredit,
											 ((CASE WHEN c.acc_type = 'd' THEN 1 ELSE -1 END) * MAX(b.akhir)) AS akhir
											 FROM
											 akun.akdd_detail_coa a
											 INNER JOIN akun.akmt_buku_besar b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
											 INNER JOIN akun.akdd_main_coa c ON a.id_akdd_main_coa = c.id_akdd_main_coa
											 WHERE 
											 b.no_bukti <> 'N/A'
											 AND
											 a.id_akdd_detail_coa = ?											 
											 AND
											 b.tanggal BETWEEN ? AND ?
											 GROUP BY
											 b.tanggal,
											 b.no_bukti,
											 b.keterangan,
											 c.acc_type
											 ORDER BY
											 b.tanggal,
											 b.no_bukti
											 ", array($id_akdd_detail_coa, $year1 . '-' . str_pad($month1, 2, '0', STR_PAD_LEFT) . '-01', $year2 . '-' . str_pad($month2, 2, '0', STR_PAD_LEFT) . '-' . $max_day));
			
			/****************************   END SQL  ****************************/
			
			if ($kode_format != 1) {
				$this->historyExcel($month1, $month2, $year1, $year2, $id_akdd_detail_coa, $coa, $arr_saldo);
				exit(0);
			} 			

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
			$arrCol['title'] = 'TANGGAL';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
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
			$arrCol['title'] = 'KETERANGAN';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);			

			$arrCol = array();
			$arrCol['title'] = 'AWAL';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$mainSubCols = array();
			
			$arrSubCol = array();
			$arrSubCol['title'] = 'DEBET';
			$arrSubCol['width'] = 30;
			$arrSubCol['align'] = 'C';
			$arrSubCol['calign'] = 'R';
			$arrSubCol['span'] = 1;
			$arrSubCol['sub'] = null;

			array_push($mainSubCols, $arrSubCol);
			
			$arrSubCol = array();
			$arrSubCol['title'] = 'KREDIT';
			$arrSubCol['width'] = 30;
			$arrSubCol['align'] = 'C';
			$arrSubCol['calign'] = 'R';
			$arrSubCol['span'] = 1;
			$arrSubCol['sub'] = null;

			array_push($mainSubCols, $arrSubCol);			
						
			$arrCol = array();
			$arrCol['title'] = 'MUTASI';
			$arrCol['width'] = 60;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 1;
			$arrCol['sub'] = $mainSubCols;

			array_push($mainCols, $arrCol);			

			$arrCol = array();
			$arrCol['title'] = 'AKHIR';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

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
			$this->report->SetLogoWidth(17);

			$this->report->SetReportMainTitle('LAPORAN BUKU BESAR');

			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->SetReportTitle('PERIODE', getMonthString($month1) . ' ' . $year1 . ' s/d ' . getMonthString($month2) . ' ' . $year2);			
			$this->report->SetReportTitle('KODE PERKIRAAN', strtoupper($coa['uraian']));
			if ($coa['saldo'] >= 0)
				$this->report->SetReportTitle('SALDO AWAL', numFormat($coa['saldo']));
			else
				$this->report->SetReportTitle('SALDO AWAL', '(' . numFormat(abs($coa['saldo'])) . ')');
			
			$this->report->Open();
			$this->report->AddPage();

			/**************************** BEGIN CONTENT ****************************/
			
			$i 	  = 1;			
			foreach ($arr_saldo as $saldo) {
				$tanggal 	= $saldo['tanggal'];
				$no_bukti 	= $saldo['no_bukti'];
				$keterangan = $saldo['keterangan'];
				$awal 		= $saldo['awal'];
				$debet 		= $saldo['mutasi_debet'];
				$kredit 	= $saldo['mutasi_kredit'];
				$akhir 		= $saldo['akhir'];
				
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = getLocalDate($tanggal);
				$arrData[] = $no_bukti;
				$arrData[] = $keterangan;
				if ($awal >= 0)
					$arrData[] = numFormat($awal);
				else
					$arrData[] = '(' . numFormat(abs($awal)) . ')';
				$arrData[] = numFormat($debet);
				$arrData[] = numFormat($kredit);
				if ($akhir >= 0)
					$arrData[] = numFormat($akhir);
				else
					$arrData[] = '(' . numFormat(abs($akhir)) . ')';				
				$this->report->InsertRow($arrData);				
			}
			
			/****************************  END CONTENT  ****************************/			
			
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
			
			
		}
		
		private function historyExcel($month1, $month2, $year1, $year2, $id_akdd_detail_coa, $coa, $arr_saldo) {
			$this->load->helper('date');
			$this->load->helper('number');
								
			/********************** BEGIN : GENERATE EXCEL **********************/
			$this->load->library('Excel');
			
			$objExcel = new Excel();
			
			$objExcel->setActiveSheetIndex(0)
					 ->mergeCells('A1:H1')
					 ->mergeCells('A3:B3')
					 ->mergeCells('A4:B4')
					 ->mergeCells('A5:B5')
					 ->mergeCells('A6:B6')
					 ->mergeCells('A7:A8')
					 ->mergeCells('B7:B8')
					 ->mergeCells('C7:C8')
					 ->mergeCells('D7:D8')
					 ->mergeCells('E7:E8')
					 ->mergeCells('F7:G7')
					 ->mergeCells('H7:H8');
					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A1:H1')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A7:H8')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 
			$objExcel->getActiveSheet()		
					 ->setCellValue('A1', 'LAPORAN BUKU BESAR')
					 ->setCellValue('A3', 'TANGGAL CETAK')
					 ->setCellValue('A4', 'PERIODE')
					 ->setCellValue('A5', 'KODE PERKIRAAN')
					 ->setCellValue('A6', 'SALDO AWAL')
					 ->setCellValue('C3', ':')
					 ->setCellValue('C4', ':')
					 ->setCellValue('C5', ':')
					 ->setCellValue('C6', ':')
					 ->setCellValue('D3', strtoupper(getCurrentDate(FALSE)))
					 ->setCellValue('D4', getMonthString($month1) . ' ' . $year1 . ' s/d ' . getMonthString($month2) . ' ' . $year2)
					 ->setCellValue('D5', strtoupper($coa['uraian']))
					 ->setCellValueExplicit('D6', $coa['saldo'], PHPExcel_Cell_DataType::TYPE_NUMERIC)
					 ->setCellValue('A7', 'NO.')
					 ->setCellValue('B7', 'TANGGAL')
					 ->setCellValue('C7', 'NO. BUKTI')
					 ->setCellValue('D7', 'KETERANGAN')
					 ->setCellValue('E7', 'AWAL')
					 ->setCellValue('F7', 'MUTASI')
					 ->setCellValue('F8', 'DEBET')
					 ->setCellValue('G8', 'KREDIT')				 
					 ->setCellValue('H7', 'AKHIR')
					 ->setTitle('Report - Buku Besar');	
					 
			$objExcel->getActiveSheet()
					 ->getColumnDimension('A')
					 ->setAutoSize(TRUE);
					 
			$objExcel->getActiveSheet()
					 ->getColumnDimension('B')
					 ->setAutoSize(TRUE);	

			$objExcel->getActiveSheet()
					 ->getColumnDimension('D')
					 ->setAutoSize(TRUE);
					 
			$objExcel->getActiveSheet()
					 ->getColumnDimension('E')
					 ->setAutoSize(TRUE);

			$objExcel->getActiveSheet()
					 ->getColumnDimension('F')
					 ->setAutoSize(TRUE);
					 
			$objExcel->getActiveSheet()
					 ->getColumnDimension('G')
					 ->setAutoSize(TRUE);

			$objExcel->getActiveSheet()
					 ->getColumnDimension('H')
					 ->setAutoSize(TRUE);
			
						
			$i 	 = 1;			
			$row = 9;
			foreach ($arr_saldo as $saldo) {
				$tanggal 	= $saldo['tanggal'];
				$no_bukti 	= $saldo['no_bukti'];
				$keterangan = $saldo['keterangan'];
				$awal 		= $saldo['awal'];
				$debet 		= $saldo['mutasi_debet'];
				$kredit 	= $saldo['mutasi_kredit'];
				$akhir 		= $saldo['akhir'];
				
				
				$objExcel->getActiveSheet()
						 ->setCellValueExplicit('A' . $row, $i . '.', PHPExcel_Cell_DataType::TYPE_STRING)
						 ->setCellValueExplicit('B' . $row, getLocalDate($tanggal), PHPExcel_Cell_DataType::TYPE_STRING)
						 ->setCellValueExplicit('C' . $row, $no_bukti, PHPExcel_Cell_DataType::TYPE_STRING)
						 ->setCellValueExplicit('D' . $row, $keterangan, PHPExcel_Cell_DataType::TYPE_STRING)
						 ->setCellValueExplicit('E' . $row, $awal, PHPExcel_Cell_DataType::TYPE_NUMERIC)
						 ->setCellValueExplicit('F' . $row, $debet, PHPExcel_Cell_DataType::TYPE_NUMERIC)
						 ->setCellValueExplicit('G' . $row, $kredit, PHPExcel_Cell_DataType::TYPE_NUMERIC)
						 ->setCellValueExplicit('H' . $row, $akhir, PHPExcel_Cell_DataType::TYPE_NUMERIC);
						 
				$i++;
				$row++;
			}
					 					 
			$objExcel->showExcel($this->session->userdata('session_id') . '_' . time());
			/********************** END   : GENERATE EXCEL **********************/	
		}
		
	}
	
/* End of file bukuBesar.php */
/* Location: ./system/application/controllers/sie/bukuBesar.php */		
