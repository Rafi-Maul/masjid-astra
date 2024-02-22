<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class RekeningBank extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'basic::RekeningBank Class Initialized');
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
						$sql_plus = 'lower(b.no_rekening) LIKE ?';
						$params[] = "%{$keyword}%";					
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql =	"
					SELECT
					b.*,
					a.nama
					FROM
					trans.bank a
					INNER JOIN trans.rekening_bank b ON a.id_bank = b.id_bank
					WHERE
					{$sql_plus}
					ORDER BY
					a.nama,
					b.no_rekening
					";			
				   			
			try {
				$arr_rekening =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 		= array();
			$data['page']	 		= $page;
			$data['filter']	 		= $filter;
			$data['keyword'] 		= $keyword;	
			$data['arr_rekening']	= $arr_rekening;
			$this->load->viewPage('basic/list_rekening', $data);							
		}		
		
		public function add() {
			$this->password->getUrlAccess('/basic/rekeningBank', 'tambah');
			
			$sql = "
				   SELECT
				   id_bank,
				   nama
				   FROM
				   trans.bank
				   ORDER BY
				   nama
				   ";
				   
			$arr_bank =& $this->db->getRows($sql);			
									
			$data		   		= array();
			$data['title']		= 'Tambah Rekening Bank';
			$data['arr_bank'] 	= $arr_bank;
			$this->load->viewPage('basic/list_rekening_add', $data);
		}	
		
		public function addAct() {
			$this->password->getUrlAccess('/basic/rekeningBank', 'tambah');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();
				
				$id_bank		= $this->getVar('id_bank', TRUE);
				$no_rekening	= $this->getVar('no_rekening', TRUE);
				$keterangan		= $this->getVar('keterangan', FALSE);
								
				$keterangan 	= (empty($keterangan) ? NULL : $keterangan);
				
				$insert					= array();
				$insert['id_bank']		= $id_bank;
				$insert['id_dd_users']	= $id_dd_users;
				$insert['no_rekening']	= $no_rekening;
				$insert['keterangan']	= $keterangan;
				$this->db->insert('trans.rekening_bank', $insert);
									
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data rekening bank\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function edit($id_rekening_bank, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/basic/rekeningBank', 'edit');
			
			$sql =	"
					SELECT
					id_bank,
					nama
					FROM
					trans.bank
					ORDER BY
					nama
					";
			$arr_bank =& $this->db->getRows($sql);
						
			$sql =	"
					SELECT
					*					
					FROM
					trans.rekening_bank
					WHERE
					id_rekening_bank = ?
					";					
			$rekening = $this->db->getRow($sql, array($id_rekening_bank));
						
			$data		   			= array();
			$data['title'] 			= 'Edit Rekening Bank';
			$data['arr_bank']		= $arr_bank;
			$data['rekening'] 		= $rekening;
			$data['page']			= $page;
			$data['filter']			= $filter;
			$data['keyword']		= $keyword;
			$this->load->viewPage('basic/list_rekening_edit', $data);
		}	
		
		public function editAct() {
			$this->password->getUrlAccess('/basic/rekeningBank', 'edit');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();

				$id_bank 			= $this->getVar('id_bank', TRUE);
				$id_rekening_bank 	= $this->getVar('id_rekening_bank', TRUE);				
				$no_rekening		= $this->getVar('no_rekening', TRUE);
				$keterangan			= $this->getVar('keterangan', FALSE);
				$page		 		= $this->getVar('page', TRUE);
				$filter		 		= $this->getVar('filter', TRUE);
				$keyword	 		= $this->getVar('keyword', TRUE);		
				
				$keterangan			= (empty($keterangan) ? NULL : $keterangan);

				$update					= array();
				$update['id_bank']		= $id_bank;
				$update['id_dd_users']	= $id_dd_users;
				$update['no_rekening']	= $no_rekening;
				$update['keterangan']	= $keterangan;
				$this->db->update('trans.rekening_bank', $update, 'id_rekening_bank = ?', array($id_rekening_bank));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);												
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data rekening bank\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/basic/rekeningBank', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_rekening_bank = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_rekening_bank));
				$where_delete = 'id_rekening_bank IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('trans.rekening_bank', $where_delete, $arr_id_rekening_bank);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data rekening bank\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/basic/rekeningBank');
		}	
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/basic/rekeningBank', 'cetak');
			
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
			$arrCol['title'] = 'NO. REKENING';
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

			$this->report->SetReportMainTitle('LAPORAN REKENING BANK');
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
						$sql_plus = 'lower(b.no_rekening) LIKE ?';
						$params[] = "%{$keyword}%";					
						break;
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql =	"
					SELECT
					b.*,
					a.nama
					FROM
					trans.bank a
					INNER JOIN trans.rekening_bank b ON a.id_bank = b.id_bank
					WHERE
					{$sql_plus}
					ORDER BY
					a.nama,
					b.no_rekening
					";			
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['nama'];				
				$arrData[] = $row['no_rekening'];				
				$arrData[] = $row['keterangan'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}										
													
	}

/* End of file rekeningBank.php */
/* Location: ./system/application/controllers/basic/rekeningBank.php */
