<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class GroupAccess extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'core::Group Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			// Get post and/or flash data...
			$filter  =& $this->getInitVar('filter', 1);
			$keyword =& $this->getInitVar('keyword');
				
			// Default where...
			$sql_plus = '1<>1';
			$params   = array();			

			// Filter checking...
			if (!empty($keyword)) {
				$keyword = strtolower($keyword);
				switch ($filter) {
					case 1 :
						$sql_plus = 'e1.id_dd_groups = ?';
						$params[] = $keyword;
						break;
					default :
						$sql_plus = '1<>1';
				}
			}
			
				   			
			try {
			
				if (!empty($keyword)) {
					$sql = "
			   			   SELECT
						   a.modul,
						   b.menu,
						   c.sub_menu,
						   d.id_dd_tabs,
						   d.tab,
						   e.access_code
						   FROM
						   dd_moduls a
						   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
						   INNER JOIN dd_sub_menus c ON b.id_dd_menus = c.id_dd_menus
						   INNER JOIN dd_tabs d ON c.id_dd_sub_menus = d.id_dd_sub_menus
						   LEFT JOIN (
							   SELECT
							   e2.id_dd_tabs,
							   e1.id_dd_groups,
							   e2.access_code
							   FROM
							   dd_groups e1
							   LEFT JOIN
							   dd_groups_detail e2 ON e1.id_dd_groups = e2.id_dd_groups
							   WHERE
							   {$sql_plus} 
							   
						   ) e ON d.id_dd_tabs = e.id_dd_tabs
						   ORDER BY
						   a.order_number,
						   b.order_number,
						   c.order_number,
						   d.order_number					
						   ";			
					$arr_moduls =& $this->db->getRows($sql, $params);				
				} else
					$arr_moduls = array();
				
				$sql = "
				   	   SELECT
				   	   id_dd_groups,
				   	   group_name
				   	   FROM
				   	   dd_groups
				   	   ORDER BY 
				   	   group_name
				       ";
				$arr_groups =& $this->db->getRows($sql);				       

				$sql = "
					   SELECT
					   id_dd_access,
					   access_name,
					   access_code
					   FROM
					   dd_access
					   ORDER BY
					   access_code
					   ";
				$arr_access =& $this->db->getRows($sql);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
					
			$data 			    = array();
			$data['filter']	    = $filter;
			$data['keyword']    = $keyword;	
			$data['arr_moduls'] = $arr_moduls;
			$data['arr_groups'] = $arr_groups;
			$data['arr_access'] = $arr_access;			
			$this->load->viewPage('core/list_groupaccess', $data);				
		}		
		
		public function process() {
			$this->password->getUrlAccess('/core/groupAccess', 'proses');
			
			try {
				$this->db->beginTrans();
				
				$filter 	  = $this->getVar('filter', TRUE);				
				$id_dd_groups = $this->getVar('id_dd_groups', TRUE);
				$id_dd_tabs	  = $this->getVar('id_dd_tabs', TRUE);
				$access_code  = $this->getVar('access_code', TRUE);
				
				$this->db->delete('dd_groups_detail', 'id_dd_groups = ?', array($id_dd_groups));
				
				$this->db->resetSequence('dd_groups_detail', 'id_dd_groups_detail', 'dd_groups_detail_id_dd_groups_detail_seq');
				
				foreach ($id_dd_tabs as $index => $id_tabs) {
					if (!empty($access_code[$index])) {
						$insert = array();
						$insert['id_dd_groups'] = $id_dd_groups;
						$insert['id_dd_tabs'] = $id_tabs;
						$insert['access_code'] = $access_code[$index];
						$this->db->insert('dd_groups_detail', $insert);
					}
				}
										
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				//$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus memproses data\n\nPenjelasan Teknis:\n{$e->getMessage()}");
				echo "Tidak dapat memproses data\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}

			$this->session->set_flashdata('filter', $filter);
			$this->session->set_flashdata('keyword', $id_dd_groups);		
			
			//redirect('/core/groupAccess');	
		}
		
		
	}
	
/* End of file groupAccess.php */
/* Location: ./system/application/controllers/core/groupAccess.php */	
