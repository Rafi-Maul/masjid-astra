<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Guard Class.
 * 
 * Sebagai bagian pengaman untuk penggunaan aplikasi oleh pihak-pihak yang 
 * tidak berhak.
 *  
 * Cara Kerja :
 * 1. Sistem akan memanggil fungsi check.
 * 2. Fungsi check ini akan memeriksa session yang ada.
 * 3. Bila session valid maka langkah selanjutnya adalah membiarkan sistem 
 *    berjalan secara normal.
 * 4. Bila session tidak valid maka sistem akan mendefinisikan ulang method 
 *    yang akan dipanggil dan memaksa untuk melakukan login.          
 */ 
 
	class Guard {
		private $ci;
		
		/**
		 * Constructor.
		 */		 		
		public function __construct() {
			log_message('DEBUG', 'Guard Class Initialized');
			$this->ci =& get_instance();
			
			$this->ci->output->set_header('HTTP/1.0 200 OK');
			$this->ci->output->set_header('HTTP/1.1 200 OK');
			$this->ci->output->set_header('Expires: Wed, 02 Feb 1977 06:06:06 GMT');
			$this->ci->output->set_header('Cache-Control: no-store, no-cache, must-revalidate');
			$this->ci->output->set_header('Cache-Control: post-check=0, pre-check=0', false);
			$this->ci->output->set_header('Pragma: no-cache');
			$this->ci->output->set_header('Company-Name: Search4Buy');
			$this->ci->output->set_header('Developer-Name: Hadi Ariwibowo');							
		}
		
		/**
		 * Melakukan pemeriksaan atas session dan halaman yang akan dituju.
		 */		 		
		public function check() {
			GLOBAL $class, $method, $prev_method, $hook_continue;		
			log_message('DEBUG', 'Call Guard::check');
			// Periksa session, jika tidak dilanjutkan maka buat flag_process = 0
			if (!$this->checkSession()) {
			
				if (!$this->checkPage($class, $method, 0)) {			
					$hook_continue = FALSE;
					$prev_method = $method;
					$method = 'expired';
				}
				
			} else if ($this->checkPage($class, $method, 1)) {
				// Bila sudah login tidak usah kembali ke login.
				redirect();
			} 			
		}
		
		/**
		 * Melakukan pemeriksaan session. Bagian ini harus diperdalam agar keamanan
		 * aplikasi lebih terjamin.		 
		 */			 			 				
		private function checkSession() {
			log_message('DEBUG', 'Call Guard::checkSession');
			
			$flag_login = $this->ci->session->userdata('flag_login');	
			return ($flag_login == true);
		}
		
		/**
		 * Memeriksa halaman, bila halaman ini adalah halaman login maka hasilnya
		 * adalah true sehingga tidak perlu untuk dilempar lagi.		  		
		 */		
		private function checkPage($class, $method, $flag) {
			log_message('DEBUG', 'Call Guard::checkPage');
			$s4b = $this->ci->config->item('s4b');
			
			switch ($class . '/' . $method) {
				case $s4b['login_class'] . '/' . $s4b['login_method'] :
				case $s4b['login_class'] . '/' . $s4b['login_method_act'] :				
				//case $s4b['login_class'] . '/' . $s4b['logout_method_act'] :
					$ret_val = true;
					break;
				default :
					$ret_val = false;
			}
			
			if (($ret_val == false) && ($flag == 0) && ($class == $s4b['main_class']) && ($method == $s4b['main_index']))
				redirect('core/main/login');
			
			return $ret_val;
		}		
		
	}
	
/* End of file Guard.php */
/* Location: ./system/application/hooks/Guard.php */