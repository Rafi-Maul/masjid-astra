<?php
	if (!defined('BASEPATH')) exit('No direct script access allowed');

	class Service extends MyController {

		public function __construct() {
			parent::__construct();
		}

		public function select() {
			$response = '';
			// TABLE
			list(, $table)    = each($_POST);
			// SHOW
			list(, $show)     = each($_POST);
			// VALUE
			list(, $hidden)   = each($_POST);
			// WHERE
			list($id, $value) = each($_POST);
			// OPT
			list(, $opt) 	  = each($_POST);
			
			// QUERY...
			if (trim($value) != '') {
				if (is_numeric($value))
					$strWhere = "{$id}={$value}";
				else
					$strWhere = "{$id}='{$value}'";
					
				$sql = "
					   SELECT
					   {$show} AS show,
					   {$hidden} AS hidden
					   FROM
					   {$table}
					   WHERE
					   {$id} = ?
					   {$opt}
					   ";
					   
				$rows =& $this->db->getRows($sql, array($value));
					
				foreach ($rows as $row) {
					$show   = $row['show'];
					$hidden = $row['hidden'];
					if ($response != '') $response .= '~';
					$response .= "{$show}^{$hidden}";
				}
			}

			$data 			  = array();
			$data['response'] = $response;
			$this->load->view('core/service', $data);
		}
	
	}

/* End of file service.php */
/* Location: ./system/application/controllers/core/service.php */