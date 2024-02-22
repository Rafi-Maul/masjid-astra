<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Aktivitas extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'akun::Aktivitas Class Initialized');
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
						$sql_plus = 'lower(klasifikasi) LIKE ?';
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
				   akun.akdd_klasifikasi_modal
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   id_akdd_klasifikasi_modal
				   ";
				   			
			try {
				$arr_klasifikasi =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			  		 = array();
			$data['filter']	  		 = $filter;
			$data['keyword']  		 = $keyword;	
			$data['arr_klasifikasi'] = $arr_klasifikasi;
			$this->load->viewPage('akun/list_aktivitas', $data);				
		}
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/akun/aktivitas', 'cetak');

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
			$arrCol['title'] = 'ID';
			$arrCol['width'] = 20;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'KLASIFIKASI';
			$arrCol['width'] = 200;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
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

			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(25);

			$this->report->SetReportMainTitle('LAPORAN KLASIFIKASI AKTIVITAS BERSIH');
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
						$sql_plus = 'lower(klasifikasi) LIKE ?';
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
				   akun.akdd_klasifikasi_modal
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   id_akdd_klasifikasi_modal
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['id_akdd_klasifikasi_modal'];
				$arrData[] = $row['klasifikasi'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}	
				
	}
	
/* End of file aktivitas.php */
/* Location: ./system/application/controllers/akun/aktivitas.php */	
