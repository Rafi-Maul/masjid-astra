<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Coa extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'akun::Coa Class Initialized');
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
						$sql_plus = 'lower(a.uraian) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 2 :
						$sql_plus = 'coa_number LIKE ?';
						$params[] = "%{$keyword}%";
						break;						
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
					SELECT
					a.*,
					b.id_akdd_detail_coa AS flag_used
					FROM
					akun.akdd_detail_coa_v a
					LEFT JOIN akun.akdd_detail_coa_jurnal_v b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
					WHERE
					{$sql_plus}
					ORDER BY
					a.coa_number
				   ";
				   			
			try {
				$arr_coa =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				$this->session->set_flashdata('s4b_error', "Tidak dapat menampilkan sesuai yang anda inginkan.");
				redirect('/akun/coa');
				return;
			}		
			
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
			
			$data 			 = array();
			$data['page']	 = $page;
			$data['filter']	 = $filter;
			$data['keyword'] = $keyword;	
			$data['arr_coa'] = $arr_coa;
			$this->load->viewPage('akun/list_coa', $data);		
		}
		
		public function add() {
			$this->password->getUrlAccess('/akun/coa', 'tambah');
			
			$sql = "
				   SELECT
				   id_akdd_main_coa,
				   uraian
				   FROM
				   akun.akdd_main_coa
				   ORDER BY
				   binary_code
				   ";
			$arr_main =& $this->db->getRows($sql);
			
			$sql = "
			       SELECT
				   id_akdd_level_coa,
			       level_number,
				   level_length
			       FROM
			       akun.akdd_level_coa
			       ORDER BY
			       level_number
			       ";
			$arr_level =& $this->db->getRows($sql);
			
			$sql = "
			       SELECT
			       id_akdd_klasifikasi_modal,
			       klasifikasi
			       FROM
			       akun.akdd_klasifikasi_modal
			       ORDER BY
			       binary_code
			       ";
			$arr_modal =& $this->db->getRows($sql);
			
			$data		       = array();
			$data['title'] 	   = 'Tambah COA';
			$data['arr_main']  = $arr_main;
			$data['arr_level'] = $arr_level;
			$data['arr_modal'] = $arr_modal;
			$this->load->viewPage('akun/list_coa_add', $data);
		}
		
		public function addAct() {
			$this->password->getUrlAccess('/akun/coa', 'tambah');
			
			try {
				$this->db->beginTrans();
				
				$id_akdd_main_coa 		   = $this->getVar('id_akdd_main_coa', TRUE);
				$level_number 			   = $this->getVar('id_akdd_level_coa', TRUE);				
				$id_akdd_detail_coa_ref    = $this->getVar('id_akdd_detail_coa_ref', FALSE);
				$coa_number				   = $this->getVar('coa_number', TRUE);
				$uraian					   = $this->getVar('uraian', TRUE);
				$id_akdd_klasifikasi_modal = $this->getVar('id_akdd_klasifikasi_modal', FALSE);
				$sub_coa 				   = $this->getVar('sub_coa', FALSE);
				$max_level				   = $this->getVar('max_level', TRUE);
				$total_length			   = $this->getVar('total_length', TRUE);
				$level_length			   = $this->getVar('level_length', TRUE);
				$id_akdd_level_coa2		   = $this->getVar('id_akdd_level_coa2', TRUE);
				$flag_mapping			   = $this->getVar('flag_mapping', ($level_number == $max_level));
				
				if (($level_number > 1) && (empty($id_akdd_detail_coa_ref)))
					throw new Exception('Anda belum memilih kode akun induk.');
					
				if (($id_akdd_main_coa == $this->getIDModal()) && (empty($id_akdd_klasifikasi_modal)) && ($level_number == $max_level))
					throw new Exception('Anda belum memilih klasifikasi Aktiva Bersih.');
			
				$id_akdd_level_coa = $id_akdd_level_coa2;

				if (intval($coa_number) == 0)
					throw new Exception('Nilai kode akun tidak boleh nol.');
				
				// Harus bisa dioptimalkan lagi.
				if (($level_number > 1) && (!empty($id_akdd_detail_coa_ref))) {
					$up_length = $this->db->getField('up_length', 'SELECT SUM(level_length) AS up_length FROM akun.akdd_level_coa WHERE level_number < ?', array($level_number));
					$coa_parent = $this->db->getField('coa_number', 'SELECT coa_number FROM akun.akdd_detail_coa WHERE id_akdd_detail_coa = ?', array($id_akdd_detail_coa_ref));
					$coa_number = str_pad(substr($coa_parent, 0, $up_length) . str_pad(trim($coa_number), $level_length, '0', STR_PAD_LEFT), $total_length, '0', STR_PAD_RIGHT);
				} else {
					$coa_number = str_pad(trim($coa_number), $total_length, '0', STR_PAD_RIGHT);		
				}				
													
				$insert					          = array();
				$insert['id_akdd_main_coa']	      = $id_akdd_main_coa;				
				$insert['id_akdd_level_coa']	  = $id_akdd_level_coa;
				if (!empty($id_akdd_detail_coa_ref))
					$insert['id_akdd_detail_coa_ref'] = $id_akdd_detail_coa_ref;
				else
					$insert['id_akdd_detail_coa_ref'] = 02021977;
				$insert['coa_number']             = $coa_number;
				$insert['coa_number_num']		  = intval($coa_number);
				$insert['uraian']                 = $uraian;
				$this->db->insert('akun.akdd_detail_coa', $insert);
				
				$id_akdd_detail_coa = $this->db->getLastID('akun.akdd_detail_coa_id_akdd_detail_coa_seq');				
				
				if (empty($id_akdd_detail_coa_ref)) {					
					$update 						  = array();
					$update['id_akdd_detail_coa_ref'] = $id_akdd_detail_coa;
					$this->db->update('akun.akdd_detail_coa', $update, 'id_akdd_detail_coa = ?', array($id_akdd_detail_coa));
				}						
						
				if ($level_number == $max_level) {
					switch ($id_akdd_klasifikasi_modal) {
						case 1 :
						case 2 :
						case 3 :
						case 4 :
						case 5 :
						case 6 :
						case 7 :
						case 8 :
							$sub_coa = str_replace("\n", '', trim($sub_coa));
							$id_akdd_detail_coa_lr = $this->db->getField('id_akdd_detail_coa_lr', 'SELECT id_akdd_detail_coa_lr FROM akun.akdd_detail_coa_lr WHERE id_akdd_klasifikasi_modal = ?', array($id_akdd_klasifikasi_modal));
							if ($id_akdd_detail_coa_lr) {
								$update 					  = array();
								$update['id_akdd_detail_coa'] = $id_akdd_detail_coa;
								$update['sub_coa'] 			  = $sub_coa;
								$this->db->update('akun.akdd_detail_coa_lr', $update, 'id_akdd_detail_coa_lr = ?', array($id_akdd_detail_coa_lr));
							} else {
								$insert 							 = array();
								$insert['id_akdd_detail_coa'] 		 = $id_akdd_detail_coa;
								$insert['id_akdd_klasifikasi_modal'] = $id_akdd_klasifikasi_modal;
								$insert['sub_coa']					 = $sub_coa;
								$this->db->insert('akun.akdd_detail_coa_lr', $insert);
							}
							break;
						default :
							// Do nothing...				
					}
					
					// Bayu 2010-10-18 22:25
					$insert = array();
					$insert['id_akdd_detail_coa']	 = $id_akdd_detail_coa;
					$insert['flag']					 = intval($flag_mapping);
					$this->db->insert('akun.akdd_detail_coa_map', $insert);
				}
				
				// Mereset...
				$this->db->exec('
								UPDATE 
								akun.akmt_periode 
								SET
								flag_temp = 0
								WHERE
								flag_temp = 1
								');
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menambah data kode akun\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function edit($id_akdd_detail_coa, $page, $filter, $keyword = '') {
			$this->password->getUrlAccess('/akun/coa', 'edit');
			
			$sql = "
				   SELECT
				   a.*,
				   b.uraian AS uraian_klasifikasi,
				   c.level_number,
				   c.level_length,
				   (d.coa_number || '-' || d.uraian) AS coa_induk,
				   e.id_akdd_klasifikasi_modal,
				   e.sub_coa,
				   f.flag AS flag_mapping
				   FROM
				   akun.akdd_detail_coa a
				   INNER JOIN akun.akdd_main_coa b ON a.id_akdd_main_coa = b.id_akdd_main_coa
				   INNER JOIN akun.akdd_level_coa c ON a.id_akdd_level_coa = c.id_akdd_level_coa
				   INNER JOIN akun.akdd_detail_coa d ON a.id_akdd_detail_coa_ref = d.id_akdd_detail_coa
				   LEFT JOIN akun.akdd_detail_coa_lr e ON a.id_akdd_detail_coa = e.id_akdd_detail_coa
				   LEFT JOIN akun.akdd_detail_coa_map f ON a.id_akdd_detail_coa = f.id_akdd_detail_coa
				   WHERE
				   a.id_akdd_detail_coa = ?				   
				   ";
			$coa = $this->db->getRow($sql, array($id_akdd_detail_coa));
			
			$offset = $this->db->getField('offset_number', 'SELECT SUM(level_length) AS offset_number FROM akun.akdd_level_coa WHERE level_number < ?', array($coa['level_number']));
			$total_length = strlen($coa['coa_number']);
			
			$level_detail = $this->db->getField('level_detail', 'SELECT max(level_number) AS level_detail FROM akun.akdd_level_coa');
				   			
			$sql = "
			       SELECT
			       id_akdd_klasifikasi_modal,
			       klasifikasi
			       FROM
			       akun.akdd_klasifikasi_modal
			       ORDER BY
			       id_akdd_klasifikasi_modal
			       ";
			$arr_modal =& $this->db->getRows($sql);
			
			$data		       	  = array();
			$data['title'] 	   	  = 'Edit COA';
			$data['offset']	   	  = $offset;
			$data['total_length'] = $total_length;
			$data['level_detail'] = $level_detail;
			$data['coa']	   	  = $coa;
			$data['arr_modal'] 	  = $arr_modal;
			$data['page']	 	  = $page;
			$data['filter']	 	  = $filter;
			$data['keyword'] 	  = $keyword;												
			$this->load->viewPage('akun/list_coa_edit', $data);
		}		
		
		public function editAct() {
			$this->password->getUrlAccess('/akun/coa', 'edit');
			
			try {
				$this->db->beginTrans();

                $id_akdd_detail_coa 	   		= $this->getVar('id_akdd_detail_coa', TRUE);
				$id_akdd_klasifikasi_modal 		= $this->getVar('id_akdd_klasifikasi_modal', FALSE);
				$sub_coa						= $this->getVar('sub_coa', FALSE);
				$coa_number	   			   		= $this->getVar('coa_number', TRUE);
				$uraian 		   		   		= $this->getVar('uraian', TRUE);
				$level_number 		   	   		= $this->getVar('level_number', TRUE);
				$id_akdd_detail_coa_ref	   		= $this->getVar('id_akdd_detail_coa_ref', TRUE);
				$offset					   		= $this->getVar('offset', TRUE);
				$coa_parent				   		= $this->getVar('coa_parent', TRUE);
				$level_length			   		= $this->getVar('level_length', TRUE);
				$total_length			   		= $this->getVar('total_length', TRUE);
				$id_akdd_klasifikasi_modal_prev = $this->getVar('id_akdd_klasifikasi_modal_prev', TRUE);
				$page		  					= $this->getVar('page', TRUE);
				$filter		  					= $this->getVar('filter', TRUE);
				$keyword	  					= $this->getVar('keyword', TRUE);
				
				$level_detail = $this->db->getField('level_detail', 'SELECT max(level_number) AS level_detail FROM akun.akdd_level_coa');
				
				$flag_mapping	  				= $this->getVar('flag_mapping', ($level_number == $level_detail));
				
				if ($id_akdd_klasifikasi_modal != $id_akdd_klasifikasi_modal_prev) {
					// Rubah klasifikasi modal.
					throw new Exception('Fitur ini belum tersedia !');
				}
				
				// Harus bisa dioptimalkan lagi.
				if (($level_number > 1) && (!empty($id_akdd_detail_coa_ref))) {
					$coa_number = str_pad(substr($coa_parent, 0, $offset) . str_pad(trim($coa_number), $level_length, '0', STR_PAD_LEFT), $total_length, '0', STR_PAD_RIGHT);
				} else {
					$coa_number = str_pad(trim($coa_number), $total_length, '0', STR_PAD_RIGHT);		
				}				
				

				$update				  = array();
				//$update['coa_number'] = $coa_number;
				$update['uraian'] 	  = $uraian;
				$this->db->update('akun.akdd_detail_coa', $update, 'id_akdd_detail_coa = ?', array($id_akdd_detail_coa));

				
				if ($level_number == $level_detail) {
					// Bayu 2010-10-18 22:44
					$update = array();
					$update['flag'] = intval($flag_mapping);
					$this->db->update('akun.akdd_detail_coa_map', $update, 'id_akdd_detail_coa = ?', array($id_akdd_detail_coa));
				}

				$this->db->endTrans();
				
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);				
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat memperbaharui data coa\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function del() {
			$this->password->getUrlAccess('/akun/coa', 'hapus');
			
			try {
				$this->db->beginTrans();
				
				$arr_id_akdd_detail_coa = $this->getVar('id_list', TRUE);
				
				$where_delete = str_repeat('?,', count($arr_id_akdd_detail_coa));
				$where_delete = 'id_akdd_detail_coa IN (' . substr($where_delete, 0, -1) . ')';
								
				$this->db->delete('akun.akdd_detail_coa_map', $where_delete, $arr_id_akdd_detail_coa);

				$this->db->resetSequence('akun.akdd_detail_coa_map', 'id_akdd_detail_coa_map', 'akun.akdd_detail_coa_map_id_akdd_detail_coa_map_seq');	

				$this->db->delete('akun.akdd_detail_coa_lr', $where_delete, $arr_id_akdd_detail_coa);

				$this->db->resetSequence('akun.akdd_detail_coa_lr', 'id_akdd_detail_coa_lr', 'akun.akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq');				
				
				$this->db->delete('akun.akdd_detail_coa', $where_delete, $arr_id_akdd_detail_coa);		

				$this->db->resetSequence('akun.akdd_detail_coa', 'id_akdd_detail_coa', 'akun.akdd_detail_coa_id_akdd_detail_coa_seq');	

				// Mereset...
				$this->db->exec('
								UPDATE 
								akun.akmt_periode 
								SET
								flag_temp = 0
								WHERE
								flag_temp = 1
								');				
				
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data coa\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
			
			redirect('/akun/coa');
		}				
										
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/akun/coa', 'cetak');
		
			define('DEFAULT_LN', 5);
			define('INDENT_LN', 5);
			define('FONT_SIZE', 8);
			define('MARGIN_DEF', 0);
			define('NOMINAL_WD', 0);

			$params = array();
			$params['orientation'] = 'L';
			$params['format'] = 'A4';

			$this->load->library('Report', $params);
			$this->load->helper('date');

			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(25);

			$currentWidth = $this->report->GetWidth();

			$this->report->SetReportMainTitle('DAFTAR AKUN');
			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));

			$this->report->Open();
			$this->report->AddPage();
			$this->report->SetFontSize(FONT_SIZE);
			$this->report->Ln(DEFAULT_LN);
			$this->report->SetY(30);

			$leftWidth = $currentWidth - MARGIN_DEF - NOMINAL_WD;

			$this->report->SetFillColor(230, 230, 230);
			$this->report->Cell(10, DEFAULT_LN + 3, "NO.", 'LTB', 0, 'C', 1);
			$this->report->Cell(75, DEFAULT_LN + 3, "KLASIFIKASI", 'LTB', 0, 'C', 1);
			$this->report->Cell(10, DEFAULT_LN + 3, "LEVEL", 'LTB', 0, 'C', 1);
			$this->report->Cell(30, DEFAULT_LN + 3, "KODE PERKIRAAN", 'LTBR', 0, 'C', 1);
			$this->report->Cell(150, DEFAULT_LN + 3, "U R A I A N", 'LRTB', 1, 'C', 1);

			// Default where...
			$sql_plus = '1=1';
			$params   = array();			

			// Filter checking...
			if (!empty($keyword)) {
				$keyword = strtolower($keyword);
				switch ($filter) {
					case 1 :
						$sql_plus = 'lower(a.uraian) LIKE ?';
						$params[] = "%{$keyword}%";
						break;
					case 2 :
						$sql_plus = 'coa_number LIKE ?';
						$params[] = "%{$keyword}%";
						break;						
					default :
						$sql_plus = '1=1';
				}
			}
			
			$sql = "
					SELECT
					a.*,
					b.id_akdd_detail_coa AS flag_used
					FROM
					akun.akdd_detail_coa_v a
					LEFT JOIN akun.akdd_detail_coa_jurnal_v b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
					WHERE
					{$sql_plus}
					ORDER BY
					a.coa_number
				   ";
				
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i=1;	
			$prev_group="";
			foreach ($rows as $row) {	
				
				$x = $this->report->GetX();
				$this->report->Cell(275, DEFAULT_LN, "", 'TBR', 0, 'C');
				$this->report->SetX($x);

				$this->report->cell(10,DEFAULT_LN,$i++ .".",'LB',0,'R');		
				if ($prev_group != $row['uraian_main_coa']) {
					$this->report->cell(75,DEFAULT_LN,$row['uraian_main_coa'],'LB',0,'L');	
					$prev_group = $row['uraian_main_coa'];
				}
				else
					$this->report->cell(75,DEFAULT_LN,"",'LB',0,'L');				

				$this->report->cell(10,DEFAULT_LN,$row['level_number'],'LB',0,'C');
				$this->report->cell(30,DEFAULT_LN,$row['coa_number'],'LBR',0,'C');
				$this->report->SetX( $this->report->GetX() + ($row['level_number'] * 3) );
				$this->report->cell(150,DEFAULT_LN,$row['uraian'],0,1,'L');

			}

			$this->report->SetFillColor(230, 230, 230);
			$this->report->Cell(275, DEFAULT_LN, "", 'LTBR', 0, 'C', 1);

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		
		}
		
		/**
		 * Untuk mencari akun induk.
		 */
		public function getInduk() {
			$id_akdd_main_coa = $this->getVar('id_akdd_main_coa', TRUE);
			$level_number 	  = $this->getVar('level_number', TRUE);
			
			$sql = "
				   SELECT
				   a.id_akdd_detail_coa,
				   (a.coa_number || '-' || a.uraian) AS uraian
				   FROM
				   akun.akdd_detail_coa a
				   INNER JOIN akun.akdd_level_coa b ON a.id_akdd_level_coa = b.id_akdd_level_coa
				   WHERE
				   a.id_akdd_main_coa = ?
				   AND
				   b.level_number = ?
				   ORDER BY
				   a.coa_number
				   ";
				   
			$level_number--;
				   
			$arr_coa =& $this->db->getRows($sql, array($id_akdd_main_coa, $level_number));
					
			echo json_encode($arr_coa);
		}
						
	}
	
/* End of file coa.php */
/* Location: ./system/application/controllers/akun/coa.php */	
