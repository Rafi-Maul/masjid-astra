<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class MyController extends Controller {
		private $s4b;
		private $hidden_vars;		
				
		public function __construct() {
			log_message('DEBUG', 'MyController Class Initialized');
			parent::Controller();
			
			$this->s4b = $this->config->item('s4b');
			$this->hidden_vars = array();
			
			if ($this->session->userdata('flag_login')) {
				$this->load->library('Password');
				
				$url 	 	 = '/' . $this->uri->segment(1) . '/' . $this->uri->segment(2);
				$id_dd_users = $this->session->userdata('id_dd_users');
					 			
				$sql = "
					   SELECT
					   a.access_code
					   FROM
					   dd_groups_detail a
					   INNER JOIN dd_groups b ON a.id_dd_groups = b.id_dd_groups
					   INNER JOIN dd_tabs c ON a.id_dd_tabs = c.id_dd_tabs
					   INNER JOIN dd_users d ON b.id_dd_groups = d.id_dd_groups
					   WHERE
					   d.id_dd_users = ?
					   AND
					   c.url = ?
				       ";
				$givenAccess = $this->db->getRow($sql, array($id_dd_users, $url));
				if (count($givenAccess) > 0)
					$accessCode = $givenAccess['access_code'];
				else
					$accessCode = 0;			
				
				$masterAccess = array();	
				$sql = "
				       SELECT
				       access_name,
				       access_code
					   FROM
					   dd_access	
					   ORDER BY
					   access_code
					   ";	
				$arr_access =& $this->db->getRows($sql);
				foreach ($arr_access as $access) {
					$masterAccess[$access['access_name']] = $access['access_code'];
				}
				
				$this->password->setAccess($masterAccess, $accessCode, $url);
			}			
			
		}
		
		/************************************************************************************/

		public function index() {
			show_error('Objek ini belum mempunyai halaman awal.');
		}

		public function add() {
			show_error('Objek ini belum mempunyai halaman tambah.');
		}

		public function addAct() {
			show_error('Objek ini belum mempunyai proses tambah.');
		}

		public function edit() {
			show_error('Objek ini belum mempunyai halaman edit.');
		}

		public function editAct() {
			show_error('Objek ini belum mempunyai proses edit.');
		}

		public function del() {
			show_error('Objek ini belum mempunyai proses hapus.');
		}

		public function process() {
			show_error('Objek ini belum mempunyai proses process.');
		}

		public function report() {
			show_error('Objek ini belum mempunyai halaman laporan.');
		}
		
		public function getCompanyName() {
			return $this->s4b['company_name'];
		}		
		
		public function getAppName() {
			return $this->s4b['app_name'];
		}
		
		public function getCSSFolder() {
			return $this->s4b['css_folder'];
		}
		
		public function getImgFolder() {
			return $this->s4b['img_folder'];
		}
		
		public function getFotoFolder() {
			return $this->s4b['foto_folder'];
		}		
		
		public function getJsFolder() {
			return $this->s4b['js_folder'];
		}
			
		public function getHtmlHead() {
			return $this->s4b['html_head'];
		}
		
		public function getHtmlFoot() {
			return $this->s4b['html_foot'];
		}
		
		public function getLoginView() {
			return $this->s4b['login_view'];
		}
		
		public function getListPerPage() {
			return $this->s4b['list_per_page'];
		}
		
		public function getIDPenerimaanZakat() {
			return $this->s4b['id_penerimaan_zakat'];
		}
						
		public function expired($prevMethod = '') {
			GLOBAL $method;
			$this->load->view('core/expired');
			if (!empty($prevMethod))
				$method = $prevMethod;
		}	
		
		public function blank() {
			$this->load->viewBlank();
		}
		
		public function &getHidden() {
			return $this->hidden_vars;
		}	
		
		public function getIDModal() {
			return $this->s4b['id_klasifikasi_modal'];
		}
				
		/**********************************************************************/

		protected function getVar($name, $throwOnError = FALSE) {
			$var = $this->input->post($name);
			if (is_string($var))
				$var = trim($var);

			if ($throwOnError) {
				if ($var === FALSE)
					throw new Exception("Variabel {$name} harus dilengkapi.");
				else
					return $var;
			} else
				return (($var === FALSE) ? null : $var);
		}
		
		protected function &getInitVar($name, $default = '') {
			$value = ($this->input->post($name)) ? $this->input->post($name) : (($this->session->flashdata($name)) ? $this->session->flashdata($name) : $default);
			if (is_string($value))
				$value = trim($value);
			return $value;
		}		
		
		protected function setHidden($key, $value) {
			$this->hidden_vars[$key] = $value;
			log_message('DEBUG', 'MyController::setHidden(' . $key . ', ' . $value . ')');
		}
								
	}

/* End of file MyController.php */
/* Location: ./system/application/libraries/MyController.php */
