<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Main extends MyController {

		public function __construct() {
			log_message('DEBUG', 'Main Class Initialized');
			parent::__construct();
		}

		public function index() {
			$sql = "
				   SELECT
				   a.id_dd_moduls,
				   a.modul,
				   a.note
				   FROM
				   dd_moduls a
				   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
				   INNER JOIN dd_sub_menus c ON b.id_dd_menus = c.id_dd_menus
				   INNER JOIN dd_tabs d ON c.id_dd_sub_menus = d.id_dd_sub_menus
				   INNER JOIN dd_groups_detail e ON d.id_dd_tabs = e.id_dd_tabs
				   INNER JOIN dd_groups f ON e.id_dd_groups = f.id_dd_groups
				   INNER JOIN dd_users g ON f.id_dd_groups = g.id_dd_groups
				   WHERE
				   g.id_dd_users = ?
				   GROUP BY
				   a.id_dd_moduls,
				   a.modul,
				   a.note,
				   a.order_number
				   ORDER BY
				   a.order_number
				   ";

			$username     = $this->session->userdata('username');
			$id_dd_users  = $this->session->userdata('id_dd_users');
			$id_dd_groups = $this->session->userdata('id_dd_groups');
			$arr_modul 	  =& $this->db->getRows($sql, array($id_dd_users));

			$data              	 = array();
			$data['arr_modul'] 	 = $arr_modul;
			$data['username']  	 = $username;
			// Menentukan siapa yang bisa melakukan debug, reset, dan backup !
			$data['flag_debug']  = ($id_dd_groups == 1 ? 1 : ($id_dd_groups == 2 ? 1 : 0));
			$data['flag_reset']	 = ($id_dd_groups == 1 ? 1 : ($id_dd_groups == 2 ? 1 : 0));
			$data['flag_backup'] = ($id_dd_groups == 1 ? 1 : ($id_dd_groups == 2 ? 1 : 0));
			$this->load->viewMain($data);
		}

		public function menu($id) {
			$id_dd_users = $this->session->userdata('id_dd_users');
			$sql = "
				   SELECT
				   a.modul,
				   b.id_dd_menus,
				   b.menu,
				   b.note,
				   c.id_dd_sub_menus,
				   c.sub_menu,
				   c.note AS sub_note
				   FROM
				   dd_moduls a
				   INNER JOIN dd_menus b ON a.id_dd_moduls = b.id_dd_moduls
				   INNER JOIN dd_sub_menus c ON b.id_dd_menus = c.id_dd_menus
				   INNER JOIN dd_tabs d ON c.id_dd_sub_menus = d.id_dd_sub_menus
				   INNER JOIN dd_groups_detail e ON d.id_dd_tabs = e.id_dd_tabs
				   INNER JOIN dd_groups f ON e.id_dd_groups = f.id_dd_groups
				   INNER JOIN dd_users g ON f.id_dd_groups = g.id_dd_groups
				   WHERE
				   a.id_dd_moduls = ?
				   AND
				   g.id_dd_users = ?
				   GROUP BY
				   a.modul,
				   b.id_dd_menus,
				   b.menu,
				   b.note,
				   c.id_dd_sub_menus,
				   c.sub_menu,
				   c.note,
				   b.order_number,
				   c.order_number
				   ORDER BY
				   b.order_number,
				   c.order_number
				   ";
			$arr_menu =& $this->db->getRows($sql, array($id, $id_dd_users));

			$data             = array();
			$data['arr_menu'] = $arr_menu;
			$this->load->viewMenu($data);
		}

		public function tab($id) {
			$id_dd_users = $this->session->userdata('id_dd_users');
			$sql = "
				   SELECT
				   b.id_dd_tabs,
				   b.tab,
				   b.flag_active,
				   b.note,
				   b.url
				   FROM
				   dd_sub_menus a
				   INNER JOIN dd_tabs b ON a.id_dd_sub_menus = b.id_dd_sub_menus
				   INNER JOIN dd_groups_detail c ON b.id_dd_tabs = c.id_dd_tabs
				   INNER JOIN dd_groups d ON c.id_dd_groups = d.id_dd_groups
				   INNER JOIN dd_users e ON d.id_dd_groups = e.id_dd_groups
				   WHERE
				   a.id_dd_sub_menus = ?
				   AND
				   e.id_dd_users = ?
				   GROUP BY
				   b.id_dd_tabs,
				   b.tab,
				   b.flag_active,
				   b.note,
				   b.url,
				   b.order_number
				   ORDER BY
				   b.order_number
				   ";
			$arr_tab =& $this->db->getRows($sql, array($id, $id_dd_users));

			$data            = array();
			$data['arr_tab'] = $arr_tab;
			$this->load->viewTab($data);
		}

		public function login() {
			$this->load->library('form_validation');
			$this->load->viewLogin();
		}

		public function loginAct() {
			$this->load->library('form_validation');
			$this->form_validation->set_rules('id', 'Identitas Pengguna', 'trim|required');
			$this->form_validation->set_rules('pass', 'Kata Kunci', 'trim|required');

			if ($this->form_validation->run() == FALSE) {
				// Data kurang lengkap.
				$data 				 = array();
				$data['gagal_login'] = 'Login gagal karena data kurang lengkap';
				$this->load->viewLogin($data);
			} else {
				// Data bisa diperiksa.
				if ($this->password->loginProcess($this->input->post('id'), $this->input->post('pass'))) {
					// Berhasil login.
					redirect();
				} else {
					// Tidak berhasil login.
					$data 				 = array();
					$data['gagal_login'] = 'Login gagal, pastikan bahwa Identitas & Kata Kunci sesuai';
					$this->load->viewLogin($data);
				}
			}
		}

		public function logoutAct() {
			$this->session->sess_destroy();
			redirect();
		}

		public function backup() {
			$arrInfo =& $this->db->getDBInfo();
			if (file_exists(APPPATH . '_3rd/backup/database.backup'))
				unlink(APPPATH . '_3rd/backup/database.backup');
			$script_ext = '';
			if (strtolower(php_uname('s')) == 'linux')
				$script_ext = 'sh';
			else
				$script_ext = 'bat';
			$strCommand = APPPATH . "_3rd/backup/backup.{$script_ext} {$arrInfo['hostname']} {$arrInfo['username']} {$arrInfo['password']} {$arrInfo['database']}";
			log_message('DEBUG', 'Proses backup => ' . $strCommand);
			$output = shell_exec($strCommand);
			log_message('DEBUG', 'Hasil dari proses shell_exec backup : ' . $output);
			$this->load->viewPage('core/backup');
		}

		public function debug() {
			$this->load->helper('cookie');
			$xdebug = trim(get_cookie('XDEBUG_SESSION'));
			$this->load->viewPage('core/debug', array('xdebug' => $xdebug));
		}

		public function debugAct() {
			redirect('/core/main/debug');
		}

		public function resetAct() {
			$info = '';

			try {
				$this->db->beginTrans();

				// akun.akmt_buku_besar.
				$this->db->delete('akun.akmt_buku_besar');
				$this->db->resetSequence('akun.akmt_buku_besar', 'id_akmt_buku_besar', 'akun.akmt_buku_besar_id_akmt_buku_besar_seq');

				// akun.akmt_jurnal_det.
				$this->db->delete('akun.akmt_jurnal_det');
				$this->db->resetSequence('akun.akmt_jurnal_det', 'id_akmt_jurnal_det', 'akun.akmt_jurnal_det_id_akmt_jurnal_det_seq');

				// akun.akmt_jurnal.
				$this->db->delete('akun.akmt_jurnal');
				$this->db->resetSequence('akun.akmt_jurnal', 'id_akmt_jurnal', 'akun.akmt_jurnal_id_akmt_jurnal_seq');

				// akun.akmt_periode.
				$this->db->delete('akun.akmt_periode');
				$this->db->resetSequence('akun.akmt_periode', 'id_akmt_periode', 'akun.akmt_periode_id_akmt_periode_seq');

				// trans.sub_transaksi.
				$this->db->delete('trans.sub_transaksi');
				$this->db->resetSequence('trans.sub_transaksi', 'id_sub_transaksi', 'trans.sub_transaksi_id_sub_transaksi_seq');

				// trans.mapping_transaksi_jurnal.
				$this->db->delete('trans.mapping_transaksi_jurnal');
				$this->db->resetSequence('trans.mapping_transaksi_jurnal', 'id_mapping_transaksi_jurnal', 'trans.mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq');

				// trans.mapping_penerima.
				$this->db->delete('trans.mapping_penerima');
				$this->db->resetSequence('trans.mapping_penerima', 'id_mapping_penerima', 'trans.mapping_penerima_id_mapping_penerima_seq');

				// trans.transaksi.
				$this->db->delete('trans.transaksi');
				$this->db->resetSequence('trans.transaksi', 'id_transaksi', 'trans.transaksi_id_transaksi_seq');

				// trans.mapping_rekening.
				$this->db->delete('trans.mapping_rekening');
				$this->db->resetSequence('trans.mapping_rekening', 'id_mapping_rekening', 'trans.mapping_rekening_id_mapping_rekening_seq');

				// trans.mapping_kode_akun.
				$this->db->delete('trans.mapping_kode_akun');
				$this->db->resetSequence('trans.mapping_kode_akun', 'id_mapping_kode_akun', 'trans.mapping_kode_akun_id_mapping_kode_akun_seq');

				// trans.mapping_transaksi_penerima.
				$this->db->delete('trans.mapping_transaksi_penerima');
				$this->db->resetSequence('trans.mapping_transaksi_penerima', 'id_mapping_transaksi_penerima', 'trans.mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq');

				// trans.jenis_transaksi.
				$this->db->delete('trans.jenis_transaksi');
				$this->db->resetSequence('trans.jenis_transaksi', 'id_jenis_transaksi', 'trans.jenis_transaksi_id_jenis_transaksi_seq');

				// trans.sub_kode_kas.
				$this->db->delete('trans.sub_kode_kas');
				$this->db->resetSequence('trans.sub_kode_kas', 'id_sub_kode_kas', 'trans.sub_kode_kas_id_sub_kode_kas_seq');

				// trans.kode_kas.
				$this->db->delete('trans.kode_kas');
				$this->db->resetSequence('trans.kode_kas', 'id_kode_kas', 'trans.kode_kas_id_kode_kas_seq');

				// trans.rekening_bank.
				$this->db->delete('trans.rekening_bank');
				$this->db->resetSequence('trans.rekening_bank', 'id_rekening_bank', 'trans.rekening_bank_id_rekening_bank_seq');

				// trans.bank.
				$this->db->delete('trans.bank');
				$this->db->resetSequence('trans.bank', 'id_bank', 'trans.bank_id_bank_seq');

				// trans.kota.
				$this->db->delete('trans.kota');
				$this->db->resetSequence('trans.kota', 'id_kota', 'trans.kota_id_kota_seq');

				// trans.propinsi.
				$this->db->delete('trans.propinsi');
				$this->db->resetSequence('trans.propinsi', 'id_propinsi', 'trans.propinsi_id_propinsi_seq');

				// trans.pihak_penerima.
				$this->db->delete('trans.pihak_penerima');
				$this->db->resetSequence('trans.pihak_penerima', 'id_pihak_penerima', 'trans.pihak_penerima_id_pihak_penerima_seq');

				// trans.klasifikasi_penerima.
				$this->db->delete('trans.klasifikasi_penerima');
				$this->db->resetSequence('trans.klasifikasi_penerima', 'id_klasifikasi_penerima', 'trans.klasifikasi_penerima_id_klasifikasi_penerima_seq');

				// akun.akdd_detail_coa_map.
				$this->db->delete('akun.akdd_detail_coa_map');
				$this->db->resetSequence('akun.akdd_detail_coa_map', 'id_akdd_detail_coa_map', 'akun.akdd_detail_coa_map_id_akdd_detail_coa_map_seq');

				// akun.akdd_detail_coa_lr.
				$this->db->delete('akun.akdd_detail_coa_lr');
				$this->db->resetSequence('akun.akdd_detail_coa_lr', 'id_akdd_detail_coa_lr', 'akun.akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq');
				
				// akun.akdd_detail_coa.
				$this->db->delete('akun.akdd_detail_coa', 'id_akdd_level_coa=4');
				// $this->db->resetSequence('akun.akdd_detail_coa', 'id_klasifikasi_penerima', 'trans.klasifikasi_penerima_id_klasifikasi_penerima_seq');

				$this->db->endTrans();

				$info = 'Reset database berhasil!';
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$info = 'Reset database tidak berhasil!' . '<br/>' . $e->getMessage();
			}

			$this->load->viewPage('core/reset', array('info' => $info));
		}

	}

/* End of file main.php */
/* Location: ./system/application/controllers/core/main.php */
