<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class ArusKas extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'akun::ArusKas Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$filter  =& $this->getInitVar('filter', 1);
			$keyword =& $this->getInitVar('keyword');
			
			// Default where...
			$sql_plus = '1=1';
			$params   = array();			

			// Filter checking...
			if (!empty($keyword)) {
				$keyword = strtolower($keyword);
				switch ($filter) {
					case 1 :
						$sql_plus = 'lower(uraian) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
				   SELECT
				   *
				   FROM
				   akun.akdd_arus_kas
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   order_number
				   ";
				   			
			try {
				$arr_kas =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 = array();
			$data['filter']	 = $filter;
			$data['keyword'] = $keyword;	
			$data['arr_kas'] = $arr_kas;
			$this->load->viewPage('akun/template_kas', $data);				
		}
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/akun/arusKas', 'cetak');

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
			$arrCol['title'] = 'AKTIVITAS';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);			

			$arrCol = array();
			$arrCol['title'] = 'URAIAN';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'KODE AKUN';
			$arrCol['width'] = 50;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'URUTAN';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'KALKULASI';
			$arrCol['width'] = 20;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'KALIBRASI';
			$arrCol['width'] = 20;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
																		
			/**************************** END HEAD ****************************/
			
			$params = array();
			$params['arrHead'] = $mainCols;
			$params['orientation'] = 'L';
			$params['format'] = 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('number');
			$this->load->helper('date');			

			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(25);

			$this->report->SetReportMainTitle('LAPORAN TEMPLATE ARUS KAS');
			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->Open();
			$this->report->AddPage();

			/**************************** BEGIN CONTENT ****************************/

			// Default where...
			$sql_plus = '1=1';
			$params   = array();			

			// Filter checking...
			if (!empty($keyword)) {
				$keyword = strtolower($keyword);
				switch ($filter) {
					case 1 :
						$sql_plus = 'lower(uraian) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
				   SELECT
				   *
				   FROM
				   akun.akdd_arus_kas
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   order_number
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			$prev_bukti = '';
			foreach ($rows as $row) {
			
				switch ($row['order_number']) {
					case 110 :
						$aktivitas = 'AKTIVITAS OPERASI';
						break;
					case 210 :
						$aktivitas = 'AKTIVITAS INVESTASI';
						break;
					case 310 :
						$aktivitas = 'AKTIVITAS PENDANAAN';
						break;
					case 410 :
						$aktivitas = 'KENAIKAN/PENURUNAN BERSIH';
						break;
					case 510 :
						$aktivitas = 'SALDO AWAL';
						break;
					case 610 :
						$aktivitas = 'SALDO AKHIR';
						break;
					default :
						$aktivitas = '';
				}
							
				$arrData = array();
				
				$len = strlen(trim($row['order_number'], '0'));

				$arrData[] = $i++ . '.';
				$arrData[] = $aktivitas;
				$arrData[] = $row['uraian'];
				$arrData[] = $row['coa_range'];
				$arrData[] = $row['order_number'];
				$arrData[] = $row['kalkulasi'];
				$arrData[] = $row['kalibrasi'];
						
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}				
	}
	
/* End of file arusKas.php */
/* Location: ./system/application/controllers/akun/arusKas.php */		
