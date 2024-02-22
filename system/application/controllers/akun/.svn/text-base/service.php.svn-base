<?php
	if (!defined('BASEPATH')) exit('No direct script access allowed');

	class Service extends MyController {

		public function __construct() {
			parent::__construct();
			log_message('DEBUG', 'akun::Service Class Initialized');
		}

		public function getJurnal() {
			
			$no_bukti = strtolower($this->getVar('no_bukti', TRUE));
			$metodenya = strtolower($this->getVar('metodenya', TRUE));
			
			$sql_1 = "";
			switch ($metodenya) {
				case 'terima':
					$sql_1 .= "AND SUBSTR(no_bukti, 1, 2) = 'JP'";
					break;
				case 'keluar':
					$sql_1 .= "AND SUBSTR(no_bukti, 1, 2) = 'JB'";
					break;
				case '':
				case 'all':
					$sql_1 .= "AND SUBSTR(no_bukti, 1, 2) NOT IN ('JB', 'JP')";
					break;
			}
			
			$arr_jurnal =& $this->db->getRows("
											  SELECT
											  id_akmt_jurnal,
											  no_bukti
											  FROM
											  akun.akmt_jurnal
											  WHERE
											  lower(no_bukti) LIKE ?
											  AND
											  flag_posting < 2
											  AND
											  flag_temp < 2
											  AND
											  flag_jurnal = 0
											  $sql_1
											  ORDER BY
											  no_bukti
											  ", array("%{$no_bukti}%"));
			echo json_encode($arr_jurnal);
		}
		
		public function getCOA() {
		
			try {
				$coa_uraian = strtolower($this->getVar('coa_uraian', TRUE));
				$metodenya = strtolower($this->getVar('metodenya', TRUE));
				
				$sql_1 = "";
				switch ($metodenya) {
					case 'terima':
						//$sql_1 .= "AND SUBSTR(a.coa_number, 1, 1)::int IN (1, 3, 4)";
						$sql_1 .= " AND c.flag IN (1, 3)";
						break;
					case 'keluar':
						//$sql_1 .= "AND SUBSTR(a.coa_number, 1, 1)::int IN (1, 2, 3, 5)";
						$sql_1 .= " AND c.flag IN (2, 3)";
						break;
				}
				
				$max_level = $this->db->getField('max_level', 'SELECT max(level_number) AS max_level FROM akun.akdd_level_coa');
				$arr_coa =& $this->db->getRows("
											   SELECT
											   a.id_akdd_detail_coa,
											   (a.coa_number || '-' || a.uraian) AS coa_uraian
											   FROM
											   akun.akdd_detail_coa a
											   INNER JOIN akun.akdd_level_coa b ON a.id_akdd_level_coa = b.id_akdd_level_coa
											   INNER JOIN akun.akdd_detail_coa_map c ON c.id_akdd_detail_coa = a.id_akdd_detail_coa
											   WHERE
											   (
											   a.coa_number LIKE ?
											   OR
											   lower(a.uraian) LIKE ?
											   )
											   $sql_1
											   AND
											   b.level_number = ?
											   ORDER BY
											   a.coa_number,
											   a.uraian
											   ", array("%{$coa_uraian}%", "%{$coa_uraian}%", $max_level));
				echo json_encode($arr_coa);										   
			} catch (Exception $e) {
				log_message('DEBUG', 'Kesalahan ajax : ' . $e->getTraceAsString());
			}
		
		}
		
		public function reset() {
			$this->db->beginTrans();
			/*
			$this->db->exec('TRUNCATE akmt_buku_besar RESTART IDENTITY');
			$this->db->exec('TRUNCATE akmt_periode RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE akmt_jurnal_det RESTART IDENTITY');
			$this->db->exec('TRUNCATE akmt_jurnal RESTART IDENTITY CASCADE');	
			$this->db->exec('TRUNCATE ammt_penyaluran RESTART IDENTITY');
			$this->db->exec('TRUNCATE ammt_penerimaan RESTART IDENTITY');
			$this->db->exec('TRUNCATE ammt_muzakki RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE ammt_mustahiq RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE amdd_wilayah RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE amdd_tipe_muzakki RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE amdd_sumber_dana RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE amdd_program_penyaluran RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE amdd_perusahaan RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE amdd_jenis_penerimaan RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE amdd_golongan_mustahiq RESTART IDENTITY CASCADE');
			$this->db->exec('TRUNCATE amdd_kelompok_mustahiq RESTART IDENTITY CASCADE');
			*/
			$this->db->endTrans();
		}
	
	}

/* End of file service.php */
/* Location: ./system/application/controllers/akun/service.php */
