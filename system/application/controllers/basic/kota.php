<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Kota extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'basic::Kota Class Initialized');
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
						$sql_plus = 'lower(a.nama) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 2 :
						$sql_plus = 'lower(b.nama) LIKE ?';
						$params[] = "%{$keyword}%";					
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql =	"
					SELECT
					a.id_kota,
					b.nama AS propinsi,
					a.nama AS kota,
					a.keterangan
					FROM
					trans.kota a
					INNER JOIN trans.propinsi b ON a.id_propinsi = b.id_propinsi
					WHERE
					{$sql_plus}
					ORDER BY
					b.nama,
					a.nama
					";			
				   			
			try {
				$arr_kota =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 	= array();
			$data['page']	 	= $page;
			$data['filter']	 	= $filter;
			$data['keyword'] 	= $keyword;	
			$data['arr_kota']	= $arr_kota;
			$this->load->viewPage('basic/list_kota', $data);		
		}	
		
		public function add() {
			$this->password->getUrlAccess('/basic/kota', 'tambah');
			
			$sql = "
				   SELECT
				   id_propinsi,
				   nama
				   FROM
				   trans.propinsi
				   ORDER BY
				   nama
				   ";
				   
			$arr_propinsi =& $this->db->getRows($sql);			
						
			$data		   			= array();
			$data['title']			= 'Tambah Kota';
			$data['arr_propinsi'] 	= $arr_propinsi;
			$this->load->viewPage('basic/list_kota_add', $data);
		}			
		
		public function addAct() {
			$this->password->getUrlAccess('/basic/kota', 'tambah');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();
				
				$id_propinsi	= $this->getVar('id_propinsi', TRUE);
				$nama 			= $this->getVar('nama', TRUE);
				$keterangan		= $this->getVar('keterangan', FALSE);
				
				$insert					= array();
				$insert['id_propinsi']	= $id_propinsi;
				$insert['id_dd_users']	= $id_dd_users;
				$insert['nama'] 		= $nama;
				$insert['keterangan']	= $keterangan;
				$this->db->insert('trans.kota', $insert);
									
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data kota\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}	

		public function edit($id_kota, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/basic/kota', 'edit');
			
			$sql =	"
					SELECT
					*
					FROM
					trans.kota
					WHERE
					id_kota = ?
					";

			$kota = $this->db->getRow($sql, array($id_kota));
			
			$sql =	"
					SELECT
					id_propinsi,
					nama
					FROM
					trans.propinsi
					ORDER BY
					nama
					";
					
			$arr_propinsi = $this->db->getRows($sql);
						
			$data		   			= array();
			$data['title'] 			= 'Edit Kota';
			$data['kota'] 			= $kota;
			$data['arr_propinsi']	= $arr_propinsi;
			$data['page']			= $page;
			$data['filter']			= $filter;
			$data['keyword']		= $keyword;
			$this->load->viewPage('basic/list_kota_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/basic/kota', 'edit');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();

				$id_propinsi 	= $this->getVar('id_propinsi', TRUE);
				$id_kota 		= $this->getVar('id_kota', TRUE);
				$nama			= $this->getVar('nama', TRUE);
				$keterangan		= $this->getVar('keterangan', FALSE);
				$page		 	= $this->getVar('page', TRUE);
				$filter		 	= $this->getVar('filter', TRUE);
				$keyword	 	= $this->getVar('keyword', TRUE);												

				$update					= array();
				$update['id_propinsi']	= $id_propinsi;
				$update['id_dd_users']	= $id_dd_users;
				$update['nama'] 		= $nama;
				$update['keterangan']	= $keterangan;
				$this->db->update('trans.kota', $update, 'id_kota = ?', array($id_kota));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);												
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data kota\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}		
		
		public function del() {
			$this->password->getUrlAccess('/basic/kota', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_kota = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_kota));
				$where_delete = 'id_kota IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('trans.kota', $where_delete, $arr_id_kota);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data kota\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/basic/kota');
		}		
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/basic/kota', 'cetak');
			
			/**************************** BEGIN HEAD ****************************/

			$mainCols = array();

			$arrCol = array();
			$arrCol['title'] = 'NO.';
			$arrCol['width'] = 10;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'PROPINSI';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'KOTA';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'KETERANGAN';
			$arrCol['width'] = 150;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

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

			$this->report->SetReportMainTitle('LAPORAN KOTA');
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
						$sql_plus = 'lower(a.nama) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 2 :
						$sql_plus = 'lower(b.nama) LIKE ?';
						$params[] = "%{$keyword}%";					
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql =	"
					SELECT
					a.id_kota,
					b.nama AS propinsi,
					a.nama AS kota,
					a.keterangan
					FROM
					trans.kota a
					INNER JOIN trans.propinsi b ON a.id_propinsi = b.id_propinsi
					WHERE
					{$sql_plus}
					ORDER BY
					b.nama,
					a.nama
					";			
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['propinsi'];				
				$arrData[] = $row['kota'];				
				$arrData[] = $row['keterangan'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}					
						
	}

/* End of file kota.php */
/* Location: ./system/application/controllers/basic/kota.php */