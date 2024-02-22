<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Bank extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'basic::Bank Class Initialized');
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
					a.id_bank,
					b.nama AS kota,
					a.nama,
					a.keterangan
					FROM
					trans.bank a
					INNER JOIN trans.kota b ON a.id_kota = b.id_kota
					WHERE
					{$sql_plus}
					ORDER BY
					b.nama,
					a.nama
					";			
				   			
			try {
				$arr_bank =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 	= array();
			$data['page']	 	= $page;
			$data['filter']	 	= $filter;
			$data['keyword'] 	= $keyword;	
			$data['arr_bank']	= $arr_bank;
			$this->load->viewPage('basic/list_bank', $data);		
		}	
		
		public function add() {
			$this->password->getUrlAccess('/basic/bank', 'tambah');
			
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
			$this->load->viewPage('basic/list_bank_add', $data);
		}			
		
		public function addAct() {
			$this->password->getUrlAccess('/basic/bank', 'tambah');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();
				
				$id_kota	= $this->getVar('id_kota', TRUE);
				$nama 		= $this->getVar('nama', TRUE);
				$keterangan	= $this->getVar('keterangan', FALSE);
				
				$insert					= array();
				$insert['id_kota']		= $id_kota;
				$insert['id_dd_users']	= $id_dd_users;
				$insert['nama'] 		= $nama;
				$insert['keterangan']	= $keterangan;
				$this->db->insert('trans.bank', $insert);
									
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data bank\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}	

		public function edit($id_bank, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/basic/bank', 'edit');
			
			$sql =	"
					SELECT
					*
					FROM
					trans.bank
					WHERE
					id_bank = ?
					";
			$bank = $this->db->getRow($sql, array($id_bank));
			
			$sql =	"
					SELECT
					a.*
					FROM
					trans.kota a
					INNER JOIN trans.propinsi b ON a.id_propinsi = b.id_propinsi
					WHERE
					b.id_propinsi = (
						SELECT
						id_propinsi
						FROM
						trans.kota
						WHERE
						id_kota = ?
					)
					";

			$arr_kota = $this->db->getRows($sql, array($bank['id_kota']));
			
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
			$data['title'] 			= 'Edit Bank';
			$data['bank']			= $bank;
			$data['arr_kota'] 		= $arr_kota;
			$data['arr_propinsi']	= $arr_propinsi;
			$data['page']			= $page;
			$data['filter']			= $filter;
			$data['keyword']		= $keyword;
			$this->load->viewPage('basic/list_bank_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/basic/bank', 'edit');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();

				$id_kota 		= $this->getVar('id_kota', TRUE);
				$id_bank 		= $this->getVar('id_bank', TRUE);
				$nama			= $this->getVar('nama', TRUE);
				$keterangan		= $this->getVar('keterangan', FALSE);
				$page		 	= $this->getVar('page', TRUE);
				$filter		 	= $this->getVar('filter', TRUE);
				$keyword	 	= $this->getVar('keyword', TRUE);												

				$update					= array();
				$update['id_kota']		= $id_kota;
				$update['id_dd_users']	= $id_dd_users;
				$update['nama'] 		= $nama;
				$update['keterangan']	= $keterangan;
				$this->db->update('trans.bank', $update, 'id_bank = ?', array($id_bank));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);												
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data bank\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}		
		
		public function del() {
			$this->password->getUrlAccess('/basic/bank', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_bank = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_bank));
				$where_delete = 'id_bank IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('trans.bank', $where_delete, $arr_id_bank);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data bank\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/basic/bank');
		}		
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/basic/bank', 'cetak');
			
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
			$arrCol['title'] = 'BANK';
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

			$this->report->SetReportMainTitle('LAPORAN BANK');
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
					a.id_bank,
					b.nama AS kota,
					a.nama,
					a.keterangan
					FROM
					trans.bank a
					INNER JOIN trans.kota b ON a.id_kota = b.id_kota
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
				$arrData[] = $row['nama'];				
				$arrData[] = $row['kota'];				
				$arrData[] = $row['keterangan'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}					
						
	}

/* End of file bank.php */
/* Location: ./system/application/controllers/basic/bank.php */