<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class MyLoader extends CI_Loader {
		private $ci;
	
		public function __construct() {
			log_message('DEBUG', 'MyLoader Class Initialized');
			parent::CI_Loader();
			
			$this->ci =& get_instance();
		}
		
		public function viewLogin($params = array()) {		
			$this->viewHead();

			$data                 = array();
			$data['img_folder']   = $this->ci->getImgFolder();
			$data['company_name'] = $this->ci->getCompanyName();
			$data['app_name'] 	  = $this->ci->getAppName();
			$data 				  = array_merge($data, $params);		
			$this->view($this->ci->getLoginView(), $data);
			
			$this->viewFoot();
		}
		
		public function viewMain($params = array()) {
			$this->viewHead();
			
			$data                 = array();
			$data['img_folder']   = $this->ci->getImgFolder();
			$data['company_name'] = $this->ci->getCompanyName();
			$data['app_name'] 	  = $this->ci->getAppName();
			$data 				  = array_merge($data, $params);		
			$this->view('core/main', $data);

			$this->viewFoot();
		}		
		
		public function viewMenu($params = array()) {
			$this->viewHead();
			
			$data = array();
			$data = array_merge($data, $params);
			$this->view('core/menu', $data);
			
			$this->viewFoot();						
		}
		
		public function viewTab($params = array()) {
			$this->viewHead();
			
			$data = array();
			$data = array_merge($data, $params);
			$this->view('core/tab', $data);
			
			$this->viewFoot();						
		}
		
		public function viewPage($url, $params = array()) {
			$this->viewHead();
			
			$data 				  = array();
			$data['img_folder']   = $this->ci->getImgFolder();	
			$data['foto_folder']  = $this->ci->getFotoFolder();
			$data['s4b_paging']	  = $this->ci->db->getPaging();
			$data['s4b_password'] =& $this->ci->password;		
			$data 				  = array_merge($data, $params);
			$this->view($url, $data);
			 
			$this->viewFoot();					
		}
	
		public function viewBlank() {
			$this->viewHead();
			$this->view('core/blank');
			$this->viewFoot();						
		}
		
		
		/**********************************************************************/
		
		private function viewHead() {
			$data               = array();
			$data['title']      = $this->ci->getAppName();
			$data['css_folder'] = $this->ci->getCSSFolder();
			$data['img_folder'] = $this->ci->getImgFolder();
			$data['js_folder']  = $this->ci->getJsFolder();
			$this->view($this->ci->getHtmlHead(), $data);	
		}
		
		private function viewFoot() {
			$data 				  = array();
			$data['arr_paging']   =& $this->ci->db->getPaging();
			$data['hidden_vars']  =& $this->ci->getHidden();
			$data['s4b_error']	  = $this->ci->session->flashdata('s4b_error');
			$this->view($this->ci->getHtmlFoot(), $data);		
		}
				
	}
	
/* End of file MyLoader.php */
/* Location: ./system/application/libraries/MyLoader.php */	
