<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class PerubahanDana extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'akun::PerubahanDana Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$filter  =& $this->getInitVar('filter', 1);
			$keyword =& $this->getInitVar('keyword', '');
			
			// Default where...
			switch ($filter) {
				case 1 :
					$sql_plus = 'lower(uraian) LIKE ?';
					$params   = array("%{$keyword}%");
					break;
				default :
					$sql_plus = '1=1';
					$params   = array();
			}
			
			$sql = "
				   SELECT
				   *
				   FROM
				   akun.akdd_perubahan_dana
				   WHERE
				   {$sql_plus}
				   ORDER BY
				   order_number
				   ";
				   			
			try {
				$arr_perubahan =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
		
			$data 			 	   = array();
			$data['arr_perubahan'] = $arr_perubahan;
			$data['page']	 	   = $page;
			$data['filter']	 	   = $filter;
			$data['keyword'] 	   = $keyword;			
			$this->load->viewPage('akun/template_perubahan', $data);							
		}
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/akun/perubahanDana', 'cetak');
			
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
			$arrCol['title'] = 'URAIAN';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
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
			
			$arrCol = array();
			$arrCol['title'] = 'URUTAN';
			$arrCol['width'] = 20;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
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

			$this->report->SetReportMainTitle('LAPORAN TEMPLATE PERUBAHAN DANA');
			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->Open();
			$this->report->AddPage();

			/**************************** BEGIN CONTENT ****************************/

			// Default where...
			switch ($filter) {
				case 1 :
					$sql_plus = 'lower(uraian) LIKE ?';
					$params   = array("%{$keyword}%");
					break;
				default :
					$sql_plus = '1=1';
					$params   = array();
			}
			
			$sql = "
				   SELECT
				   *
				   FROM
				   akun.akdd_perubahan_dana
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
				$arrData = array();
				
				$len = strlen(trim($row['order_number'], '0'));

				$arrData[] = $i++ . '.';
				$arrData[] = str_repeat(' ', (($len - 1) * 5)) . $row['uraian'];
				$arrData[] = $row['coa_range'];
				$arrData[] = $row['order_number'];
						
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}		
		
	}
	
/* End of file perubahanDana.php */
/* Location: ./system/application/controllers/akun/perubahanDana.php */			
