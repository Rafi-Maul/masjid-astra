<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class LainLain extends MyController {
		const TIPE 		= 4;
		const SELF_URL	= 'lainLain';
	
		public function __construct() {
			log_message('DEBUG', 'basic::LainLain Class Initialized');
			parent::__construct();
		}
			
		public function index() {
			$this->password->getUrlAccess();			
			
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$filter  =& $this->getInitVar('filter', 1);
			$keyword =& $this->getInitVar('keyword');						
			
			// Default where...
			$sql_plus 	= 'id_klasifikasi_penerima = ?';
			$params   	= array(self::TIPE);			

			// Filter checking...
			if (!empty($keyword)) {
				$keyword = strtolower($keyword);
				switch ($filter) {
					case 1 :
						$sql_plus .= ' AND lower(nama) LIKE ?';
						$params[]  = "%{$keyword}%";
						break;
					default :
						// Nothing...
				}
			}
			
			$sql =	"
					SELECT
					*
					FROM
					trans.pihak_penerima
					WHERE
					{$sql_plus}
					ORDER BY
					nama
					";			
				   			
			try {
				$arr_penerima =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 		= array();
			$data['page']	 		= $page;
			$data['filter']	 		= $filter;
			$data['keyword'] 		= $keyword;	
			$data['arr_penerima']	= $arr_penerima;
			$data['tipe']			= self::SELF_URL;
			$this->load->viewPage('basic/list_penerima', $data);		
		}	
		
		public function add() {
			$this->password->getUrlAccess('/basic/lainLain', 'tambah');				
						
			$data		  	= array();
			$data['title']	= 'Tambah Vendor';
			$data['tipe']	= self::SELF_URL;
			$this->load->viewPage('basic/list_penerima_add', $data);
		}			
		
		public function addAct() {
			$this->password->getUrlAccess('/basic/lainLain', 'tambah');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();
				
				$nama 		= $this->getVar('nama', TRUE);
				$alamat		= $this->getVar('alamat', FALSE);
				$no_hp		= $this->getVar('no_hp', FALSE);
				$keterangan	= $this->getVar('keterangan', FALSE);
				$nama_rek	= $this->getVar('nama_rek', FALSE);
				$no_rek		= $this->getVar('no_rek', FALSE);
				$nama_bank	= $this->getVar('nama_bank', FALSE);
				
				$alamat		= (empty($alamat) ? NULL : $alamat);
				$no_hp		= (empty($no_hp) ? NULL : $no_hp);
				$keterangan	= (empty($keterangan) ? NULL : $keterangan);
				$nama_rek	= (empty($nama_rek) ? NULL : $nama_rek);
				$no_rek		= (empty($no_rek) ? NULL : $no_rek);
				$nama_bank	= (empty($nama_bank) ? NULL : $nama_bank);
				
				$insert								= array();
				$insert['id_dd_users']				= $id_dd_users;
				$insert['id_klasifikasi_penerima']	= self::TIPE;
				$insert['nama'] 					= $nama;
				$insert['alamat']					= $alamat;
				$insert['no_hp']					= $no_hp;
				$insert['keterangan']				= $keterangan;
				$insert['nama_rek']					= $nama_rek;
				$insert['no_rek']					= $no_rek;
				$insert['nama_bank']				= $nama_bank;
				$this->db->insert("trans.pihak_penerima", $insert);
									
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data vendor\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}	

		public function edit($id_pihak_penerima, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/basic/lainLain', 'edit');
			
			$sql =	"
					SELECT
					*
					FROM
					trans.pihak_penerima
					WHERE
					id_pihak_penerima = ?
					";

			$penerima = $this->db->getRow($sql, array($id_pihak_penerima));
									
			$data		   		= array();
			$data['title'] 		= 'Edit Vendor';
			$data['penerima'] 	= $penerima;
			$data['tipe']		= self::SELF_URL;
			$data['page']		= $page;
			$data['filter']		= $filter;
			$data['keyword']	= $keyword;
			$this->load->viewPage('basic/list_penerima_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/basic/lainLain', 'edit');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();

				$id_pihak_penerima	= $this->getVar('id_pihak_penerima', TRUE);
				$nama				= $this->getVar('nama', TRUE);
				$alamat				= $this->getVar('alamat', FALSE);
				$no_hp				= $this->getVar('no_hp', FALSE);
				$keterangan			= $this->getVar('keterangan', FALSE);
				$nama_rek			= $this->getVar('nama_rek', FALSE);
				$no_rek				= $this->getVar('no_rek', FALSE);
				$nama_bank			= $this->getVar('nama_bank', FALSE);
				$page				= $this->getVar('page', TRUE);
				$filter				= $this->getVar('filter', TRUE);
				$keyword			= $this->getVar('keyword', TRUE);												
				
				$alamat				= (empty($alamat) ? NULL : $alamat);
				$no_hp				= (empty($no_hp) ? NULL : $no_hp);
				$keterangan			= (empty($keterangan) ? NULL : $keterangan);
				$nama_rek			= (empty($nama_rek) ? NULL : $nama_rek);
				$no_rek				= (empty($no_rek) ? NULL : $no_rek);
				$nama_bank			= (empty($nama_bank) ? NULL : $nama_bank);				

				$update					= array();
				$update['id_dd_users']	= $id_dd_users;
				$update['nama'] 		= $nama;
				$update['alamat']		= $alamat;
				$update['no_hp']		= $no_hp;
				$update['keterangan']	= $keterangan;
				$update['nama_rek']		= $nama_rek;
				$update['no_rek']		= $no_rek;
				$update['nama_bank']	= $nama_bank;
				$this->db->update("trans.pihak_penerima", $update, 'id_pihak_penerima = ?', array($id_pihak_penerima));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);												
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data vendor\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}		
		
		public function del() {
			$this->password->getUrlAccess('/basic/lainLain', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_pihak_penerima = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_pihak_penerima));
				$where_delete = 'id_pihak_penerima IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete("trans.pihak_penerima", $where_delete, $arr_id_pihak_penerima);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data vendor\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/basic/lainLain');
		}		
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/basic/lainLain', 'cetak');
			
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
			$arrCol['title'] = 'NAMA';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'ALAMAT';
			$arrCol['width'] = 100;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);

			$arrCol = array();
			$arrCol['title'] = 'NO. HP';
			$arrCol['width'] = 30;
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
			
			$arrCol = array();
			$arrCol['title'] = 'NAMA REKENING';
			$arrCol['width'] = 150;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'NOMOR REKENING';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'L';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'BANK';
			$arrCol['width'] = 30;
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

			$this->report->SetReportMainTitle('LAPORAN VENDOR');
			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->Open();
			$this->report->AddPage();

			/**************************** BEGIN CONTENT ****************************/

			// Default where...
			$sql_plus 	= 'id_klasifikasi_penerima = ?';
			$params   	= array(self::TIPE);			

			// Filter checking...
			if (!empty($keyword)) {
				$keyword = strtolower($keyword);
				switch ($filter) {
					case 1 :
						$sql_plus .= ' AND lower(nama) LIKE ?';
						$params[]  = "%{$keyword}%";
						break;
					default :
						// Nothing...
				}
			}
			
			$sql =	"
					SELECT
					*
					FROM
					trans.pihak_penerima
					WHERE
					{$sql_plus}
					ORDER BY
					nama
					";			
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = $row['nama'];				
				$arrData[] = $row['alamat'];				
				$arrData[] = $row['no_hp'];				
				$arrData[] = $row['keterangan'];
				$arrData[] = $row['nama_rek'];
				$arrData[] = $row['no_rek'];
				$arrData[] = $row['nama_bank'];
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}					
						
	}

/* End of file lainLain.php */
/* Location: ./system/application/controllers/basic/lainLain.php */
