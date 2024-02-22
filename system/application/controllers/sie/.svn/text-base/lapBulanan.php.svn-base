<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class LapBulanan extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'sie::LapBulanan Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			$this->load->helper('date');

			$arr_years 			=& $this->db->getRows('SELECT DISTINCT tahun FROM akun.akmt_periode ORDER BY tahun');
			
			$arr_penerimaan 	=& $this->db->getRows('SELECT id_sub_kode_kas, sub_kas FROM trans.sub_kode_kas WHERE id_kode_kas = 8 ORDER BY sub_kas');
			
			$arr_pengeluaran 	=& $this->db->getRows('SELECT id_sub_kode_kas, sub_kas FROM trans.sub_kode_kas WHERE id_kode_kas = 15 ORDER BY sub_kas');
			
			$arr_ramadhan 		=& $this->db->getRows('SELECT id_sub_kode_kas, sub_kas FROM trans.sub_kode_kas WHERE id_kode_kas = 19 ORDER BY sub_kas');
			
			$data 			   			= array();
			$data['arr_years'] 			= $arr_years;
			$data['arr_penerimaan']		= $arr_penerimaan;
			$data['arr_pengeluaran']	= $arr_pengeluaran;
			$data['arr_ramadhan']		= $arr_ramadhan;
			$this->load->viewPage('sie/list_bulanan', $data);												
		}
		
		public function kas() {
			$this->password->getUrlAccess('/sie/lapBulanan', 'cetak');
				
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
			define('ORDER_NUMBER_WD', 10);
			define('DATE_WD', 15);
			define('NO_BUKTI_WD', 30);
			define('NOTE_WD', 75);		
			define('NOMINAL_WD', 50);
			
			$params 			   = array();
			$params['orientation'] = 'P';
			$params['format'] 	   = 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');
			$this->load->helper('number');
			
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg', 30);
			$this->report->SetReportMainTitle('LAPORAN BULANAN');

			$current_width = $this->report->GetWidth();

			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->SetReportTitle('PERIODE', strtoupper(getMonthString($month) . ', ' . $year));
			
			$this->report->Open();
			$this->report->AddPage();
			
			$this->report->SetFontSize(FONT_SIZE);

			$start_x = $this->report->GetX();
			$start_y = $this->report->GetY();	
			
			/************************ BEGIN : SALDO AWAL BULANAN ************************/	
			
			$sql = 	"
					SELECT
					awal
					FROM
					akun.akmt_buku_besar
					WHERE
					id_akdd_detail_coa = 29
					AND DATE_PART('YEAR', tanggal) = ?
					AND DATE_PART('MONTH', tanggal) = ?
					ORDER BY
					id_akmt_buku_besar
					LIMIT 1
					OFFSET 0
					";
			$awal =	$this->db->getField('awal', $sql, array($year, $month));
			
			$left_width = $current_width - MARGIN_DEF - NOMINAL_WD;
			
			$this->report->SetFillColor(245, 245, 245);			
			$this->report->Cell($left_width, DEFAULT_LN, 'A. SALDO AWAL', 'TB', 0, 'L', 1);
			$this->report->Cell(0, DEFAULT_LN, numFormat($awal), 'TB', 1, 'R', 0);			
			
			/************************ END 	: SALDO AWAL BULANAN ************************/	

			$sql =	"
					SELECT
					SUM(mutasi_debet) AS penerimaan,
					SUM(mutasi_kredit) AS pengeluaran
					FROM
					akun.akmt_buku_besar
					WHERE
					id_akdd_detail_coa = 29
					AND DATE_PART('YEAR', tanggal) = ?
					AND DATE_PART('MONTH', tanggal) = ?
					";
			$total	= $this->db->getRow($sql, array($year, $month));
			
			$this->report->Cell($left_width, DEFAULT_LN, 'B. PENERIMAAN', 'TB', 0, 'L', 1);
			$this->report->Cell(0, DEFAULT_LN, numFormat($total['penerimaan']), 'TB', 1, 'R', 0);						

			if ($total['penerimaan'] > 0) {
				$this->report->Cell(ORDER_NUMBER_WD, DEFAULT_LN, 'NO', 'TB', 0, 'C', 0);
				$this->report->Cell(DATE_WD, DEFAULT_LN, 'TANGGAL', 'TB', 0, 'C', 0);
				$this->report->Cell(NO_BUKTI_WD, DEFAULT_LN, 'NOMOR BUKTI', 'TB', 0, 'C', 0);
				$this->report->Cell(NOTE_WD, DEFAULT_LN, 'KETERANGAN', 'TB', 0, 'C', 0);
				$this->report->Cell(0, DEFAULT_LN, 'NOMINAL', 'TB', 1, 'C', 0);						
			}
						
			$sql =	"
					SELECT
					tanggal,
					no_bukti,
					keterangan,
					mutasi_debet,
					mutasi_kredit,
					(CASE WHEN mutasi_debet > 0 THEN 0 ELSE 1 END) AS flag_debet_kredit
					FROM
					akun.akmt_buku_besar
					WHERE
					((mutasi_debet > 0) OR (mutasi_kredit > 0))
					AND DATE_PART('YEAR', tanggal) = ?
					AND DATE_PART('MONTH', tanggal) = ?
					AND id_akdd_detail_coa = 29
					ORDER BY
					(CASE WHEN mutasi_debet > 0 THEN 0 ELSE 1 END),
					tanggal
					";
			$arr_lap =& $this->db->getRows($sql, array($year, $month));
			
			if ($total['penerimaan'] > 0) 
				$stage = 0;
			else {
				$this->report->Cell($left_width, DEFAULT_LN, 'C. PENGELUARAN', 'TB', 0, 'L', 1);
				$this->report->Cell(0, DEFAULT_LN, numFormat($total['pengeluaran']), 'TB', 1, 'R', 0);										
				$stage = 1;
			}
			$i = 0;
			foreach ($arr_lap as $lap) {
				$tanggal			= $lap['tanggal'];
				$no_bukti			= $lap['no_bukti'];
				$keterangan			= $lap['keterangan'];
				$mutasi_debet		= $lap['mutasi_debet'];
				$mutasi_kredit		= $lap['mutasi_kredit'];
				$flag_debet_kredit	= $lap['flag_debet_kredit'];
				
				if ($stage != $flag_debet_kredit) {
					$this->report->Cell($left_width, DEFAULT_LN, 'C. PENGELUARAN', 'TB', 0, 'L', 1);
					$this->report->Cell(0, DEFAULT_LN, numFormat($total['pengeluaran']), 'TB', 1, 'R', 0);										
					
					$this->report->Cell(ORDER_NUMBER_WD, DEFAULT_LN, 'NO', 'TB', 0, 'C', 0);
					$this->report->Cell(DATE_WD, DEFAULT_LN, 'TANGGAL', 'TB', 0, 'C', 0);
					$this->report->Cell(NO_BUKTI_WD, DEFAULT_LN, 'NOMOR BUKTI', 'TB', 0, 'C', 0);
					$this->report->Cell(NOTE_WD, DEFAULT_LN, 'KETERANGAN', 'TB', 0, 'C', 0);
					$this->report->Cell(0, DEFAULT_LN, 'NOMINAL', 'TB', 1, 'C', 0);								
					
					$stage = $flag_debet_kredit;	
					$i = 0;
				}
				
				$this->report->Cell(ORDER_NUMBER_WD, DEFAULT_LN, ++$i . '.', 'TB', 0, 'R', 0);
				$this->report->Cell(DATE_WD, DEFAULT_LN, getLocalDate($tanggal), 'TB', 0, 'C', 0);
				$this->report->Cell(NO_BUKTI_WD, DEFAULT_LN, $no_bukti, 'TB', 0, 'C', 0);
				$this->report->Cell(NOTE_WD, DEFAULT_LN, $keterangan, 'TB', 0, 'L', 0);
				$this->report->Cell(0, DEFAULT_LN, numFormat(($stage == 1) ? $mutasi_kredit : $mutasi_debet), 'TB', 1, 'R', 0);			

				
			}
			
			if ($stage == 0) {
				$this->report->Cell($left_width, DEFAULT_LN, 'C. PENGELUARAN', 'TB', 0, 'L', 1);
				$this->report->Cell(0, DEFAULT_LN, numFormat($total['pengeluaran']), 'TB', 1, 'R', 0);			
			}
			
			/************************ BEGIN : SALDO AKHIR BULANAN ************************/	
			
			$sql = 	"
					SELECT
					akhir
					FROM
					akun.akmt_buku_besar
					WHERE
					id_akdd_detail_coa = 29
					AND DATE_PART('YEAR', tanggal) = ?
					AND DATE_PART('MONTH', tanggal) = ?
					ORDER BY
					id_akmt_buku_besar DESC
					LIMIT 1
					OFFSET 0
					";
			$akhir = $this->db->getField('akhir', $sql, array($year, $month));			
			
			$this->report->Cell($left_width, DEFAULT_LN, 'D. SALDO AKHIR', 'TB', 0, 'L', 1);
			$this->report->Cell(0, DEFAULT_LN, numFormat($akhir), 'TB', 1, 'R', 0);						
			
			/************************ END 	: SALDO AKHIR BULANAN ************************/	
			
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);															
		}
				
		private function kasExcel($month, $year) {
			$this->load->helper('date');
			$this->load->helper('number');

			/********************** BEGIN : GENERATE EXCEL **********************/
			$this->load->library('Excel');
			
			$objExcel = new Excel();
			
			$objExcel->setActiveSheetIndex(0)
					 ->mergeCells('A1:E1');
					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A1:E1')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 					 				 
			$objExcel->getActiveSheet()		
					 ->setCellValue('A1', 'LAPORAN BULANAN')
					 ->setCellValue('A3', 'TANGGAL CETAK')
					 ->setCellValue('A4', 'PERIODE')
					 ->setCellValue('B3', ':')
					 ->setCellValue('B4', ':')
					 ->setCellValue('C3', strtoupper(getCurrentDate(FALSE)))
					 ->setCellValue('C4', getMonthString($month) . ', ' . $year)
					 ->setTitle('Report - Laporan Bulanan');

			/************************ BEGIN : SALDO AWAL BULANAN ************************/	
			
			$sql = 	"
					SELECT
					awal
					FROM
					akun.akmt_buku_besar
					WHERE
					id_akdd_detail_coa = 29
					AND DATE_PART('YEAR', tanggal) = ?
					AND DATE_PART('MONTH', tanggal) = ?
					ORDER BY
					id_akmt_buku_besar
					LIMIT 1
					OFFSET 0
					";
			$awal =	$this->db->getField('awal', $sql, array($year, $month));
			
			$objExcel->getActiveSheet()
					 ->setCellValue('A5', 'A. SALDO AWAL')
					 ->setCellValue('E5', $awal);
						
			/************************ END 	: SALDO AWAL BULANAN ************************/	

			$sql =	"
					SELECT
					SUM(mutasi_debet) AS penerimaan,
					SUM(mutasi_kredit) AS pengeluaran
					FROM
					akun.akmt_buku_besar
					WHERE
					id_akdd_detail_coa = 29
					AND DATE_PART('YEAR', tanggal) = ?
					AND DATE_PART('MONTH', tanggal) = ?
					";
			$total	= $this->db->getRow($sql, array($year, $month));
					
			$objExcel->getActiveSheet()
					 ->setCellValue('A6', 'B. PENERIMAAN')
					 ->setCellValue('E6', $total['penerimaan']);
					 
			$lastRow = 7;

			if ($total['penerimaan'] > 0) {				
				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $lastRow, 'NO')
						 ->setCellValue('B' . $lastRow, 'TANGGAL')
						 ->setCellValue('C' . $lastRow, 'NOMOR BUKTI')
						 ->setCellValue('D' . $lastRow, 'KETERANGAN')
						 ->setCellValue('E' . $lastRow, 'NOMINAL');
						 
				$lastRow++;
			}
						
			$sql =	"
					SELECT
					tanggal,
					no_bukti,
					keterangan,
					mutasi_debet,
					mutasi_kredit,
					(CASE WHEN mutasi_debet > 0 THEN 0 ELSE 1 END) AS flag_debet_kredit
					FROM
					akun.akmt_buku_besar
					WHERE
					((mutasi_debet > 0) OR (mutasi_kredit > 0))
					AND DATE_PART('YEAR', tanggal) = ?
					AND DATE_PART('MONTH', tanggal) = ?
					AND id_akdd_detail_coa = 29
					ORDER BY
					(CASE WHEN mutasi_debet > 0 THEN 0 ELSE 1 END),
					tanggal
					";
			$arr_lap =& $this->db->getRows($sql, array($year, $month));
			
			if ($total['penerimaan'] > 0) 
				$stage = 0;
			else {
				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $lastRow, 'C. PENGELUARAN')
						 ->setCellValue('E' . $lastRow, $total['pengeluaran']);
				
				$stage = 1;
				$lastRow++;
			}
			$i = 0;
			foreach ($arr_lap as $lap) {
				$tanggal			= $lap['tanggal'];
				$no_bukti			= $lap['no_bukti'];
				$keterangan			= $lap['keterangan'];
				$mutasi_debet		= $lap['mutasi_debet'];
				$mutasi_kredit		= $lap['mutasi_kredit'];
				$flag_debet_kredit	= $lap['flag_debet_kredit'];
				
				if ($stage != $flag_debet_kredit) {				
					$objExcel->getActiveSheet()
							 ->setCellValue('A' . $lastRow, 'C. PENGELUARAN')
							 ->setCellValue('E' . $lastRow, $total['pengeluaran']);
							 
					$lastRow++;
										
					$objExcel->getActiveSheet()
							 ->setCellValue('A' . $lastRow, 'NO')
							 ->setCellValue('B' . $lastRow, 'TANGGAL')
							 ->setCellValue('C' . $lastRow, 'NOMOR BUKTI')
							 ->setCellValue('D' . $lastRow, 'KETERANGAN')
							 ->setCellValue('E' . $lastRow, 'NOMINAL');
					
					$stage = $flag_debet_kredit;	
					$i = 0;
					$lastRow++;
				}
								
				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $lastRow, ++$i . '.')
						 ->setCellValue('B' . $lastRow, getLocalDate($tanggal))
						 ->setCellValue('C' . $lastRow, $no_bukti)
						 ->setCellValue('D' . $lastRow, $keterangan)
						 ->setCellValue('E' . $lastRow, (($stage == 1) ? $mutasi_kredit : $mutasi_debet));

				$lastRow++;
			}
			
			if ($stage == 0) {				
				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $lastRow, 'C. PENGELUARAN')
						 ->setCellValue('E' . $lastRow, $total['pengeluaran']);
						 
				$lastRow++;
			}
			
			/************************ BEGIN : SALDO AKHIR BULANAN ************************/	
			
			$sql = 	"
					SELECT
					akhir
					FROM
					akun.akmt_buku_besar
					WHERE
					id_akdd_detail_coa = 29
					AND DATE_PART('YEAR', tanggal) = ?
					AND DATE_PART('MONTH', tanggal) = ?
					ORDER BY
					id_akmt_buku_besar DESC
					LIMIT 1
					OFFSET 0
					";
			$akhir = $this->db->getField('akhir', $sql, array($year, $month));			
						
			$objExcel->getActiveSheet()
					 ->setCellValue('A' . $lastRow, 'D. SALDO AKHIR')
					 ->setCellValue('E' . $lastRow, $akhir);
					 
			$objExcel->showExcel($this->session->userdata('session_id') . '_' . time());
			/********************** END   : GENERATE EXCEL **********************/						 
	
		
		}
		
		public function penerimaanInfaq() {
			$this->password->getUrlAccess('/sie/lapBulanan', 'cetak');
				
			$id_sub_kode_kas	= $this->getVar('id_sub_kode_kas', FALSE);				
			$kode_format		= $this->getVar('kode_format', TRUE);									
			$month 	   			= $this->getVar('month', TRUE);
			$year  	   			= $this->getVar('year', TRUE);

			//$this->load->library('Closing');			
			//$this->closing->generate();
			
			if ($kode_format != 1) {
				$this->penerimaanInfaqExcel($month, $year, $id_sub_kode_kas);
				exit(0);
			} 					

			/****************************  BEGIN SQL ****************************/	

			$sql_plus 		= '';
			$arr_params		= array();
			$arr_params[]	= $month;
			$arr_params[]	= $year;
			if (is_numeric($id_sub_kode_kas)) {
				$sql_plus 		= 'AND d.id_sub_kode_kas = ?';
				$arr_params[] 	= $id_sub_kode_kas;
				$sql =	"
						SELECT
						sub_kas
						FROM
						trans.sub_kode_kas
						WHERE
						id_sub_kode_kas = ?
						LIMIT 1
						OFFSET 0
						";
				$sub_kas = $this->db->getField('sub_kas', $sql, array($id_sub_kode_kas));
			}

			$sql =	"
					SELECT
					e.tanggal,
					e.keterangan,
					a.nominal
					FROM
					trans.sub_transaksi a
					INNER JOIN trans.mapping_kode_akun b ON a.id_mapping_kode_akun = b.id_mapping_kode_akun
					INNER JOIN trans.jenis_transaksi c ON b.id_jenis_transaksi = c.id_jenis_transaksi
					INNER JOIN trans.sub_kode_kas d ON c.id_sub_kode_kas = d.id_sub_kode_kas
					INNER JOIN trans.transaksi e ON a.id_transaksi = e.id_transaksi
					WHERE
					b.flag_debet_kredit = 2
					AND b.flag_pajak = 1
					AND d.id_kode_kas = 8
					AND DATE_PART('MONTH', e.tanggal) = ?
					AND DATE_PART('YEAR', e.tanggal) = ?
					{$sql_plus}
					ORDER BY
					e.tanggal,
					e.id_transaksi
					";					
			$arr_lap =& $this->db->getRows($sql, $arr_params);
						
			/****************************   END SQL  ****************************/
			
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
			$arrCol['title'] = 'KETERANGAN';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);			

			$arrCol = array();
			$arrCol['title'] = 'NOMINAL';
			$arrCol['width'] = 50;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);			
						
			/**************************** END HEAD ****************************/
			
			$params 			   	= array();
			$params['arrHead'] 		= $mainCols;
			$params['orientation'] 	= 'P';
			$params['format'] 	   	= 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');
			$this->load->helper('number');
			
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg', 30);
			$this->report->SetReportMainTitle('LAPORAN BULANAN PENERIMAAN INFAQ');

			$current_width = $this->report->GetWidth();

			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->SetReportTitle('PERIODE', strtoupper(getMonthString($month) . ', ' . $year));
			if (is_numeric($id_sub_kode_kas))
				$this->report->SetReportTitle('PENERIMAAN', strtoupper($sub_kas));
			
			$this->report->Open();
			$this->report->AddPage();
			
			/**************************** BEGIN CONTENT ****************************/
			
			$i 	  = 1;			
			foreach ($arr_lap as $lap) {
				$tanggal 	= $lap['tanggal'];
				$keterangan = $lap['keterangan'];
				$nominal	= $lap['nominal'];
				
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = getLocalDate($tanggal);
				$arrData[] = $keterangan;
				$arrData[] = numFormat($nominal);
				$this->report->InsertRow($arrData);				
			}
					
			/****************************  END CONTENT  ****************************/			
			
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);		
		}
		
		private function penerimaanInfaqExcel($month, $year, $id_sub_kode_kas) {
			$this->load->helper('date');
			$this->load->helper('number');
			
			/****************************  BEGIN SQL ****************************/	

			$sql_plus 		= '';
			$arr_params		= array();
			$arr_params[]	= $month;
			$arr_params[]	= $year;
			if (is_numeric($id_sub_kode_kas)) {
				$sql_plus 		= 'AND d.id_sub_kode_kas = ?';
				$arr_params[] 	= $id_sub_kode_kas;
				$sql =	"
						SELECT
						sub_kas
						FROM
						trans.sub_kode_kas
						WHERE
						id_sub_kode_kas = ?
						LIMIT 1
						OFFSET 0
						";
				$sub_kas = $this->db->getField('sub_kas', $sql, array($id_sub_kode_kas));
			}

			$sql =	"
					SELECT
					e.tanggal,
					e.keterangan,
					a.nominal
					FROM
					trans.sub_transaksi a
					INNER JOIN trans.mapping_kode_akun b ON a.id_mapping_kode_akun = b.id_mapping_kode_akun
					INNER JOIN trans.jenis_transaksi c ON b.id_jenis_transaksi = c.id_jenis_transaksi
					INNER JOIN trans.sub_kode_kas d ON c.id_sub_kode_kas = d.id_sub_kode_kas
					INNER JOIN trans.transaksi e ON a.id_transaksi = e.id_transaksi
					WHERE
					b.flag_debet_kredit = 2
					AND b.flag_pajak = 1
					AND d.id_kode_kas = 8
					AND DATE_PART('MONTH', e.tanggal) = ?
					AND DATE_PART('YEAR', e.tanggal) = ?
					{$sql_plus}
					ORDER BY
					e.tanggal,
					e.id_transaksi
					";					
			$arr_lap =& $this->db->getRows($sql, $arr_params);
						
			/****************************   END SQL  ****************************/			

			/********************** BEGIN : GENERATE EXCEL **********************/
			$this->load->library('Excel');
			
			$objExcel = new Excel();
			
			$objExcel->setActiveSheetIndex(0)
					 ->mergeCells('A1:E1');
					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A1:E1')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 					 				 
			$objExcel->getActiveSheet()		
					 ->setCellValue('A1', 'LAPORAN BULANAN PENERIMAAN INFAQ')
					 ->setCellValue('A3', 'TANGGAL CETAK')
					 ->setCellValue('A4', 'PERIODE')
					 ->setCellValue('B3', ':')
					 ->setCellValue('B4', ':')
					 ->setCellValue('C3', strtoupper(getCurrentDate(FALSE)))
					 ->setCellValue('C4', getMonthString($month) . ', ' . $year)
					 ->setTitle('Report - Penerimaan Infaq');

			if (is_numeric($id_sub_kode_kas)) {
				$objExcel->getActiveSheet()
						 ->setCellValue('A5', 'PENERIMAAN')
						 ->setCellValue('B5', ':')
						 ->setCellValue('C5', strtoupper($sub_kas));
			}
			
			$objExcel->getActiveSheet()
					 ->setCellValue('A7', 'NO.')
					 ->setCellValue('B7', 'TANGGAL')
					 ->setCellValue('C7', 'KETERANGAN')
					 ->setCellValue('D7', 'NOMINAL');
			
			$i 	  = 1;			
			foreach ($arr_lap as $lap) {
				$tanggal 	= $lap['tanggal'];
				$keterangan = $lap['keterangan'];
				$nominal	= $lap['nominal'];
				
				$baris 		= $i + 7;

				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $baris, $i++)
						 ->setCellValue('B' . $baris, $tanggal)
						 ->setCellValue('C' . $baris, $keterangan)
						 ->setCellValue('D' . $baris, $nominal);
			}
			
			$objExcel->showExcel($this->session->userdata('session_id') . '_' . time());
			/********************** END   : GENERATE EXCEL **********************/						 						
			
		}
		
		public function pengeluaranKajian() {
			$this->password->getUrlAccess('/sie/lapBulanan', 'cetak');
				
			$id_sub_kode_kas	= $this->getVar('id_sub_kode_kas', FALSE);				
			$kode_format		= $this->getVar('kode_format', TRUE);									
			$month 	   			= $this->getVar('month', TRUE);
			$year  	   			= $this->getVar('year', TRUE);

			//$this->load->library('Closing');			
			//$this->closing->generate();
			
			if ($kode_format != 1) {
				$this->pengeluaranKajianExcel($month, $year, $id_sub_kode_kas);
				exit(0);
			} 					

			/****************************  BEGIN SQL ****************************/	

			$sql_plus 		= '';
			$arr_params		= array();
			$arr_params[]	= $month;
			$arr_params[]	= $year;
			if (is_numeric($id_sub_kode_kas)) {
				$sql_plus 		= 'AND d.id_sub_kode_kas = ?';
				$arr_params[] 	= $id_sub_kode_kas;
				$sql =	"
						SELECT
						sub_kas
						FROM
						trans.sub_kode_kas
						WHERE
						id_sub_kode_kas = ?
						LIMIT 1
						OFFSET 0
						";
				$sub_kas = $this->db->getField('sub_kas', $sql, array($id_sub_kode_kas));
			}

			$sql =	"
					SELECT
					e.tanggal,
					e.keterangan,
					g.nama,
					a.nominal
					FROM
					trans.sub_transaksi a
					INNER JOIN trans.mapping_kode_akun b ON a.id_mapping_kode_akun = b.id_mapping_kode_akun
					INNER JOIN trans.jenis_transaksi c ON b.id_jenis_transaksi = c.id_jenis_transaksi
					INNER JOIN trans.sub_kode_kas d ON c.id_sub_kode_kas = d.id_sub_kode_kas
					INNER JOIN trans.transaksi e ON a.id_transaksi = e.id_transaksi
					LEFT JOIN trans.mapping_penerima f ON e.id_transaksi = f.id_transaksi
					LEFT JOIN trans.pihak_penerima g ON f.id_pihak_penerima = g.id_pihak_penerima
					WHERE
					b.flag_debet_kredit = 2
					AND b.flag_pajak = 1
					AND d.id_kode_kas = 15
					AND DATE_PART('MONTH', e.tanggal) = ?
					AND DATE_PART('YEAR', e.tanggal) = ?
					{$sql_plus}
					ORDER BY
					e.tanggal,
					e.id_transaksi
					";					
			$arr_lap =& $this->db->getRows($sql, $arr_params);
						
			/****************************   END SQL  ****************************/
			
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
			$arrCol['title'] = 'KETERANGAN';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);			

			$arrCol = array();
			$arrCol['title'] = 'NOMINAL';
			$arrCol['width'] = 50;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);			
						
			/**************************** END HEAD ****************************/
			
			$params 			   	= array();
			$params['arrHead'] 		= $mainCols;
			$params['orientation'] 	= 'P';
			$params['format'] 	   	= 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');
			$this->load->helper('number');
			
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg', 30);
			$this->report->SetReportMainTitle('LAPORAN BULANAN PENGELUARAN KAJIAN RUTIN');

			$current_width = $this->report->GetWidth();

			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->SetReportTitle('PERIODE', strtoupper(getMonthString($month) . ', ' . $year));
			if (is_numeric($id_sub_kode_kas))
				$this->report->SetReportTitle('PENGELUARAN', strtoupper($sub_kas));
			
			$this->report->Open();
			$this->report->AddPage();
			
			/**************************** BEGIN CONTENT ****************************/
			
			$i 	  = 1;			
			foreach ($arr_lap as $lap) {
				$tanggal 	= $lap['tanggal'];
				$keterangan = $lap['keterangan'];
				$nama		= $lap['nama'];
				$nominal	= $lap['nominal'];
				
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = getLocalDate($tanggal);
				$arrData[] = $keterangan . (empty($nama) ? '' : ', ' . $nama);
				$arrData[] = numFormat($nominal);
				$this->report->InsertRow($arrData);				
			}
					
			/****************************  END CONTENT  ****************************/			
			
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);		
		}
		
		private function pengeluaranKajianExcel($month, $year, $id_sub_kode_kas) {
			$this->load->helper('date');
			$this->load->helper('number');
			
			/****************************  BEGIN SQL ****************************/	

			$sql_plus 		= '';
			$arr_params		= array();
			$arr_params[]	= $month;
			$arr_params[]	= $year;
			if (is_numeric($id_sub_kode_kas)) {
				$sql_plus 		= 'AND d.id_sub_kode_kas = ?';
				$arr_params[] 	= $id_sub_kode_kas;
				$sql =	"
						SELECT
						sub_kas
						FROM
						trans.sub_kode_kas
						WHERE
						id_sub_kode_kas = ?
						LIMIT 1
						OFFSET 0
						";
				$sub_kas = $this->db->getField('sub_kas', $sql, array($id_sub_kode_kas));
			}

			$sql =	"
					SELECT
					e.tanggal,
					e.keterangan,
					g.nama,
					a.nominal
					FROM
					trans.sub_transaksi a
					INNER JOIN trans.mapping_kode_akun b ON a.id_mapping_kode_akun = b.id_mapping_kode_akun
					INNER JOIN trans.jenis_transaksi c ON b.id_jenis_transaksi = c.id_jenis_transaksi
					INNER JOIN trans.sub_kode_kas d ON c.id_sub_kode_kas = d.id_sub_kode_kas
					INNER JOIN trans.transaksi e ON a.id_transaksi = e.id_transaksi
					LEFT JOIN trans.mapping_penerima f ON e.id_transaksi = f.id_transaksi
					LEFT JOIN trans.pihak_penerima g ON f.id_pihak_penerima = g.id_pihak_penerima
					WHERE
					b.flag_debet_kredit = 2
					AND b.flag_pajak = 1
					AND d.id_kode_kas = 15
					AND DATE_PART('MONTH', e.tanggal) = ?
					AND DATE_PART('YEAR', e.tanggal) = ?
					{$sql_plus}
					ORDER BY
					e.tanggal,
					e.id_transaksi
					";					
			$arr_lap =& $this->db->getRows($sql, $arr_params);
						
			/****************************   END SQL  ****************************/			

			/********************** BEGIN : GENERATE EXCEL **********************/
			$this->load->library('Excel');
			
			$objExcel = new Excel();
			
			$objExcel->setActiveSheetIndex(0)
					 ->mergeCells('A1:E1');
					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A1:E1')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 					 				 
			$objExcel->getActiveSheet()		
					 ->setCellValue('A1', 'LAPORAN BULANAN PENGELUARAN KAJIAN RUTIN')
					 ->setCellValue('A3', 'TANGGAL CETAK')
					 ->setCellValue('A4', 'PERIODE')
					 ->setCellValue('B3', ':')
					 ->setCellValue('B4', ':')
					 ->setCellValue('C3', strtoupper(getCurrentDate(FALSE)))
					 ->setCellValue('C4', getMonthString($month) . ', ' . $year)
					 ->setTitle('Report - Pengeluaran Kajian');

			if (is_numeric($id_sub_kode_kas)) {
				$objExcel->getActiveSheet()
						 ->setCellValue('A5', 'PENGELUARAN')
						 ->setCellValue('B5', ':')
						 ->setCellValue('C5', strtoupper($sub_kas));
			}
			
			$objExcel->getActiveSheet()
					 ->setCellValue('A7', 'NO.')
					 ->setCellValue('B7', 'TANGGAL')
					 ->setCellValue('C7', 'KETERANGAN')
					 ->setCellValue('D7', 'NOMINAL');
			
			$i 	  = 1;			
			foreach ($arr_lap as $lap) {
				$tanggal 	= $lap['tanggal'];
				$keterangan = $lap['keterangan'];
				$nama		= $lap['nama'];
				$nominal	= $lap['nominal'];
				
				$baris 		= $i + 7;

				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $baris, $i++)
						 ->setCellValue('B' . $baris, $tanggal)
						 ->setCellValue('C' . $baris, $keterangan . (empty($nama) ? '' : ', ' . $nama))
						 ->setCellValue('D' . $baris, $nominal);
			}
			
			$objExcel->showExcel($this->session->userdata('session_id') . '_' . time());
			/********************** END   : GENERATE EXCEL **********************/						 						
			
		}		

		public function pengeluaranRamadhan() {
			$this->password->getUrlAccess('/sie/lapBulanan', 'cetak');
				
			$id_sub_kode_kas	= $this->getVar('id_sub_kode_kas', FALSE);				
			$kode_format		= $this->getVar('kode_format', TRUE);									
			$month 	   			= $this->getVar('month', TRUE);
			$year  	   			= $this->getVar('year', TRUE);
		
			if ($kode_format != 1) {
				$this->pengeluaranRamadhanExcel($month, $year, $id_sub_kode_kas);
				exit(0);
			} 					

			/****************************  BEGIN SQL ****************************/	

			$sql_plus 		= '';
			$arr_params		= array();
			$arr_params[]	= $month;
			$arr_params[]	= $year;
			if (is_numeric($id_sub_kode_kas)) {
				$sql_plus 		= 'AND d.id_sub_kode_kas = ?';
				$arr_params[] 	= $id_sub_kode_kas;
				$sql =	"
						SELECT
						sub_kas
						FROM
						trans.sub_kode_kas
						WHERE
						id_sub_kode_kas = ?
						LIMIT 1
						OFFSET 0
						";
				$sub_kas = $this->db->getField('sub_kas', $sql, array($id_sub_kode_kas));
			}

			$sql =	"
					SELECT
					e.tanggal,
					e.keterangan,
					g.nama,
					a.nominal
					FROM
					trans.sub_transaksi a
					INNER JOIN trans.mapping_kode_akun b ON a.id_mapping_kode_akun = b.id_mapping_kode_akun
					INNER JOIN trans.jenis_transaksi c ON b.id_jenis_transaksi = c.id_jenis_transaksi
					INNER JOIN trans.sub_kode_kas d ON c.id_sub_kode_kas = d.id_sub_kode_kas
					INNER JOIN trans.transaksi e ON a.id_transaksi = e.id_transaksi
					LEFT JOIN trans.mapping_penerima f ON e.id_transaksi = f.id_transaksi
					LEFT JOIN trans.pihak_penerima g ON f.id_pihak_penerima = g.id_pihak_penerima
					WHERE
					b.flag_debet_kredit = 2
					AND b.flag_pajak = 1
					AND d.id_kode_kas = 19
					AND DATE_PART('MONTH', e.tanggal) = ?
					AND DATE_PART('YEAR', e.tanggal) = ?
					{$sql_plus}
					ORDER BY
					e.tanggal,
					e.id_transaksi
					";					
			$arr_lap =& $this->db->getRows($sql, $arr_params);
						
			/****************************   END SQL  ****************************/
			
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
			$arrCol['title'] = 'KETERANGAN';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);			

			$arrCol = array();
			$arrCol['title'] = 'NOMINAL';
			$arrCol['width'] = 50;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);			
						
			/**************************** END HEAD ****************************/
			
			$params 			   	= array();
			$params['arrHead'] 		= $mainCols;
			$params['orientation'] 	= 'P';
			$params['format'] 	   	= 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');
			$this->load->helper('number');
			
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg', 30);
			$this->report->SetReportMainTitle('LAPORAN BULANAN PENGELUARAN RAMADHAN');

			$current_width = $this->report->GetWidth();

			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->SetReportTitle('PERIODE', strtoupper(getMonthString($month) . ', ' . $year));
			if (is_numeric($id_sub_kode_kas))
				$this->report->SetReportTitle('PENGELUARAN', strtoupper($sub_kas));
			
			$this->report->Open();
			$this->report->AddPage();
			
			/**************************** BEGIN CONTENT ****************************/
			
			$i 	  = 1;			
			foreach ($arr_lap as $lap) {
				$tanggal 	= $lap['tanggal'];
				$keterangan = $lap['keterangan'];
				$nama		= $lap['nama'];
				$nominal	= $lap['nominal'];
				
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = getLocalDate($tanggal);
				$arrData[] = $keterangan . (empty($nama) ? '' : ', ' . $nama);
				$arrData[] = numFormat($nominal);
				$this->report->InsertRow($arrData);				
			}
					
			/****************************  END CONTENT  ****************************/			
			
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);		
		}
		
		private function pengeluaranRamadhanExcel($month, $year, $id_sub_kode_kas) {
			$this->load->helper('date');
			$this->load->helper('number');
			
			/****************************  BEGIN SQL ****************************/	

			$sql_plus 		= '';
			$arr_params		= array();
			$arr_params[]	= $month;
			$arr_params[]	= $year;
			if (is_numeric($id_sub_kode_kas)) {
				$sql_plus 		= 'AND d.id_sub_kode_kas = ?';
				$arr_params[] 	= $id_sub_kode_kas;
				$sql =	"
						SELECT
						sub_kas
						FROM
						trans.sub_kode_kas
						WHERE
						id_sub_kode_kas = ?
						LIMIT 1
						OFFSET 0
						";
				$sub_kas = $this->db->getField('sub_kas', $sql, array($id_sub_kode_kas));
			}

			$sql =	"
					SELECT
					e.tanggal,
					e.keterangan,
					g.nama,
					a.nominal
					FROM
					trans.sub_transaksi a
					INNER JOIN trans.mapping_kode_akun b ON a.id_mapping_kode_akun = b.id_mapping_kode_akun
					INNER JOIN trans.jenis_transaksi c ON b.id_jenis_transaksi = c.id_jenis_transaksi
					INNER JOIN trans.sub_kode_kas d ON c.id_sub_kode_kas = d.id_sub_kode_kas
					INNER JOIN trans.transaksi e ON a.id_transaksi = e.id_transaksi
					LEFT JOIN trans.mapping_penerima f ON e.id_transaksi = f.id_transaksi
					LEFT JOIN trans.pihak_penerima g ON f.id_pihak_penerima = g.id_pihak_penerima
					WHERE
					b.flag_debet_kredit = 2
					AND b.flag_pajak = 1
					AND d.id_kode_kas = 19
					AND DATE_PART('MONTH', e.tanggal) = ?
					AND DATE_PART('YEAR', e.tanggal) = ?
					{$sql_plus}
					ORDER BY
					e.tanggal,
					e.id_transaksi
					";					
			$arr_lap =& $this->db->getRows($sql, $arr_params);
						
			/****************************   END SQL  ****************************/			

			/********************** BEGIN : GENERATE EXCEL **********************/
			$this->load->library('Excel');
			
			$objExcel = new Excel();
			
			$objExcel->setActiveSheetIndex(0)
					 ->mergeCells('A1:E1');
					 
			$objExcel->getActiveSheet()		 
					 ->getStyle('A1:E1')
					 ->getAlignment()
					 ->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER)
					 ->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
					 					 				 
			$objExcel->getActiveSheet()		
					 ->setCellValue('A1', 'LAPORAN BULANAN PENGELUARAN RAMADHAN')
					 ->setCellValue('A3', 'TANGGAL CETAK')
					 ->setCellValue('A4', 'PERIODE')
					 ->setCellValue('B3', ':')
					 ->setCellValue('B4', ':')
					 ->setCellValue('C3', strtoupper(getCurrentDate(FALSE)))
					 ->setCellValue('C4', getMonthString($month) . ', ' . $year)
					 ->setTitle('Report - Pengeluaran Ramadhan');

			if (is_numeric($id_sub_kode_kas)) {
				$objExcel->getActiveSheet()
						 ->setCellValue('A5', 'PENGELUARAN')
						 ->setCellValue('B5', ':')
						 ->setCellValue('C5', strtoupper($sub_kas));
			}
			
			$objExcel->getActiveSheet()
					 ->setCellValue('A7', 'NO.')
					 ->setCellValue('B7', 'TANGGAL')
					 ->setCellValue('C7', 'KETERANGAN')
					 ->setCellValue('D7', 'NOMINAL');
			
			$i 	  = 1;			
			foreach ($arr_lap as $lap) {
				$tanggal 	= $lap['tanggal'];
				$keterangan = $lap['keterangan'];
				$nama		= $lap['nama'];
				$nominal	= $lap['nominal'];
				
				$baris 		= $i + 7;

				$objExcel->getActiveSheet()
						 ->setCellValue('A' . $baris, $i++)
						 ->setCellValue('B' . $baris, $tanggal)
						 ->setCellValue('C' . $baris, $keterangan . (empty($nama) ? '' : ', ' . $nama))
						 ->setCellValue('D' . $baris, $nominal);
			}
			
			$objExcel->showExcel($this->session->userdata('session_id') . '_' . time());
			/********************** END   : GENERATE EXCEL **********************/						 						
			
		}		
		
	}
	
/* End of file lapBulanan.php */
/* Location: ./system/application/controllers/sie/lapBulanan.php */	