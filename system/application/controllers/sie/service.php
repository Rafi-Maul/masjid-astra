<?php
	if (!defined('BASEPATH')) exit('No direct script access allowed');

	class Service extends MyController {

		public function __construct() {
			parent::__construct();
			log_message('DEBUG', 'sie::Service Class Initialized');
		}

		public function getCOA() {		
			$coa = strtolower(trim($this->getVar('coa', TRUE)));

			$arr_coa =& $this->db->getRows("
										   SELECT
										   id_akdd_detail_coa,
										   (coa_number || ' - '::VARCHAR(3) || uraian) AS uraian
										   FROM
										   akun.akdd_coa_level_detail_v
										   WHERE
										   lower(coa_number) LIKE ?
										   OR 
										   lower(uraian) LIKE ?
										   ORDER BY
										   coa_number
										   ", array("%{$coa}%", "%{$coa}%"));
			
			echo json_encode($arr_coa);
		}		
	}

/* End of file service.php */
/* Location: ./system/application/controllers/sie/service.php */
