<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Modul extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'core::Modul Class Initialized');
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
						$sql_plus = 'lower(a.modul) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
				   SELECT
				   a.*,
				   b.id_dd_moduls AS id_dd_menus
				   FROM
				   dd_moduls a
				   LEFT JOIN (
						SELECT
						id_dd_moduls
						FROM						
						dd_menus
						GROUP BY
						id_dd_moduls
				   ) b ON a.id_dd_moduls = b.id_dd_moduls
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   a.order_number
				   ";
				   			
			try {
				$arr_modul =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			   = array();
			$data['page']	   = $page;
			$data['filter']	   = $filter;
			$data['keyword']   = $keyword;	
			$data['arr_modul'] = $arr_modul;
			$this->load->viewPage('core/list_modul', $data);		
		}		

		public function add() {
			$this->password->getUrlAccess('/core/modul', 'tambah');
			
			$data		   = array();
			$data['title'] = 'Tambah Modul';
			$this->load->viewPage('core/list_modul_add', $data);
		}
		
		public function addAct() {
			$this->password->getUrlAccess('/core/modul', 'tambah');
			
			try {
				$this->db->beginTrans();
				
				$modul 		  = $this->getVar('modul', TRUE);
				$order_number = $this->getVar('order_number', TRUE);
				$note 		  = $this->getVar('note', FALSE);
				
				$insert					= array();
				$insert['modul']		= strtoupper($modul);
				$insert['order_number'] = $order_number;
				$insert['note']			= $note;
				$this->db->insert('dd_moduls', $insert);	
				
				//$lastID = $this->db->getLastID('dd_moduls_id_dd_moduls_seq');			
						
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data modul\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}

		public function edit($id_dd_moduls, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/core/modul', 'edit');
			
			$sql = "
				   SELECT
				   *
				   FROM
				   dd_moduls
				   WHERE
				   id_dd_moduls = ?				   
				   ";				   
			$modul = $this->db->getRow($sql, array($id_dd_moduls));
			
			$data		     = array();
			$data['title']   = 'Edit Modul';
			$data['modul']   = $modul;
			$data['page']	 = $page;
			$data['filter']	 = $filter;
			$data['keyword'] = $keyword;						
			$this->load->viewPage('core/list_modul_edit', $data);
		}

		public function editAct() {
			$this->password->getUrlAccess('/core/modul', 'edit');
			
			try {
				$this->db->beginTrans();

				$id_dd_moduls = $this->getVar('id_dd_moduls', TRUE);
				$modul		  = $this->getVar('modul', TRUE);
				$order_number = $this->getVar('order_number', TRUE);
				$note		  = $this->getVar('note', FALSE);
				$page		  = $this->getVar('page', TRUE);
				$filter		  = $this->getVar('filter', TRUE);
				$keyword	  = $this->getVar('keyword', TRUE);								

				$update					= array();
				$update['modul']		= strtoupper($modul);
				$update['order_number'] = $order_number;
				$update['note']			= $note;
				$this->db->update('dd_moduls', $update, 'id_dd_moduls = ?', array($id_dd_moduls));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);								
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data modul\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/core/modul', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_dd_moduls = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_dd_moduls));
				$where_delete = 'id_dd_moduls IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('dd_moduls', $where_delete, $arr_id_dd_moduls);				
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data modul\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/core/modul');
		}
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/core/modul', 'cetak');

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
			$arrCol['title'] = "ORDER\nNUMBER";
			$arrCol['width'] = 20;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'MODUL';
			$arrCol['width'] = 40;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
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

			$this->report->SetReportMainTitle('LAPORAN MODUL');
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
						$sql_plus = 'lower(modul) LIKE ?';
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
				   dd_moduls
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   order_number
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['order_number'];
				$arrData[] = $row['modul'];
				$arrData[] = $row['note'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}
		
	}
	
/* End of file modul.php */
/* Location: ./system/application/controllers/core/modul.php */
