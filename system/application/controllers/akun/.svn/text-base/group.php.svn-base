<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Group extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'akun::Group Class Initialized');
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
				   akun.akdd_main_coa
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   id_akdd_main_coa
				   ";
				   			
			try {
				$arr_main =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			  = array();
			$data['filter']	  = $filter;
			$data['keyword']  = $keyword;	
			$data['arr_main'] = $arr_main;
			$this->load->viewPage('akun/list_group', $data);		
		
		}

		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/akun/group', 'cetak');
			
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
			$arrCol['title'] = "TIPE AKUN";
			$arrCol['width'] = 50;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'URAIAN';
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

			$this->report->SetReportMainTitle('LAPORAN KLASIFIKASI KODE AKUN');
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
				   akun.akdd_main_coa
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   id_akdd_main_coa
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = ($row['acc_type'] == 'd' ? 'DEBET' : 'KREDIT');
				$arrData[] = $row['uraian'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}					
		
	}

/* End of file group.php */
/* Location: ./system/application/controllers/akun/group.php */
