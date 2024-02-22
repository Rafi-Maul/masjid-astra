<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Muhsinin extends MyController {
		const TIPE 		= 1;
		const SELF_URL	= 'muhsinin';
	
		public function __construct() {
			log_message('DEBUG', 'basic::Muhsinin Class Initialized');
			parent::__construct();
		}
			
		public function index() {
			$this->password->getUrlAccess();			
			
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$filter  =& $this->getInitVar('filter', 1);
			$keyword =& $this->getInitVar('keyword');						
			
			// Default where...
			$sql_plus 	= 'id_klasifikasi = ?';
			$params   	= array(self::TIPE);			
			// print_r($params);exit;
			// $params   	= 1;			

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
					trans{$this->mosques_id}.muhsinin
					WHERE
					{$sql_plus}
					ORDER BY
					nama
					";			
				   			
			try {
				$arr_muhsinin =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			// print_r($sql);exit;
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 		= array();
			$data['page']	 		= $page;
			$data['filter']	 		= $filter;
			$data['keyword'] 		= $keyword;	
			$data['arr_muhsinin']	= $arr_muhsinin;
			$data['tipe']			= self::SELF_URL;
			$this->load->viewPage('basic/muhsinin', $data);		
		}	
		
		public function add() {
			$this->password->getUrlAccess('/basic/muhsinin', 'tambah');				
						
			$data		  	= array();
			$data['title']	= 'Tambah Muhsinin';
			$data['tipe']	= self::SELF_URL;
			$this->load->viewPage('basic/muhsinin_add', $data);
		}			
		
		public function addAct() {
			$this->password->getUrlAccess('/basic/muhsinin', 'tambah');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();
				
				$nama 		= $this->getVar('nama', TRUE);
				$alamat		= $this->getVar('alamat', FALSE);
				$no_hp		= $this->getVar('no_hp', FALSE);
				$email		= $this->getVar('email', FALSE);
				$perusahaan	= $this->getVar('perusahaan', FALSE);
				$keterangan	= $this->getVar('keterangan', FALSE);
				
				$alamat		= (empty($alamat) ? NULL : $alamat);
				$no_hp		= (empty($no_hp) ? NULL : $no_hp);
				$keterangan	= (empty($keterangan) ? NULL : $keterangan);
				
				$insert								= array();
				$insert['id_dd_users']				= $id_dd_users;
				// $insert['id_klasifikasi_penerima']	= self::TIPE;
				$insert['id_klasifikasi']	= 1;
				$insert['nama'] 					= $nama;
				$insert['alamat']					= $alamat;
				$insert['no_hp']					= $no_hp;
				$insert['email']					= $email;
				$insert['perusahaan']				= $perusahaan;
				$insert['keterangan']				= $keterangan;
				$this->db->insert("trans{$this->mosques_id}.muhsinin", $insert);
									
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data muhsinin\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}	

		public function edit($id_muhsinin, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/basic/muhsinin', 'edit');
			
			$sql =	"
					SELECT
					*
					FROM
					trans{$this->mosques_id}.muhsinin
					WHERE
					id_muhsinin = ?
					";

			$muhsinin = $this->db->getRow($sql, array($id_muhsinin));
									
			$data		   		= array();
			$data['title'] 		= 'Edit Muhsinin';
			$data['muhsinin'] 	= $muhsinin;
			$data['tipe']		= self::SELF_URL;
			$data['page']		= $page;
			$data['filter']		= $filter;
			$data['keyword']	= $keyword;
			$this->load->viewPage('basic/muhsinin_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/basic/muhsinin', 'edit');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
			
			try {
				$this->db->beginTrans();

				$id_muhsinin	= $this->getVar('id_muhsinin', TRUE);
				$nama				= $this->getVar('nama', TRUE);
				$alamat				= $this->getVar('alamat', FALSE);
				$no_hp				= $this->getVar('no_hp', FALSE);
				$email				= $this->getVar('email', FALSE);
				$perusahaan			= $this->getVar('perusahaan', FALSE);
				$keterangan			= $this->getVar('keterangan', FALSE);
				$page				= $this->getVar('page', TRUE);
				$filter				= $this->getVar('filter', TRUE);
				$keyword			= $this->getVar('keyword', TRUE);												
				
				$alamat				= (empty($alamat) ? NULL : $alamat);
				$no_hp				= (empty($no_hp) ? NULL : $no_hp);
				$keterangan			= (empty($keterangan) ? NULL : $keterangan);				

				$update					= array();
				$update['id_dd_users']	= $id_dd_users;
				$update['nama'] 		= $nama;
				$update['alamat']		= $alamat;
				$update['no_hp']		= $no_hp;
				$update['email']		= $email;
				$update['perusahaan']	= $perusahaan;
				$update['keterangan']	= $keterangan;
				$this->db->update("trans{$this->mosques_id}.muhsinin", $update, 'id_muhsinin = ?', array($id_muhsinin));

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);												
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data muhsinin\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}		
		
		public function del() {
			$this->password->getUrlAccess('/basic/muhsinin', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_muhsinin = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_muhsinin));
				$where_delete = 'id_muhsinin IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete("trans{$this->mosques_id}.muhsinin", $where_delete, $arr_id_muhsinin);
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data muhsinin\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/basic/muhsinin');
		}		
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/basic/muhsinin', 'cetak');
			
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
			
			/**************************** END HEAD ****************************/
			
			$params = array();
			$params['arrHead'] = $mainCols;
			$params['orientation'] = 'P';
			$params['format'] = 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');

			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(25);

			$this->report->SetReportMainTitle('LAPORAN USTADZ');
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
					trans{$this->mosques_id}.pihak_penerima
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
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}					
						
	}

/* End of file muhsinin.php */
/* Location: ./system/application/controllers/basic/muhsinin.php */
