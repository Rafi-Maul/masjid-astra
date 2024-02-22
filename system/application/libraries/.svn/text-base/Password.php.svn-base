<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Password {
		private $ci;

		private $masterAccess;
		private $accessCode;						
		private $url;
	 	
	 	/**
	 	 * Constructor.
	 	 */		  	 	
	 	public function __construct() {
			log_message('DEBUG', 'Password Class Initialized');	 	
			$this->ci =& get_instance();			
		 }
		 
		/**
		 * Bagian ini harus diperdalam agar keamanan aplikasi lebih terjamin.
		 */		 		
		public function loginProcess($id, $pass) {
			log_message('DEBUG', 'id => ' . $id . ', password => ' . $pass);
			$pass = md5(md5($pass) . 'search4buy');
			log_message('DEBUG', 'password setelah enkripsi => ' . $pass);
			try {
				$rs =& $this->ci->db->getRows('SELECT username, id_dd_users, id_dd_groups FROM dd_users WHERE username = ? AND passkeys = ?', array($id, $pass));
				if (count($rs) == 1) {
					$this->ci->session->set_userdata('flag_login', true);
					$this->ci->session->set_userdata('username', $rs[0]['username']);					
					$this->ci->session->set_userdata('id_dd_users', $rs[0]['id_dd_users']);
					$this->ci->session->set_userdata('id_dd_groups', $rs[0]['id_dd_groups']);
					return true;
				} else
					return false;
			} catch (Exception $e) {
				return false;		
			}
		}
		
		public function setPassword($passkeys) {
			return md5(md5($passkeys) . 'search4buy');
		}
		
		public function setAccess($masterAccess, $accessCode, $url) {
			$this->masterAccess = $masterAccess;
			$this->accessCode   = $accessCode;
			$this->url			= $url;
		}
		
		/**
		 * Bagian ini berguna untuk melakukan pemeriksaan hak akses per halaman.
		 */
		public function getAccess($right) {
			if (isset($this->masterAccess[strtolower($right)])) {
				$checkCode = $this->masterAccess[strtolower($right)];
				return (($checkCode & $this->accessCode) == $checkCode);
			} else
				return false;
		}	
		
		public function getUrlAccess($url = '', $accessName = '') {
			if (empty($url)) {
				// Untuk halaman index
				if ($this->accessCode == 0)
					show_error('Anda tidak mempunyai hak untuk mengakses halaman ini !');
			} else {
				// Untuk halaman bukan index
				$id_dd_users = $this->ci->session->userdata('id_dd_users');
					 			
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
				$givenAccess = $this->ci->db->getRow($sql, array($id_dd_users, $url));	
				
				if (count($givenAccess) > 0)
					$accessCode = $givenAccess['access_code'];
				else
					show_error('Anda tidak mempunyai hak untuk mengakses halaman ini !');
				
				if (!empty($accessName)) {
					if (isset($this->masterAccess[strtolower($accessName)]))
						$checkCode = $this->masterAccess[strtolower($accessName)];
					else
						show_error('Anda tidak mempunyai hak untuk mengakses halaman ini !');
						
					if (($checkCode & $accessCode) != $checkCode)
						show_error('Anda tidak mempunyai hak untuk mengakses halaman ini !');						
				} else if ($this->accessCode == 0)
					show_error('Anda tidak mempunyai hak untuk mengakses halaman ini !');
					
			}
		}
		
		public function getAccessCode() {
			return $this->accessCode;
		}	 
		
		public function getMasterAccess() {
			return $this->masterAccess;
		}
						
	}
	
/* End of file Password.php */
/* Location: ./system/application/libraries/Password.php */	
