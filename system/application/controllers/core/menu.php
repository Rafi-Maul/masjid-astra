<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Menu extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'core::Menu Class Initialized');
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
						$sql_plus = 'lower(b.menu) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 2 :
						$sql_plus = 'lower(a.modul) LIKE ?';
						$params[] = "%{$keyword}%";					
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
				   SELECT
				   a.modul,
				   b.*,
				   c.id_dd_menus AS id_dd_sub_menus
				   FROM
				   dd_moduls a
				   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
				   LEFT JOIN (
						SELECT
						id_dd_menus
						FROM
						dd_sub_menus
						GROUP BY
						id_dd_menus
				   ) c ON b.id_dd_menus = c.id_dd_menus
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   a.order_number,
				   b.order_number
				   ";
				   			
			try {
				$arr_menu =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			   = array();
			$data['page']	   = $page;
			$data['filter']	   = $filter;
			$data['keyword']   = $keyword;	
			$data['arr_menu'] = $arr_menu;
			$this->load->viewPage('core/list_menu', $data);		
		}	
		
		public function add() {
			$this->password->getUrlAccess('/core/menu', 'tambah');
			
			$sql = "
				   SELECT
				   id_dd_moduls,
				   modul
				   FROM
				   dd_moduls
				   ORDER BY
				   order_number
				   ";
				   
			$arr_moduls =& $this->db->getRows($sql);
			
			$data		   		= array();
			$data['title'] 		= 'Tambah Menu';
			$data['arr_moduls'] = $arr_moduls;
			$this->load->viewPage('core/list_menu_add', $data);
		}		
		
		public function addAct() {
			$this->password->getUrlAccess('/core/menu', 'tambah');
			
			try {
				$this->db->beginTrans();
				
				$id_dd_moduls = $this->getVar('id_dd_moduls', TRUE);
				$menu 		  = $this->getVar('menu', TRUE);				
				$order_number = $this->getVar('order_number', TRUE);
				$note 		  = $this->getVar('note', FALSE);
				
				$insert					= array();
				$insert['id_dd_moduls']	= $id_dd_moduls;				
				$insert['menu']			= strtoupper($menu);
				$insert['order_number'] = $order_number;
				$insert['note']			= $note;
				$this->db->insert('dd_menus', $insert);	
				
				//$lastID = $this->db->getLastID('dd_moduls_id_dd_moduls_seq');			
						
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data menu\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function edit($id_dd_menus, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/core/menu', 'edit');
			
			$sql = "
				   SELECT
				   id_dd_moduls,
				   modul
				   FROM
				   dd_moduls
				   ORDER BY
				   order_number
				   ";
				   
			$arr_moduls =& $this->db->getRows($sql);

			$sql = "
				   SELECT
				   a.modul,
				   b.*
				   FROM
				   dd_moduls a
				   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
				   WHERE
				   b.id_dd_menus = ?		
				   ";

			$menu = $this->db->getRow($sql, array($id_dd_menus));
						
			$data		   		= array();
			$data['title'] 		= 'Edit Menu';
			$data['arr_moduls'] = $arr_moduls;
			$data['menu']  		= $menu;
			$data['page']		= $page;
			$data['filter']		= $filter;
			$data['keyword']	= $keyword;						
			$this->load->viewPage('core/list_menu_edit', $data);
		}
		
		public function editAct() {
			$this->password->getUrlAccess('/core/menu', 'edit');
			
			try {
				$this->db->beginTrans();

                $id_dd_menus  = $this->getVar('id_dd_menus', TRUE);
				$id_dd_moduls = $this->getVar('id_dd_moduls', TRUE);
				$menu		  = $this->getVar('menu', TRUE);
				$order_number = $this->getVar('order_number', TRUE);
				$note		  = $this->getVar('note', FALSE);
				$page		  = $this->getVar('page', TRUE);
				$filter		  = $this->getVar('filter', TRUE);
				$keyword	  = $this->getVar('keyword', TRUE);												

				$update					= array();
				$update['id_dd_moduls']	= $id_dd_moduls;
				$update['menu']			= strtoupper($menu);
				$update['order_number'] = $order_number;
				$update['note']			= $note;
				$this->db->update('dd_menus', $update, 'id_dd_menus = ?', array($id_dd_menus));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);												
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data menu\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/core/menu', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_dd_menus = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_dd_menus));
				$where_delete = 'id_dd_menus IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('dd_menus', $where_delete, $arr_id_dd_menus);				
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data menu\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/core/menu');
		}
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/core/menu', 'cetak');
			
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
			$arrCol['title'] = 'MENU';
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

			$this->report->SetReportMainTitle('LAPORAN MENU');
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
						$sql_plus = 'lower(b.menu) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 2 :
						$sql_plus = 'lower(a.modul) LIKE ?';
						$params[] = "%{$keyword}%";					
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
				   SELECT
				   a.modul,
				   b.*
				   FROM
				   dd_moduls a
				   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   a.order_number,
				   b.order_number
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['order_number'];
				$arrData[] = $row['modul'];
				$arrData[] = $row['menu'];				
				$arrData[] = $row['note'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}					
		
	}
	
/* End of file menu.php */
/* Location: ./system/application/controllers/core/menu.php */
