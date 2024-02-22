<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class SubKodeKas extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'basic::SubKodeKas Class Initialized');
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
					default :
						$sql_plus = '1=1';
				}
			}

			$sql =	"
					SELECT
					a.kode AS kode_induk,
					a.kas,
					a.flag_in_out,
					b.*
					FROM
					trans.kode_kas a
					INNER JOIN trans.sub_kode_kas b ON a.id_kode_kas = b.id_kode_kas
					WHERE
					{$sql_plus}
					ORDER BY
					a.kode,
					b.kode
					";			
				   			
			try {
				$arr_sub_kode_kas =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 			= array();
			$data['page']	 			= $page;
			$data['filter']	 			= $filter;
			$data['keyword'] 			= $keyword;	
			$data['arr_sub_kode_kas']	= $arr_sub_kode_kas;
			$this->load->viewPage('basic/list_sub_kode_kas', $data);					
		}
		
		public function add() {
			$this->password->getUrlAccess('/basic/subKodeKas', 'tambah');
			
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
									
			$data		   			= array();
			$data['title']			= 'Tambah Sub Kode Kas';
			$data['arr_kode_kas']	= $arr_kode_kas;
			$this->load->viewPage('basic/list_sub_kode_kas_add', $data);
		}	
		
		public function addAct() {
			$this->password->getUrlAccess('/basic/subKodeKas', 'tambah');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();
				
				$id_kode_kas	= $this->getVar('id_kode_kas', TRUE);
				$kode 			= $this->getVar('kode', TRUE);
				$sub_kas		= $this->getVar('sub_kas', TRUE);				
				$keterangan		= $this->getVar('keterangan', FALSE);
				
				$keterangan		= (empty($keterangan) ? NULL : $keterangan);
				
				$insert					= array();
				$insert['id_kode_kas']	= $id_kode_kas;
				$insert['id_dd_users']	= $id_dd_users;
				$insert['kode']			= $kode;
				$insert['sub_kas'] 		= $sub_kas;
				$insert['keterangan']	= $keterangan;
				$this->db->insert('trans.sub_kode_kas', $insert);
									
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data sub kode kas\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function edit($id_sub_kode_kas, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/basic/subKodeKas', 'edit');
						
			$sql =	"
					SELECT
					*
					FROM
					trans.sub_kode_kas
					WHERE
					id_sub_kode_kas = ?
					";
			$sub_kode_kas = $this->db->getRow($sql, array($id_sub_kode_kas));
						
			$sql =	"
					SELECT
					id_kode_kas,
					(kode::text || '. '::text || kas::text) AS kas
					FROM
					trans.kode_kas
					ORDER BY
					kode
					";
			$arr_kode_kas = $this->db->getRows($sql);
						
			$data		   			= array();
			$data['title'] 			= 'Edit Sub Kode Kas';
			$data['sub_kode_kas']	= $sub_kode_kas;
			$data['arr_kode_kas']	= $arr_kode_kas;
			$data['page']			= $page;
			$data['filter']			= $filter;
			$data['keyword']		= $keyword;
			$this->load->viewPage('basic/list_sub_kode_kas_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/basic/subKodeKas', 'edit');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();

				$id_kode_kas 		= $this->getVar('id_kode_kas', TRUE);
				$id_sub_kode_kas	= $this->getVar('id_sub_kode_kas', TRUE);
				$kode				= $this->getVar('kode', TRUE);
				$sub_kas			= $this->getVar('sub_kas', TRUE);				
				$keterangan			= $this->getVar('keterangan', FALSE);
				$page		 		= $this->getVar('page', TRUE);
				$filter		 		= $this->getVar('filter', TRUE);
				$keyword	 		= $this->getVar('keyword', TRUE);												
				
				$keterangan			= (empty($keterangan) ? NULL : $keterangan);

				$update					= array();
				$update['id_kode_kas']	= $id_kode_kas;
				$update['id_dd_users']	= $id_dd_users;
				$update['kode']			= $kode;
				$update['sub_kas']		= $sub_kas;
				$update['keterangan']	= $keterangan;
				$this->db->update('trans.sub_kode_kas', $update, 'id_sub_kode_kas = ?', array($id_sub_kode_kas));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);												
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data sub kode kas\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/basic/subKodeKas', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_sub_kode_kas = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_sub_kode_kas));
				$where_delete = 'id_sub_kode_kas IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('trans.sub_kode_kas', $where_delete, $arr_id_sub_kode_kas);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data sub kode kas\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/basic/subKodeKas');
		}
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/basic/subKodeKas', 'cetak');
			
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
			$arrCol['title'] 	= 'KODE KAS';
			$arrCol['width'] 	= 100;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'L';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;

			array_push($mainCols, $arrCol);

			$arrCol 			= array();
			$arrCol['title'] 	= 'SUB KODE KAS';
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

			$this->report->SetReportMainTitle('LAPORAN SUB KODE KAS');
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
					default :
						$sql_plus = '1=1';
				}
			}

			$sql =	"
					SELECT
					a.kode AS kode_induk,
					a.kas,
					a.flag_in_out,
					b.*
					FROM
					trans.kode_kas a
					INNER JOIN trans.sub_kode_kas b ON a.id_kode_kas = b.id_kode_kas
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
				$arrData[] = $row['keterangan'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}									
							
	}
	
/* End of file subKodeKas.php */
/* Location: ./system/application/controllers/basic/subKodeKas.php */	
