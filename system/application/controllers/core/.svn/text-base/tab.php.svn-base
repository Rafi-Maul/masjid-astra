<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Tab extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'core::Tab Class Initialized');
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
						$sql_plus = 'lower(d.tab) LIKE ?';
						$params[] = "%{$keyword}%";
						break;				
					case 2 :
						$sql_plus = 'lower(c.sub_menu) LIKE ?';
						$params[] = "%{$keyword}%";
						break;				
					case 3 :
						$sql_plus = 'lower(b.menu) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 4 :
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
				   b.menu,
				   c.sub_menu,
				   d.*
				   FROM
				   dd_moduls a
				   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
				   INNER JOIN dd_sub_menus c ON b.id_dd_menus = c.id_dd_menus
				   INNER JOIN dd_tabs d ON c.id_dd_sub_menus = d.id_dd_sub_menus
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   a.order_number,
				   b.order_number,
				   c.order_number,
				   d.order_number
				   ";
				   			
			try {
				$arr_tab =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 = array();
			$data['filter']	 = $filter;
			$data['keyword'] = $keyword;	
			$data['arr_tab'] = $arr_tab;
			$data['page'] 	 = $page;
			$this->load->viewPage('core/list_tab', $data);						
		}		
		
		public function add() {
			$this->password->getUrlAccess('/core/tab', 'tambah');
			
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
			$data['title'] 		= 'Tambah Tab';
			$data['arr_moduls'] = $arr_moduls;
			$this->load->viewPage('core/list_tab_add', $data);
		}			
	
		public function addAct() {
			$this->password->getUrlAccess('/core/tab', 'tambah');
			
			try {
				$this->db->beginTrans();
				
				$id_dd_sub_menus = $this->getVar('id_dd_sub_menus', TRUE);				
				$tab 	  		 = $this->getVar('tab', TRUE);				
				$flag_active     = $this->getVar('flag_active', TRUE);
				$url             = $this->getVar('url', TRUE);
				$order_number    = $this->getVar('order_number', TRUE);
				$note 		     = $this->getVar('note', FALSE);
				
				$insert					   = array();
				$insert['id_dd_sub_menus'] = $id_dd_sub_menus;								
				$insert['tab']		       = $tab;
				$insert['flag_active']     = $flag_active;
				$insert['url']             = $url;
				$insert['order_number']    = $order_number;
				$insert['note']			   = $note;
				$this->db->insert('dd_tabs', $insert);	
				
				//$lastID = $this->db->getLastID('dd_moduls_id_dd_moduls_seq');			
						
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data tab\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}	

		public function edit($id_dd_tabs, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/core/tab', 'edit');
			
			$sql = "
				   SELECT
				   a.id_dd_moduls,
				   b.id_dd_menus,
				   d.*
				   FROM
				   dd_moduls a
				   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
				   INNER JOIN dd_sub_menus c ON b.id_dd_menus = c.id_dd_menus
				   INNER JOIN dd_tabs d ON c.id_dd_sub_menus = d.id_dd_sub_menus
				   WHERE
				   d.id_dd_tabs = ?		
				   ";

			$tab = $this->db->getRow($sql, array($id_dd_tabs));		
		
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
				   id_dd_menus,
				   menu
				   FROM
				   dd_menus
				   WHERE 
				   id_dd_moduls = ?
				   ORDER BY
				   order_number
				   ";

            $arr_menus =& $this->db->getRows($sql, array($tab['id_dd_moduls']));
            
			$sql = "
				   SELECT
				   id_dd_sub_menus,
				   sub_menu
				   FROM
				   dd_sub_menus
				   WHERE
				   id_dd_menus = ?
				   ORDER BY
				   order_number		
				   ";

			$arr_submenus =& $this->db->getRows($sql, array($tab['id_dd_menus']));
            						
			$data		   		  = array();
			$data['title'] 		  = 'Edit Tab';
			$data['arr_moduls']   = $arr_moduls;
			$data['arr_menus']    = $arr_menus;
			$data['arr_submenus'] = $arr_submenus;
			$data['tab']  	      = $tab;
			$data['page']		  = $page;
			$data['filter']		  = $filter;
			$data['keyword']	  = $keyword;
			$this->load->viewPage('core/list_tab_edit', $data);
		}	

		public function editAct() {
			$this->password->getUrlAccess('/core/tab', 'edit');
			
			try {
				$this->db->beginTrans();

				$id_dd_sub_menus = $this->getVar('id_dd_sub_menus', TRUE);
				$id_dd_tabs      = $this->getVar('id_dd_tabs', TRUE);				
				$tab		     = $this->getVar('tab', TRUE);
				$flag_active	 = $this->getVar('flag_active', TRUE);
				$order_number    = $this->getVar('order_number', TRUE);
				$url    		 = $this->getVar('url', TRUE);
				$note		     = $this->getVar('note', FALSE);
				$page		     = $this->getVar('page', TRUE);
				$filter		     = $this->getVar('filter', TRUE);
				$keyword	     = $this->getVar('keyword', TRUE);

				$update					   = array();
				$update['id_dd_sub_menus'] = $id_dd_sub_menus;
				$update['tab']		       = $tab;
				$update['flag_active']     = $flag_active;
				$update['order_number']    = $order_number;
				$update['url']    		   = $url;
				$update['note']			   = $note;
				$this->db->update('dd_tabs', $update, 'id_dd_tabs = ?', array($id_dd_tabs));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data tab\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/core/tab', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_dd_tabs = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_dd_tabs));
				$where_delete = 'id_dd_tabs IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('dd_tabs', $where_delete, $arr_id_dd_tabs);				
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data tab\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/core/tab');
		}
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/core/tab', 'cetak');
			
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
			$arrCol['title'] = 'SUB MENU';
			$arrCol['width'] = 40;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'TAB';
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

			$this->report->SetReportMainTitle('LAPORAN TAB');
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
						$sql_plus = 'lower(d.tab) LIKE ?';
						$params[] = "%{$keyword}%";
						break;				
					case 2 :
						$sql_plus = 'lower(c.sub_menu) LIKE ?';
						$params[] = "%{$keyword}%";
						break;				
					case 3 :
						$sql_plus = 'lower(b.menu) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 4 :
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
				   b.menu,
				   c.sub_menu,
				   d.*
				   FROM
				   dd_moduls a
				   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
				   INNER JOIN dd_sub_menus c ON b.id_dd_menus = c.id_dd_menus
				   INNER JOIN dd_tabs d ON c.id_dd_sub_menus = d.id_dd_sub_menus
				   WHERE
				   {$sql_plus}		
				   ORDER BY
				   a.order_number,
				   b.order_number,
				   c.order_number,
				   d.order_number
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
				$arrData[] = $row['sub_menu'];
				$arrData[] = $row['tab'];												
				$arrData[] = $row['note'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}										
					
	}
	
/* End of file tab.php */
/* Location: ./system/application/controllers/core/tab.php */
