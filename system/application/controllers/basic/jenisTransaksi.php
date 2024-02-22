<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class JenisTransaksi extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'basic::JenisTransaksi Class Initialized');
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
						$sql_plus = 'lower(a.kas) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 2 :
						$sql_plus = 'lower(b.sub_kas) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 3 :
						$sql_plus = 'lower(c.transaksi) LIKE ?';
						$params[] = "%{$keyword}%";
						break;												
					default :
						$sql_plus = '1=1';
				}
			}

			$sql =	"
					SELECT
					a.kode AS kode_induk,
					a.kas,
					a.flag_in_out,
					b.kode,
					b.sub_kas,
					c.*,
					e.klasifikasi
					FROM
					trans.kode_kas a
					INNER JOIN trans.sub_kode_kas b ON a.id_kode_kas = b.id_kode_kas
					INNER JOIN trans.jenis_transaksi c ON b.id_sub_kode_kas = c.id_sub_kode_kas
					LEFT JOIN trans.mapping_transaksi_penerima d ON c.id_jenis_transaksi = d.id_jenis_transaksi
					LEFT JOIN trans.klasifikasi_penerima e ON d.id_klasifikasi_penerima = e.id_klasifikasi_penerima
					WHERE
					{$sql_plus}
					ORDER BY
					a.kode,
					b.kode
					";			
				   			
			try {
				$arr_jenis_transaksi =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 				= array();
			$data['page']	 				= $page;
			$data['filter']	 				= $filter;
			$data['keyword'] 				= $keyword;	
			$data['arr_jenis_transaksi']	= $arr_jenis_transaksi;
			$this->load->viewPage('basic/list_jenis_transaksi', $data);					
		}
		
		public function add() {
			$this->password->getUrlAccess('/basic/jenisTransaksi', 'tambah');
			
			$sql = "
				   SELECT
				   id_kode_kas,
				   (kode::text || '. '::text || kas::text) AS kas
				   FROM
				   trans.kode_kas
				   ORDER BY
				   kode,
				   kas
				   ";
				   
			$arr_kode_kas =& $this->db->getRows($sql);		

			$sql =	"
					SELECT
					id_klasifikasi_penerima,
					klasifikasi
					FROM
					trans.klasifikasi_penerima
					ORDER BY
					klasifikasi
					";
			$arr_klasifikasi =& $this->db->getRows($sql);
									
			$data		   				= array();
			$data['title']				= 'Tambah Jenis Transaksi';
			$data['arr_kode_kas']		= $arr_kode_kas;
			$data['arr_klasifikasi']	= $arr_klasifikasi;
			$this->load->viewPage('basic/list_jenis_transaksi_add', $data);
		}	
		
		public function addAct() {
			$this->password->getUrlAccess('/basic/jenisTransaksi', 'tambah');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();
				
				$flag_in_out				= $this->getVar('flag_in_out', TRUE);				
				$id_kode_kas				= $this->getVar('id_kode_kas', TRUE);
				$id_sub_kode_kas			= $this->getVar('id_sub_kode_kas', TRUE);	
				$id_klasifikasi_penerima	= $this->getVar('id_klasifikasi_penerima', ($flag_in_out == 'o'));							
				$transaksi					= $this->getVar('transaksi', TRUE);				
				$keterangan					= $this->getVar('keterangan', FALSE);
				
				$keterangan					= (empty($keterangan) ? NULL : $keterangan);
				
				$insert						= array();
				$insert['id_sub_kode_kas']	= $id_sub_kode_kas;
				$insert['id_dd_users']		= $id_dd_users;
				$insert['transaksi']		= $transaksi;
				$insert['keterangan']		= $keterangan;
				$this->db->insert('trans.jenis_transaksi', $insert);
				
				if (($flag_in_out == 'o') && ($id_klasifikasi_penerima != 0)) {
					$id_jenis_transaksi = $this->db->getLastID('trans.jenis_transaksi_id_jenis_transaksi_seq');
					
					$insert								= array();
					$insert['id_jenis_transaksi'] 		= $id_jenis_transaksi;
					$insert['id_klasifikasi_penerima'] 	= $id_klasifikasi_penerima;
					$insert['id_dd_users']				= $id_dd_users;
					$this->db->insert('trans.mapping_transaksi_penerima', $insert);						
				}
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data jenis transaksi\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function edit($id_jenis_transaksi, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/basic/jenisTransaksi', 'edit');

			$sql =	"
					SELECT
					a.*,
					c.id_kode_kas,
					c.flag_in_out,
					d.id_klasifikasi_penerima
					FROM
					trans.jenis_transaksi a
					INNER JOIN trans.sub_kode_kas b ON a.id_sub_kode_kas = b.id_sub_kode_kas
					INNER JOIN trans.kode_kas c ON b.id_kode_kas = c.id_kode_kas
					LEFT JOIN trans.mapping_transaksi_penerima d ON a.id_jenis_transaksi = d.id_jenis_transaksi
					WHERE
					a.id_jenis_transaksi = ?
					";
			$jenis_transaksi = $this->db->getRow($sql, array($id_jenis_transaksi));
									
			$sql =	"
					SELECT
					a.id_kode_kas,
					(a.kode::text || '. '::text || a.kas::text) AS kas
					FROM
					trans.kode_kas a
					ORDER BY
					a.kode
					";
			$arr_kode_kas = $this->db->getRows($sql);
			
			$sql =	"
					SELECT
					id_sub_kode_kas,
					sub_kas
					FROM
					trans.sub_kode_kas
					WHERE
					id_kode_kas = ?
					ORDER BY
					kode
					";
			$arr_sub_kode_kas = $this->db->getRows($sql, array($jenis_transaksi['id_kode_kas']));
			
			$sql =	"
					SELECT
					id_klasifikasi_penerima,
					klasifikasi
					FROM
					trans.klasifikasi_penerima
					ORDER BY
					klasifikasi
					";
			$arr_klasifikasi = $this->db->getRows($sql);
						
			$data		   				= array();
			$data['title'] 				= 'Edit Jenis Transaksi';
			$data['jenis_transaksi']	= $jenis_transaksi;
			$data['arr_kode_kas']		= $arr_kode_kas;
			$data['arr_sub_kode_kas']	= $arr_sub_kode_kas;
			$data['arr_klasifikasi']	= $arr_klasifikasi;
			$data['page']				= $page;
			$data['filter']				= $filter;
			$data['keyword']			= $keyword;
			$this->load->viewPage('basic/list_jenis_transaksi_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/basic/jenisTransaksi', 'edit');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();

				$flag_in_out				= $this->getVar('flag_in_out', TRUE);
				$id_kode_kas 				= $this->getVar('id_kode_kas', TRUE);
				$id_sub_kode_kas			= $this->getVar('id_sub_kode_kas', TRUE);
				$id_jenis_transaksi			= $this->getVar('id_jenis_transaksi', TRUE);
				$id_klasifikasi_penerima 	= $this->getVar('id_klasifikasi_penerima', ($flag_in_out == 'o'));
				$transaksi					= $this->getVar('transaksi', TRUE);				
				$keterangan					= $this->getVar('keterangan', FALSE);
				$page		 				= $this->getVar('page', TRUE);
				$filter		 				= $this->getVar('filter', TRUE);
				$keyword	 				= $this->getVar('keyword', TRUE);												
				
				$keterangan					= (empty($keterangan) ? NULL : $keterangan);

				$update						= array();
				$update['id_sub_kode_kas']	= $id_sub_kode_kas;
				$update['id_dd_users']		= $id_dd_users;
				$update['transaksi']		= $transaksi;
				$update['keterangan']		= $keterangan;
				$this->db->update('trans.jenis_transaksi', $update, 'id_jenis_transaksi = ?', array($id_jenis_transaksi));
				
				if (($flag_in_out == 'o') && ($id_klasifikasi_penerima != 0)) {					
					$update								= array();
					$update['id_klasifikasi_penerima'] 	= $id_klasifikasi_penerima;
					$update['id_dd_users']				= $id_dd_users;
					$this->db->update('trans.mapping_transaksi_penerima', $update, 'id_jenis_transaksi = ?', array($id_jenis_transaksi));
					
					if ($this->db->getAffected() == 0) {
						$insert								= array();
						$insert['id_jenis_transaksi'] 		= $id_jenis_transaksi;
						$insert['id_klasifikasi_penerima'] 	= $id_klasifikasi_penerima;
						$insert['id_dd_users']				= $id_dd_users;
						$this->db->insert('trans.mapping_transaksi_penerima', $insert);						
					}
				} else {
					$this->db->delete('trans.mapping_transaksi_penerima', 'id_jenis_transaksi = ?', array($id_jenis_transaksi));
				}

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);												
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data jenis transaksi\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/basic/jenisTransaksi', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_jenis_transaksi = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_jenis_transaksi));
				$where_delete = 'id_jenis_transaksi IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('trans.mapping_transaksi_penerima', $where_delete, $arr_id_jenis_transaksi);
				
				$this->db->delete('trans.jenis_transaksi', $where_delete, $arr_id_jenis_transaksi);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data jenis transaksi\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/basic/jenisTransaksi');
		}
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/basic/jenisTransaksi', 'cetak');
			
			/**************************** BEGIN HEAD ****************************/

			$mainCols = array();

			$arrCol 			= array();
			$arrCol['title'] 	= 'NO.';
			$arrCol['width'] 	= 10;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'R';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;

			array_push($mainCols, $arrCol);

			$arrCol 			= array();
			$arrCol['title'] 	= 'KAS';
			$arrCol['width'] 	= 100;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'L';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;

			array_push($mainCols, $arrCol);

			$arrCol 			= array();
			$arrCol['title'] 	= 'SUB KAS';
			$arrCol['width'] 	= 100;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'L';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;

			array_push($mainCols, $arrCol);
			
			$arrCol 			= array();
			$arrCol['title'] 	= 'TIPE';
			$arrCol['width'] 	= 100;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'L';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;

			array_push($mainCols, $arrCol);			
						
			$arrCol 			= array();
			$arrCol['title'] 	= 'TRANSAKSI';
			$arrCol['width'] 	= 100;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'L';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;

			array_push($mainCols, $arrCol);			
										
			$arrCol 			= array();
			$arrCol['title'] 	= 'KETERANGAN';
			$arrCol['width'] 	= 150;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'L';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;

			array_push($mainCols, $arrCol);
			
			/**************************** END HEAD ****************************/
			
			$params 				= array();
			$params['arrHead'] 		= $mainCols;
			$params['orientation'] 	= 'P';
			$params['format'] 		= 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');

			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(25);

			$this->report->SetReportMainTitle('LAPORAN JENIS TRANSAKSI');
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
						$sql_plus = 'lower(a.kas) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 2 :
						$sql_plus = 'lower(b.sub_kas) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 3 :
						$sql_plus = 'lower(c.transaksi) LIKE ?';
						$params[] = "%{$keyword}%";
						break;												
					default :
						$sql_plus = '1=1';
				}
			}

			$sql =	"
					SELECT
					a.kode AS kode_induk,
					a.kas,
					a.flag_in_out,
					b.kode,
					b.sub_kas,
					c.*
					FROM
					trans.kode_kas a
					INNER JOIN trans.sub_kode_kas b ON a.id_kode_kas = b.id_kode_kas
					INNER JOIN trans.jenis_transaksi c ON b.id_sub_kode_kas = c.id_sub_kode_kas
					WHERE
					{$sql_plus}
					ORDER BY
					a.kode,
					b.kode
					";			
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['kode_induk'] . '. ' . $row['kas'];
				$arrData[] = $row['kode'] . '. ' . $row['sub_kas'];
				$arrData[] = ($row['flag_in_out'] == 'i' ? 'Penerimaan' : 'Pengeluaran');	
				$arrData[] = $row['transaksi'];				
				$arrData[] = $row['keterangan'];
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
	
/* End of file jenisTransaksi.php */
/* Location: ./system/application/controllers/basic/jenisTransaksi.php */	
