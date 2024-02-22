<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Access extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'core::Access Class Initialized');
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
						$sql_plus = 'access_name LIKE ?';
						$params[] = "%{$keyword}%";
						break;				
					case 2 :
						$sql_plus = 'access_code = ?';
						$params[] = $keyword;
						break;				
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
				   SELECT
				   *
				   FROM
				   dd_access
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   access_code
				  ";
				   			
			try {
				$arr_access =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			    = array();
			$data['page']		= $page;
			$data['filter']	    = $filter;
			$data['keyword']    = $keyword;	
			$data['arr_access'] = $arr_access;
			$this->load->viewPage('core/list_access', $data);								
		}	
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/core/access', 'cetak');
			
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
			$arrCol['title'] = 'ACCESS NAME';
			$arrCol['width'] = 40;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'ACCESS CODE';
			$arrCol['width'] = 40;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'KETERANGAN';
			$arrCol['width'] = 80;
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

			$this->report->SetReportMainTitle('LAPORAN ACCESS RIGHT');
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
						$sql_plus = 'access_name LIKE ?';
						$params[] = "%{$keyword}%";
						break;				
					case 2 :
						$sql_plus = 'access_code = ?';
						$params[] = $keyword;
						break;				
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
				   SELECT
				   *
				   FROM
				   dd_access
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   access_code
				  ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['access_name'];
				$arrData[] = $row['access_code'];
				$arrData[] = $row['note'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}													
		
	}
	
/* End of file access.php */
/* Location: ./system/application/controllers/core/access.php */
