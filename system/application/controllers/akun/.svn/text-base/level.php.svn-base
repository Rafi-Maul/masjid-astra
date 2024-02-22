<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Level extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'akun::Level Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$filter  =& $this->getInitVar('filter', 1);
			$keyword =& $this->getInitVar('keyword');
			
			$id_akmt_periode = $this->db->getField('id_akmt_periode', 'SELECT id_akmt_periode FROM akun.akmt_periode WHERE flag_temp = 2');
			
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
					case 2 :
						$sql_plus = 'level_number = ?';
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
				   akun.akdd_level_coa
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   level_number
				   ";
				   			
			try {
				$arr_level =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				$this->session->set_flashdata('s4b_error', "Tidak dapat menampilkan sesuai yang anda inginkan.");
				redirect('/akun/level');
				return;
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			   		 = array();
			$data['page']	   		 = $page;
			$data['filter']	   		 = $filter;
			$data['keyword']   		 = $keyword;	
			$data['arr_level'] 		 = $arr_level;
			$data['id_akmt_periode'] = $id_akmt_periode;
			$this->load->viewPage('akun/list_level', $data);		
		
		}
		
		public function add() {
			$this->password->getUrlAccess('/akun/level', 'tambah');
			
			$data		   		= array();
			$data['title'] 		= 'Tambah Level';
			$this->load->viewPage('akun/list_level_add', $data);
		}
		
		public function addAct() {
			$this->password->getUrlAccess('/akun/level', 'tambah');
			
			try {
				$this->db->beginTrans();
				
				$level_number = $this->getVar('level_number', TRUE);
				$level_length = $this->getVar('level_length', TRUE);				
				$uraian 	  = $this->getVar('uraian', TRUE);
				
				$insert					= array();
				$insert['level_number']	= $level_number;				
				$insert['level_length']	= $level_length;
				$insert['uraian'] 		= $uraian;
				$this->db->insert('akun.akdd_level_coa', $insert);						
						
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data level\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function edit($id_akdd_level_coa, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/akun/level', 'edit');
			
			$sql = "
				   SELECT
				   *				   
				   FROM
				   akun.akdd_level_coa
				   WHERE
				   id_akdd_level_coa = ?		
				   ";

			$level = $this->db->getRow($sql, array($id_akdd_level_coa));
						
			$data		     = array();
			$data['title']   = 'Edit Level';
			$data['level']   = $level;
			$data['page']	 = $page;
			$data['filter']	 = $filter;
			$data['keyword'] = $keyword;															
			$this->load->viewPage('akun/list_level_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/akun/level', 'edit');
			
			try {
				$this->db->beginTrans();

                $id_akdd_level_coa = $this->getVar('id_akdd_level_coa', TRUE);
				$level_number 	   = $this->getVar('level_number', TRUE);
				$level_length	   = $this->getVar('level_length', TRUE);
				$uraian 		   = $this->getVar('uraian', TRUE);
				$page		  	   = $this->getVar('page', TRUE);
				$filter		  	   = $this->getVar('filter', TRUE);
				$keyword	  	   = $this->getVar('keyword', TRUE);																								

				$update					= array();
				$update['level_number']	= $level_number;
				$update['level_length']	= $level_length;
				$update['uraian'] 		= $uraian;
				$this->db->update('akun.akdd_level_coa', $update, 'id_akdd_level_coa = ?', array($id_akdd_level_coa));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);								
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data level\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/akun/level', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_akdd_level_coa = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_akdd_level_coa));
				$where_delete = 'id_akdd_level_coa IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('akun.akdd_level_coa', $where_delete, $arr_id_akdd_level_coa);				
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data level\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/akun/level');
		}				
								
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/akun/level', 'cetak');

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
			$arrCol['title'] = 'LEVEL NUMBER';
			$arrCol['width'] = 20;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'BESAR LEVEL';
			$arrCol['width'] = 20;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
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

			$this->report->SetReportMainTitle('LAPORAN LEVEL KODE AKUN');
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
					case 2 :
						$sql_plus = 'level_number = ?';
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
				   akun.akdd_level_coa
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   level_number
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['level_number'];
				$arrData[] = $row['level_length'];
				$arrData[] = $row['uraian'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}	
				
	}
	
/* End of file level.php */
/* Location: ./system/application/controllers/akun/level.php */	
