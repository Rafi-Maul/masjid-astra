<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class MappingTransaksi extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'basic::MappingTransaksi Class Initialized');
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
						$sql_plus = 'lower(c.transaksi) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql =	"
					SELECT
					c.id_jenis_transaksi,
					(a.kode::TEXT || '. '::TEXT || a.kas::TEXT) AS kas,
					(b.kode::TEXT || '. '::TEXT || b.sub_kas::TEXT) AS sub_kas,
					c.transaksi,
					(e.coa_number::TEXT || '-'::TEXT || e.uraian::TEXT) AS coa_debet,
					(g.coa_number::TEXT || '-'::TEXT || g.uraian::TEXT) AS coa_kredit,
					(i.coa_number::TEXT || '-'::TEXT || i.uraian::TEXT) AS coa_pajak
					FROM
					trans.kode_kas a
					INNER JOIN trans.sub_kode_kas b ON a.id_kode_kas = b.id_kode_kas
					INNER JOIN trans.jenis_transaksi c ON b.id_sub_kode_kas = c.id_sub_kode_kas
					LEFT JOIN trans.mapping_kode_akun d ON c.id_jenis_transaksi = d.id_jenis_transaksi AND d.flag_pajak = 1 AND d.flag_debet_kredit = 1
					LEFT JOIN akun.akdd_detail_coa e ON d.id_akdd_detail_coa = e.id_akdd_detail_coa
					LEFT JOIN trans.mapping_kode_akun f ON c.id_jenis_transaksi = f.id_jenis_transaksi AND f.flag_pajak = 1 AND f.flag_debet_kredit = 2
					LEFT JOIN akun.akdd_detail_coa g ON f.id_akdd_detail_coa = g.id_akdd_detail_coa
					LEFT JOIN trans.mapping_kode_akun h ON c.id_jenis_transaksi = h.id_jenis_transaksi AND h.flag_pajak = 2
					LEFT JOIN akun.akdd_detail_coa i ON h.id_akdd_detail_coa = i.id_akdd_detail_coa				
					WHERE
					{$sql_plus}
					ORDER BY
					(CASE WHEN d.id_mapping_kode_akun IS NULL THEN 0 ELSE 1 END),
					a.kode,
					a.kas,
					b.kode,
					b.sub_kas,
					c.transaksi					
					";
		
			try {
				$arr_mapping_transaksi =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}
				
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
				
			$data 			 				= array();
			$data['page']	 				= $page;
			$data['filter']	 				= $filter;
			$data['keyword'] 				= $keyword;
			$data['arr_mapping_transaksi']	= $arr_mapping_transaksi;
			$this->load->viewPage('basic/list_mapping_transaksi', $data);
		}		
		
		public function edit($id_jenis_transaksi, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/basic/mappingTransaksi', 'edit');
							
			$sql =	"
					SELECT
					a.id_akdd_detail_coa,
					(a.coa_number::text || '-'::text || a.uraian::text) AS uraian
					FROM
					akun.akdd_detail_coa a
					INNER JOIN akun.akdd_detail_coa_map b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
					WHERE
					a.id_akdd_level_coa = 4
					AND
					b.flag BETWEEN 1 AND 3
					ORDER BY
					a.coa_number_num
					";
			$arr_kode_akun =& $this->db->getRows($sql);
			
			$sql =	"
					SELECT
					(a.kode::TEXT || '. '::TEXT || a.kas::TEXT) AS kas,
					(b.kode::TEXT || '. '::TEXT || b.sub_kas::TEXT) AS sub_kas,
					c.transaksi,
					e.id_akdd_detail_coa AS id_coa_debet,
					g.id_akdd_detail_coa AS id_coa_kredit,
					i.id_akdd_detail_coa AS id_coa_pajak,
					h.flag_debet_kredit AS posisi_pajak
					FROM
					trans.kode_kas a
					INNER JOIN trans.sub_kode_kas b ON a.id_kode_kas = b.id_kode_kas
					INNER JOIN trans.jenis_transaksi c ON b.id_sub_kode_kas = c.id_sub_kode_kas
					LEFT JOIN trans.mapping_kode_akun d ON c.id_jenis_transaksi = d.id_jenis_transaksi AND d.flag_pajak = 1 AND d.flag_debet_kredit = 1
					LEFT JOIN akun.akdd_detail_coa e ON d.id_akdd_detail_coa = e.id_akdd_detail_coa
					LEFT JOIN trans.mapping_kode_akun f ON c.id_jenis_transaksi = f.id_jenis_transaksi AND f.flag_pajak = 1 AND f.flag_debet_kredit = 2
					LEFT JOIN akun.akdd_detail_coa g ON f.id_akdd_detail_coa = g.id_akdd_detail_coa
					LEFT JOIN trans.mapping_kode_akun h ON c.id_jenis_transaksi = h.id_jenis_transaksi AND h.flag_pajak = 2
					LEFT JOIN akun.akdd_detail_coa i ON h.id_akdd_detail_coa = i.id_akdd_detail_coa
					WHERE
					c.id_jenis_transaksi = ?
					ORDER BY
					d.flag_pajak,
					d.flag_debet_kredit					
					";
			$mapping_transaksi = $this->db->getRow($sql, array($id_jenis_transaksi));
					
			$data		   				= array();
			$data['title'] 				= 'Edit Kode Akun Transaksi';
			$data['id_jenis_transaksi']	= $id_jenis_transaksi;
			$data['arr_kode_akun']		= $arr_kode_akun;
			$data['mapping_transaksi']	= $mapping_transaksi;
			$data['page']				= $page;
			$data['filter']				= $filter;
			$data['keyword']			= $keyword;
			$this->load->viewPage('basic/list_mapping_transaksi_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/basic/mappingTransaksi', 'edit');
				
			$id_dd_users = $this->session->userdata('id_dd_users');
				
			try {
				$this->db->beginTrans();
		
				$id_jenis_transaksi	= $this->getVar('id_jenis_transaksi', TRUE);
				$id_coa_debet		= $this->getVar('id_coa_debet', TRUE);
				$id_coa_kredit		= $this->getVar('id_coa_kredit', TRUE);
				$id_coa_pajak		= $this->getInitVar('id_coa_pajak', '');				
				$flag_debet_kredit	= $this->getVar('flag_debet_kredit', (is_numeric($id_coa_pajak)));
				$page		 		= $this->getVar('page', TRUE);
				$filter		 		= $this->getVar('filter', TRUE);
				$keyword	 		= $this->getVar('keyword', TRUE);
				
				$this->db->delete('trans.mapping_kode_akun', 'id_jenis_transaksi = ?', array($id_jenis_transaksi));
				
				$insert							= array();
				$insert['id_jenis_transaksi']	= $id_jenis_transaksi;
				$insert['id_akdd_detail_coa']	= $id_coa_debet;
				$insert['id_dd_users']			= $id_dd_users;
				$insert['flag_debet_kredit']	= 1;
				$insert['flag_pajak']			= 1;
				$this->db->insert('trans.mapping_kode_akun', $insert);
				
				$insert							= array();
				$insert['id_jenis_transaksi']	= $id_jenis_transaksi;
				$insert['id_akdd_detail_coa']	= $id_coa_kredit;
				$insert['id_dd_users']			= $id_dd_users;
				$insert['flag_debet_kredit']	= 2;
				$insert['flag_pajak']			= 1;
				$this->db->insert('trans.mapping_kode_akun', $insert);
				
				if (is_numeric($id_coa_pajak)) {
					$insert							= array();
					$insert['id_jenis_transaksi']	= $id_jenis_transaksi;
					$insert['id_akdd_detail_coa']	= $id_coa_pajak;
					$insert['id_dd_users']			= $id_dd_users;
					$insert['flag_debet_kredit']	= $flag_debet_kredit;
					$insert['flag_pajak']			= 2;
					$this->db->insert('trans.mapping_kode_akun', $insert);						
				}
						
				$this->db->endTrans();
		
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data kode akun transaksi\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/basic/mappingTransaksi', 'hapus');
				
			try {
				$this->db->beginTrans();
		
				$arr_id_jenis_transaksi = $this->getVar('id_list', TRUE);
		
				$where_delete = str_repeat('?,', count($arr_id_jenis_transaksi));
				$where_delete = 'id_jenis_transaksi IN (' . substr($where_delete, 0, -1) . ')';
		
				$this->db->delete('trans.mapping_kode_akun', $where_delete, $arr_id_jenis_transaksi);
		
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data kode akun transaksi\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
				
			redirect('/basic/mappingTransaksi');
		}		
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/basic/mappingTransaksi', 'cetak');
				
			/**************************** BEGIN HEAD ****************************/
		
			$mainCols 				= array();
		
			$arrCol 				= array();
			$arrCol['title'] 		= 'NO.';
			$arrCol['width'] 		= 10;
			$arrCol['align'] 		= 'C';
			$arrCol['calign'] 		= 'R';
			$arrCol['span'] 		= 2;
			$arrCol['sub'] 			= null;
		
			array_push($mainCols, $arrCol);
			
			$mainSubCols 			= array();
			
			$arrSubCol 				= array();
			$arrSubCol['title'] 	= 'KAS';
			$arrSubCol['width'] 	= 50;
			$arrSubCol['align'] 	= 'C';
			$arrSubCol['calign'] 	= 'L';
			$arrSubCol['span'] 		= 1;
			$arrSubCol['sub'] 		= null;
			
			array_push($mainSubCols, $arrSubCol);
			
			$arrSubCol 				= array();
			$arrSubCol['title'] 	= 'SUB KAS';
			$arrSubCol['width'] 	= 50;
			$arrSubCol['align'] 	= 'C';
			$arrSubCol['calign'] 	= 'L';
			$arrSubCol['span'] 		= 1;
			$arrSubCol['sub'] 		= null;
				
			array_push($mainSubCols, $arrSubCol);
				
			$arrCol 				= array();
			$arrCol['title'] 		= 'KODE';
			$arrCol['width'] 		= 100;
			$arrCol['align'] 		= 'C';
			$arrCol['calign'] 		= 'L';
			$arrCol['span'] 		= 1;
			$arrCol['sub'] 			= $mainSubCols;
		
			array_push($mainCols, $arrCol);
		
			$arrCol 				= array();
			$arrCol['title'] 		= 'TRANSAKSI';
			$arrCol['width'] 		= 100;
			$arrCol['align'] 		= 'C';
			$arrCol['calign'] 		= 'L';
			$arrCol['span'] 		= 2;
			$arrCol['sub'] 			= null;
		
			array_push($mainCols, $arrCol);
			
			$mainSubCols 			= array();
			
			$arrSubCol 				= array();
			$arrSubCol['title'] 	= 'DEBET';
			$arrSubCol['width'] 	= 100;
			$arrSubCol['align'] 	= 'C';
			$arrSubCol['calign'] 	= 'L';
			$arrSubCol['span'] 		= 1;
			$arrSubCol['sub'] 		= null;
			
			array_push($mainSubCols, $arrSubCol);
			
			$arrSubCol 				= array();
			$arrSubCol['title'] 	= 'KREDIT';
			$arrSubCol['width'] 	= 100;
			$arrSubCol['align'] 	= 'C';
			$arrSubCol['calign'] 	= 'L';
			$arrSubCol['span'] 		= 1;
			$arrSubCol['sub'] 		= null;
			
			array_push($mainSubCols, $arrSubCol);

			$arrSubCol 				= array();
			$arrSubCol['title'] 	= 'PAJAK';
			$arrSubCol['width'] 	= 100;
			$arrSubCol['align'] 	= 'C';
			$arrSubCol['calign'] 	= 'L';
			$arrSubCol['span'] 		= 1;
			$arrSubCol['sub'] 		= null;
				
			array_push($mainSubCols, $arrSubCol);
							
			$arrCol 				= array();
			$arrCol['title'] 		= 'KODE AKUN';
			$arrCol['width'] 		= 300;
			$arrCol['align'] 		= 'C';
			$arrCol['calign'] 		= 'L';
			$arrCol['span'] 		= 1;
			$arrCol['sub'] 			= $mainSubCols;
			
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
		
			$this->report->SetReportMainTitle('LAPORAN KODE AKUN TRANSAKSI');
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
						$sql_plus = 'lower(c.transaksi) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql =	"
					SELECT
					c.id_jenis_transaksi,
					(a.kode::TEXT || '. '::TEXT || a.kas::TEXT) AS kas,
					(b.kode::TEXT || '. '::TEXT || b.sub_kas::TEXT) AS sub_kas,
					c.transaksi,
					(e.coa_number::TEXT || '-'::TEXT || e.uraian::TEXT) AS coa_debet,
					(g.coa_number::TEXT || '-'::TEXT || g.uraian::TEXT) AS coa_kredit,
					(i.coa_number::TEXT || '-'::TEXT || i.uraian::TEXT) AS coa_pajak
					FROM
					trans.kode_kas a
					INNER JOIN trans.sub_kode_kas b ON a.id_kode_kas = b.id_kode_kas
					INNER JOIN trans.jenis_transaksi c ON b.id_sub_kode_kas = c.id_sub_kode_kas
					LEFT JOIN trans.mapping_kode_akun d ON c.id_jenis_transaksi = d.id_jenis_transaksi AND d.flag_pajak = 1 AND d.flag_debet_kredit = 1
					LEFT JOIN akun.akdd_detail_coa e ON d.id_akdd_detail_coa = e.id_akdd_detail_coa
					LEFT JOIN trans.mapping_kode_akun f ON c.id_jenis_transaksi = f.id_jenis_transaksi AND f.flag_pajak = 1 AND f.flag_debet_kredit = 2
					LEFT JOIN akun.akdd_detail_coa g ON f.id_akdd_detail_coa = g.id_akdd_detail_coa
					LEFT JOIN trans.mapping_kode_akun h ON c.id_jenis_transaksi = h.id_jenis_transaksi AND h.flag_pajak = 2
					LEFT JOIN akun.akdd_detail_coa i ON h.id_akdd_detail_coa = i.id_akdd_detail_coa				
					WHERE
					{$sql_plus}
					ORDER BY
					(CASE WHEN d.id_mapping_kode_akun IS NULL THEN 0 ELSE 1 END),
					a.kode,
					a.kas,
					b.kode,
					b.sub_kas,
					c.transaksi					
					";
											
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);
	
			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();
		
				$arrData[] = $i++ . '.';
				$arrData[] = $row['kas'];
				$arrData[] = $row['sub_kas'];
				$arrData[] = $row['transaksi'];
				$arrData[] = $row['coa_debet'];
				$arrData[] = $row['coa_kredit'];
				$arrData[] = $row['coa_pajak'];												
				$this->report->InsertRow($arrData);
			}
		
			/**************************** END CONTENT ****************************/
	
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}
		
		public function getInOut() {
			$this->password->getUrlAccess();
				
			try {
				$id_kode_kas = $this->getVar('id_kode_kas', TRUE);
		
				$sql =	"
				SELECT
				flag_in_out
				FROM
				trans.kode_kas
				WHERE
				id_kode_kas = ?
				";
				$flag_in_out = $this->db->getField('flag_in_out', $sql, array($id_kode_kas));
		
				$arr_result = array(
						'status' => 1,
						'message' => $flag_in_out
				);
			} catch (Exception $e) {
				$arr_result = array(
						'status' => 0,
						'message' => $e->getMessage()
				);
			}
			echo json_encode($arr_result);
		}				
		
	}
	
/* End of file mappingTransaksi.php */
/* Location: ./system/application/controllers/basic/mappingTransaksi.php */	