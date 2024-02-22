<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Login extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'core::Login Class Initialized');
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
						$sql_plus = 'lower(a.username) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			if (!in_array($this->session->userdata('id_dd_groups'), array(1, 2)))  {
				$sql_plus .= ' AND id_dd_users = ?';
				$params[]  = $this->session->userdata('id_dd_users');
			}
			
			$sql = "
				   SELECT
				   a.*,
				   b.group_name
				   FROM
				   dd_users a
				   INNER JOIN dd_groups b ON a.id_dd_groups = b.id_dd_groups 
				   WHERE
				   {$sql_plus}
				   ORDER BY
				   a.username				   				   				   
				   ";
				   			
			try {
				$arr_login =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			   = array();
			$data['page']	   = $page;
			$data['filter']	   = $filter;
			$data['keyword']   = $keyword;	
			$data['arr_login'] = $arr_login;
			$this->load->viewPage('core/list_login', $data);
		}	
		
		public function add() {
			$this->password->getUrlAccess('/core/login', 'tambah');
			
			$sql = "
				   SELECT
				   id_dd_groups,
				   group_name
				   FROM
				   dd_groups
				   WHERE
				   flag_system = 'f'
				   ORDER BY
				   group_name
				   ";
			$arr_groups =& $this->db->getRows($sql);
			
			$data		   		= array();
			$data['title'] 		= 'Tambah Login';
			$data['arr_groups'] = $arr_groups;
			$this->load->viewPage('core/list_login_add', $data);
		}
			
		public function addAct() {
			$this->password->getUrlAccess('/core/login', 'tambah');
			
			try {
				$this->db->beginTrans();
				
				$id_dd_groups = $this->getVar('id_dd_groups', TRUE);
				$username 	  = $this->getVar('username', TRUE);
				$passkeys1 	  = $this->getVar('passkeys1', TRUE);	
				$passkeys2 	  = $this->getVar('passkeys2', TRUE);				
				$note 	      = $this->getVar('note', FALSE);
				
				if ($passkeys1 != $passkeys2)
					throw new Exception('Kata sandi yang anda masukan tidak sama.');
											
				$insert				    = array();
				$insert['id_dd_groups'] = $id_dd_groups;
				$insert['username']		= $username;
				$insert['passkeys']		= $this->password->setPassword($passkeys1);
				$insert['flag_active'] 	= 't';
				$insert['flag_system'] 	= 'f';
				$insert['note']		   	= $note;				
				$this->db->insert('dd_users', $insert);				
						
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data login\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}

		public function edit($id_dd_users, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/core/login', 'edit');
			
			$sql_plus = '1=1';
			$params   = array();
			
			if (!in_array($this->session->userdata('id_dd_groups'), array(1, 12)))  {
				$sql_plus .= ' AND id_dd_groups = ?';
				$params[]  = $this->session->userdata('id_dd_groups');
			}
					
			$sql = "
				   SELECT
				   id_dd_groups,
				   group_name
				   FROM
				   dd_groups
				   WHERE
				   flag_system = 'f'
				   AND
				   {$sql_plus}
				   ORDER BY
				   group_name
				   ";
			$arr_groups =& $this->db->getRows($sql, $params);		
		
			$sql = "
				   SELECT
				   *
				   FROM
				   dd_users
				   WHERE
				   id_dd_users = ?				   
				   ";				   
			$user = $this->db->getRow($sql, array($id_dd_users));
			
			$data		        = array();
			$data['title']      = 'Edit Login';
			$data['user']       = $user;
			$data['arr_groups'] = $arr_groups;	
			$data['page']		= $page;
			$data['filter']		= $filter;
			$data['keyword']	= $keyword;									
			$this->load->viewPage('core/list_login_edit', $data);
		}
		
		public function editAct() {
			$this->password->getUrlAccess('/core/login', 'edit');
			
			try {
				$this->db->beginTrans();

                $id_dd_users  	 = $this->getVar('id_dd_users', TRUE);
				$id_dd_groups 	 = $this->getVar('id_dd_groups', TRUE);
				$username	  	 = $this->getVar('username', TRUE);
				$status_password = $this->getVar('status_password', TRUE);
				$prev_passkeys	 = $this->getVar('prev_passkeys', FALSE);
				$passkeys1		 = $this->getVar('passkeys1', FALSE);
				$passkeys2 		 = $this->getVar('passkeys2', FALSE);
				$note		  	 = $this->getVar('note', FALSE);
				$page		  	 = $this->getVar('page', TRUE);
				$filter		  	 = $this->getVar('filter', TRUE);
				$keyword	  	 = $this->getVar('keyword', TRUE);
				
				$update					= array();
				if ($status_password == 1) {					
					$passkeys = $this->password->setPassword($prev_passkeys);
			
					$sql = 	'
							SELECT
							COUNT(*) AS total
							FROM
							dd_users
							WHERE
							id_dd_users = ?
							AND
							passkeys = ?
							';
					$total = $this->db->getField('total', $sql, array($id_dd_users, $passkeys));
					
					if ($total == 1) {
						if ($passkeys1 == $passkeys2)
							$update['passkeys'] = $this->password->setPassword($passkeys1);
						else
							throw new Exception('Konfirmasi kata sandi tidak sesuai dengan kata sandinya !');
					} else
						throw new Exception('Kata sandi sebelumnya tidak benar !');
				}
				$update['id_dd_groups'] = $id_dd_groups;
				$update['username'] 	= $username;
				$update['note']			= $note;
				$this->db->update('dd_users', $update, 'id_dd_users = ?', array($id_dd_users));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data login\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}

		public function del() {
			$this->password->getUrlAccess('/core/login', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_dd_users = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_dd_users));
				$where_delete = 'id_dd_users IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('dd_users', $where_delete, $arr_id_dd_users);				
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data login\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/core/login');
		}

		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/core/login', 'cetak');

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
			$arrCol['title'] = 'GROUP';
			$arrCol['width'] = 40;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'LOGIN';
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

			$this->report->SetReportMainTitle('LAPORAN LOGIN');
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
						$sql_plus = 'lower(a.username) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			if (!in_array($this->session->userdata('id_dd_groups'), array(1, 12)))  {
				$sql_plus .= ' AND id_dd_users = ?';
				$params[]  = $this->session->userdata('id_dd_users');
			}			
			
			$sql = "
				   SELECT
				   a.*,
				   b.group_name
				   FROM
				   dd_users a
				   INNER JOIN dd_groups b ON a.id_dd_groups = b.id_dd_groups 
				   WHERE
				   {$sql_plus}
				   ORDER BY
				   a.username				   
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['group_name'];
				$arrData[] = $row['username'];
				$arrData[] = $row['note'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}
		
	}
	
/* End of file login.php */
/* Location: ./system/application/controllers/core/login.php */
