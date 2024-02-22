<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class TransaksiPengeluaran extends MyController {
		
		public function __construct() {
			log_message('DEBUG', 'akun::transaksiPengeluaran Class Initialized');
			parent::__construct();
		}		
		
		public function index() {
			$this->password->getUrlAccess();
			
			$this->load->helper(array('date', 'number'));
				
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$filter  =& $this->getInitVar('filter', 1);
			$keyword =& $this->getInitVar('keyword');
				
			// Default where...
			$sql_plus = '1=1';
			$params   = array();
		
			// Filter checking...
			if (!empty($keyword)) {
				switch ($filter) {
					case 1 :
						$sql_plus = 'a.no_bukti ILIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
							
			$sql =	"
					SELECT
					a.id_transaksi,
					h.id_akmt_jurnal,
					h.flag_temp,
					a.tanggal,
					a.no_bukti,					
					SUM((CASE WHEN c.flag_debet_kredit = 1 THEN 1 ELSE 0 END) * b.nominal) AS nominal,
					(j.nama::TEXT || ' ('::TEXT || k.klasifikasi::TEXT || ')'::TEXT) AS penerima,
					a.keterangan
					FROM
					trans.transaksi a
					INNER JOIN trans.sub_transaksi b ON a.id_transaksi = b.id_transaksi
					INNER JOIN trans.mapping_kode_akun c ON b.id_mapping_kode_akun = c.id_mapping_kode_akun
					INNER JOIN trans.jenis_transaksi d ON c.id_jenis_transaksi = d.id_jenis_transaksi
					INNER JOIN trans.sub_kode_kas e ON d.id_sub_kode_kas = e.id_sub_kode_kas
					INNER JOIN trans.kode_kas f ON e.id_kode_kas = f.id_kode_kas
					INNER JOIN trans.mapping_transaksi_jurnal g ON a.id_transaksi = g.id_transaksi
					INNER JOIN akun.akmt_jurnal h ON g.id_akmt_jurnal = h.id_akmt_jurnal
					LEFT JOIN trans.mapping_penerima i ON a.id_transaksi = i.id_transaksi
					LEFT JOIN trans.pihak_penerima j ON i.id_pihak_penerima = j.id_pihak_penerima
					LEFT JOIN trans.klasifikasi_penerima k ON j.id_klasifikasi_penerima = k.id_klasifikasi_penerima
					WHERE
					f.flag_in_out = 'o'
					AND
					{$sql_plus}
					GROUP BY
					a.id_transaksi,
					h.id_akmt_jurnal,
					h.flag_temp,
					a.tanggal,
					a.no_bukti,
					j.nama,
					k.klasifikasi,
					a.keterangan
					ORDER BY
					h.flag_temp,
					a.tanggal
					";
		
			try {
				$arr_transaksi =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				$this->session->set_flashdata('s4b_error', "Tidak dapat menampilkan sesuai yang anda inginkan.");
				redirect('/akun/transaksiPengeluaran');
				return;
			}
						
			$this->setHidden('filter', $filter);
			$this->setHidden('keyword', $keyword);
				
			$data 			 		= array();
			$data['page']	 		= $page;
			$data['filter']	 		= $filter;
			$data['keyword'] 		= $keyword;
			$data['arr_transaksi'] 	= $arr_transaksi;
			$this->load->viewPage('akun/list_transaksi_pengeluaran', $data);
		}		
		
		public function add() {
			$this->password->getUrlAccess('/akun/transaksiPengeluaran', 'tambah');
			
			$this->load->helper(array('date', 'number'));
			
			$sql =	"
					SELECT
					id_kode_kas,
					(kode::TEXT || '. '::TEXT || kas::TEXT) AS kas
					FROM
					trans.kode_kas
					WHERE
					flag_in_out = 'o'
					ORDER BY
					kode,
					kas
					";
			$arr_kas =& $this->db->getRows($sql);
			
			$data		       	= array();
			$data['title'] 	   	= 'Transaksi Pengeluaran';
			$data['arr_kas']	= $arr_kas;
			$this->load->viewPage('akun/list_transaksi_pengeluaran_add', $data);
		}
		
		public function addAct() {
			$this->password->getUrlAccess('/akun/transaksiPengeluaran', 'tambah');
			
			$this->load->helper('number');
			
			$id_dd_users = $this->session->userdata('id_dd_users');
				
			try {
				$this->db->beginTrans();
		
				$tanggal			= $this->getVar('tanggal', TRUE);
				$id_jenis_transaksi	= $this->getVar('id_jenis_transaksi', TRUE);
				$id_pihak_penerima	= $this->getVar('id_pihak_penerima', TRUE);
				$nominal			= $this->getVar('nominal', TRUE);				
				$petugas			= $this->getVar('petugas', TRUE);
				
				$pajak				=& $this->getInitVar('pajak', 0);
				if (numValue($pajak) > 0)
					$pajak_nominal	= numValue($pajak) / (100 - numValue($pajak)) * numValue($nominal);
				else
					$pajak_nominal	= 0;				
				$keterangan			=& $this->getInitVar('keterangan', '');

				$keterangan			= (empty($keterangan) ? NULL : $keterangan);
				
				// Periksa apakah sistem sudah melakukan tutup buku untuk periode tersebut...
				$month = substr($tanggal, 5, 2);
				$year  = substr($tanggal, 0, 4);
				
				$posted = $this->db->getField('posted',
											  'SELECT COUNT(*) AS posted FROM akun.akmt_periode WHERE bulan = ? AND tahun = ? AND flag_temp = 2',
											  array($month, $year));
				
				if ($posted == 1)
					throw new Exception('Transaksi untuk periode tersebut sudah tutup buku');				
				
				$sql = 	"
						SELECT
						b.id_mapping_kode_akun AS id_mapping_debet,
						b.id_akdd_detail_coa AS id_coa_debet,
						c.id_mapping_kode_akun AS id_mapping_kredit,
						c.id_akdd_detail_coa AS id_coa_kredit,
						d.id_mapping_kode_akun AS id_mapping_pajak,
						d.id_akdd_detail_coa AS id_coa_pajak,
						d.flag_debet_kredit AS posisi_pajak
						FROM
						trans.jenis_transaksi a
						INNER JOIN trans.mapping_kode_akun b ON a.id_jenis_transaksi = b.id_jenis_transaksi AND b.flag_pajak = 1 AND b.flag_debet_kredit = 1
						INNER JOIN trans.mapping_kode_akun c ON a.id_jenis_transaksi = c.id_jenis_transaksi AND c.flag_pajak = 1 AND c.flag_debet_kredit = 2
						LEFT JOIN trans.mapping_kode_akun d ON a.id_jenis_transaksi = d.id_jenis_transaksi AND d.flag_pajak = 2
						WHERE
						a.id_jenis_transaksi = ?
						";
				$mapping = $this->db->getRow($sql, array($id_jenis_transaksi));
				
				if (!is_numeric($mapping['id_mapping_pajak']) || empty($mapping['posisi_pajak'])) {
					// Tidak memiliki mapping untuk pajak.
					$pajak 			= 0;
					$pajak_nominal 	= 0;
				}								
				
				$kode_jurnal = $this->db->getField('kode', 'SELECT kode FROM akun.akdd_kodifikasi_jurnal WHERE id_akdd_kodifikasi_jurnal = 2');
				
				$tahun = substr($tanggal, 0, 4);
				$bulan = substr($tanggal, 5, 2);
				$no_bukti = intval($this->db->getField('no_bukti', "SELECT SUBSTRING(no_bukti from 9 for 8) AS no_bukti FROM akun.akmt_jurnal WHERE SUBSTRING(no_bukti from 1 for 2) = ? AND DATE_PART('MONTH', tanggal) = ? AND DATE_PART('YEAR', tanggal) = ? ORDER BY no_bukti DESC, tanggal DESC OFFSET 0 LIMIT 1", array($kode_jurnal, intval($bulan), $tahun)));	//$no_bukti++;			
				$no_bukti = $kode_jurnal . $tahun . str_pad($bulan, 2, '0', STR_PAD_LEFT) . str_pad(++$no_bukti, 8, '0', STR_PAD_LEFT);
				//echo $no_bukti;exit;
				// Memasukan ke sistem transaksi...
				$insert					= array();
				$insert['id_dd_users']	= $id_dd_users;
				$insert['tanggal']		= $tanggal;
				$insert['no_bukti']		= $no_bukti;
				$insert['pajak']		= numValue($pajak);
				$insert['petugas']		= $petugas;
				$insert['keterangan']	= $keterangan;
				$this->db->insert('trans.transaksi', $insert);
				
				$id_transaksi = $this->db->getLastID('trans.transaksi_id_transaksi_seq');
				
				// Memasukan ke sistem jurnal...
				$insert							= array();
				$insert['flag_jurnal']			= 1;
				$insert['flag_temp']			= 1;
				$insert['flag_posting']			= 0;
				$insert['no_bukti']				= $no_bukti;
				$insert['tanggal']				= $tanggal;
				$insert['keterangan']			= $keterangan;
				$this->db->insert('akun.akmt_jurnal', $insert);
				
				$id_akmt_jurnal = $this->db->getLastID('akun.akmt_jurnal_id_akmt_jurnal_seq');
				
				// Memasukan ke tabel penghubung...
				$insert							= array();
				$insert['id_transaksi']			= $id_transaksi;
				$insert['id_akmt_jurnal']		= $id_akmt_jurnal;
				$insert['id_dd_users']			= $id_dd_users;
				$this->db->insert('trans.mapping_transaksi_jurnal', $insert);
								
				$nominal_debet 	= 100 / (100 - numValue($pajak)) * numValue($nominal);
				$nominal_kredit	= 100 / (100 - numValue($pajak)) * numValue($nominal);
				
				if (is_numeric($mapping['id_mapping_pajak']) && !empty($mapping['posisi_pajak'])) {					
					// Dengan pajak...					
					$insert							= array();
					$insert['id_transaksi']			= $id_transaksi;
					$insert['id_mapping_kode_akun']	= $mapping['id_mapping_pajak'];
					$insert['id_dd_users']			= $id_dd_users;
					$insert['nominal']				= $pajak_nominal;
					$this->db->insert('trans.sub_transaksi', $insert);
					
					$insert							= array();
					$insert['id_akmt_jurnal']		= $id_akmt_jurnal;
					$insert['id_akdd_detail_coa']	= $mapping['id_coa_pajak'];
					$insert['flag_position']		= ($mapping['posisi_pajak'] == 1 ? 'd' : 'k');
					$insert['jumlah']				= $pajak_nominal;
					$this->db->insert('akun.akmt_jurnal_det', $insert);
					
					if ($mapping['posisi_pajak'] == 1) {
						// Pajak berada di debet...
						$nominal_debet 	-= $pajak_nominal;
					} else {
						// Pajak berada di kredit...
						$nominal_kredit	-= $pajak_nominal;
					}
				} 
				
				// Masukan sisi debet...				
				$insert							= array();
				$insert['id_transaksi']			= $id_transaksi;
				$insert['id_mapping_kode_akun']	= $mapping['id_mapping_debet'];
				$insert['id_dd_users']			= $id_dd_users;
				$insert['nominal']				= $nominal_debet;
				$this->db->insert('trans.sub_transaksi', $insert);
				
				$insert							= array();
				$insert['id_akmt_jurnal']		= $id_akmt_jurnal;
				$insert['id_akdd_detail_coa']	= $mapping['id_coa_debet'];
				$insert['flag_position']		= 'd';
				$insert['jumlah']				= $nominal_debet;
				$this->db->insert('akun.akmt_jurnal_det', $insert);				
				
				// Masukan sisi kredit...
				$insert							= array();
				$insert['id_transaksi']			= $id_transaksi;
				$insert['id_mapping_kode_akun']	= $mapping['id_mapping_kredit'];
				$insert['id_dd_users']			= $id_dd_users;
				$insert['nominal']				= $nominal_kredit;
				$this->db->insert('trans.sub_transaksi', $insert);

				$insert							= array();
				$insert['id_akmt_jurnal']		= $id_akmt_jurnal;
				$insert['id_akdd_detail_coa']	= $mapping['id_coa_kredit'];
				$insert['flag_position']		= 'k';
				$insert['jumlah']				= $nominal_kredit;
				$this->db->insert('akun.akmt_jurnal_det', $insert);
				
				// Masukan ke sisi penerima...
				$insert							= array();
				$insert['id_transaksi']			= $id_transaksi;
				$insert['id_pihak_penerima']	= $id_pihak_penerima;
				$insert['id_dd_users']			= $id_dd_users;
				$this->db->insert('trans.mapping_penerima', $insert);				
												
				$this->db->endTrans();				
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menyimpan data transaksi penerimaan\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
		}
		
		public function edit($id_transaksi, $page, $filter, $keyword = '') {
		    $this->password->getUrlAccess('/akun/transaksiPengeluaran', 'edit');
		    
		    $this->load->helper(array('date', 'number'));
		    		    		    
		    $sql =  "
		            SELECT
		            a.id_transaksi,
		            h.id_akmt_jurnal,
		            j.id_mapping_penerima,
		            a.tanggal,
		            a.no_bukti,
					a.pajak,
		            k.id_pihak_penerima,
		            l.id_klasifikasi_penerima,
		            a.petugas,
		            a.keterangan,
		            f.id_kode_kas,
		            e.id_sub_kode_kas,
		            d.id_jenis_transaksi,
		            (SUM(CASE WHEN c.flag_debet_kredit = 1 THEN b.nominal ELSE 0 END) * (100 - a.pajak) / 100) AS nominal,
		            SUM(CASE WHEN c.flag_pajak = 2 THEN b.nominal ELSE 0 END) AS pajak_nominal,
		            SUM(CASE WHEN ((c.flag_pajak = 1) AND (c.flag_debet_kredit = 1)) THEN b.id_sub_transaksi ELSE 0 END) AS id_sub_transaksi_debet,
		            SUM(CASE WHEN ((c.flag_pajak = 1) AND (c.flag_debet_kredit = 2)) THEN b.id_sub_transaksi ELSE 0 END) AS id_sub_transaksi_kredit,
		            SUM(CASE WHEN c.flag_pajak = 2 THEN b.id_sub_transaksi ELSE 0 END) AS id_sub_transaksi_pajak,
		            SUM(CASE WHEN ((c.flag_pajak = 1) AND (c.flag_debet_kredit = 1)) THEN i.id_akmt_jurnal_det ELSE 0 END) AS id_jurnal_debet,
		            SUM(CASE WHEN ((c.flag_pajak = 1) AND (c.flag_debet_kredit = 2)) THEN i.id_akmt_jurnal_det ELSE 0 END) AS id_jurnal_kredit,
		            SUM(CASE WHEN c.flag_pajak = 2 THEN i.id_akmt_jurnal_det ELSE 0 END) AS id_jurnal_pajak
		            FROM
		            trans.transaksi a
		            INNER JOIN trans.sub_transaksi b ON a.id_transaksi = b.id_transaksi
		            INNER JOIN trans.mapping_kode_akun c ON b.id_mapping_kode_akun = c.id_mapping_kode_akun
		            INNER JOIN trans.jenis_transaksi d ON c.id_jenis_transaksi = d.id_jenis_transaksi
		            INNER JOIN trans.sub_kode_kas e ON d.id_sub_kode_kas = e.id_sub_kode_kas
		            INNER JOIN trans.kode_kas f ON e.id_kode_kas = f.id_kode_kas
		            INNER JOIN trans.mapping_transaksi_jurnal g ON a.id_transaksi = g.id_transaksi
		            INNER JOIN akun.akmt_jurnal h ON g.id_akmt_jurnal = h.id_akmt_jurnal
		            INNER JOIN akun.akmt_jurnal_det i ON h.id_akmt_jurnal = i.id_akmt_jurnal AND c.id_akdd_detail_coa = i.id_akdd_detail_coa
		            LEFT JOIN trans.mapping_penerima j ON a.id_transaksi = j.id_transaksi
		            LEFT JOIN trans.pihak_penerima k ON j.id_pihak_penerima = k.id_pihak_penerima
		            LEFT JOIN trans.mapping_transaksi_penerima l ON d.id_jenis_transaksi = l.id_jenis_transaksi
		            WHERE
		            a.id_transaksi = ?
		            GROUP BY
		            a.id_transaksi,
		            h.id_akmt_jurnal,
		            j.id_mapping_penerima,	     
                    a.tanggal,
                    a.no_bukti,
					a.pajak,
                    k.id_pihak_penerima,
		            l.id_klasifikasi_penerima,                    
                    a.petugas,
                    a.keterangan,
                    f.id_kode_kas,
                    e.id_sub_kode_kas,
                    d.id_jenis_transaksi                    
		            ";
		    $transaksi = $this->db->getRow($sql, array($id_transaksi));
			
			$sql =	"
					SELECT
					id_kode_kas,
					(kode::TEXT || '. '::TEXT || kas::TEXT) AS kas
					FROM
					trans.kode_kas
					WHERE
					flag_in_out = 'o'
					ORDER BY
					kode,
					kas
					";
			$arr_kas =& $this->db->getRows($sql);		    
			
			$sql =  "
			        SELECT
			        id_sub_kode_kas,
			        (kode::TEXT || '. '::TEXT || sub_kas::TEXT) AS sub_kas
			        FROM
			        trans.sub_kode_kas
			        WHERE
			        id_kode_kas = ?
			        ORDER BY
			        kode,
			        sub_kas
			        ";
			$arr_sub_kas =& $this->db->getRows($sql, array($transaksi['id_kode_kas']));
			
			$sql =  "
			        SELECT
			        id_jenis_transaksi,
			        transaksi
			        FROM
			        trans.jenis_transaksi
			        WHERE
			        id_sub_kode_kas = ?
			        ORDER BY
			        transaksi
			        ";
			$arr_jenis =& $this->db->getRows($sql, array($transaksi['id_sub_kode_kas']));
			
			$sql =	"
					SELECT
					a.id_pihak_penerima,
					(a.nama::TEXT || ' ('::TEXT || b.klasifikasi::TEXT || ')'::TEXT) AS nama
					FROM
					trans.pihak_penerima a
					INNER JOIN trans.klasifikasi_penerima b ON a.id_klasifikasi_penerima = b.id_klasifikasi_penerima
					WHERE
					b.id_klasifikasi_penerima = ?
					ORDER BY
					a.nama
					";
			$arr_penerima =& $this->db->getRows($sql, array($transaksi['id_klasifikasi_penerima']));

			$data		   		    = array();
			$data['title'] 		    = 'Transaksi Penerimaan';
			$data['transaksi']      = $transaksi;
			$data['arr_kas']        = $arr_kas;
			$data['arr_sub_kas']    = $arr_sub_kas;
			$data['arr_jenis']      = $arr_jenis;
			$data['arr_penerima']	= $arr_penerima;
			$data['page']		    = $page;
			$data['filter']		    = $filter;
			$data['keyword']	    = $keyword;
			$this->load->viewPage('akun/list_transaksi_pengeluaran_edit', $data);		    
		}
		
		public function editAct() {
			$this->password->getUrlAccess('/akun/transaksiPengeluaran', 'edit');
			
			$this->load->helper('number');
				
			$id_dd_users = $this->session->userdata('id_dd_users');
				
			try {
				$this->db->beginTrans();
				
				$id_transaksi	            = $this->getVar('id_transaksi', TRUE);
				$id_akmt_jurnal				= $this->getVar('id_akmt_jurnal', TRUE);
				$id_mapping_penerima		= $this->getVar('id_mapping_penerima', TRUE);
				$id_sub_transaksi_debet     = $this->getVar('id_sub_transaksi_debet', TRUE);
				$id_sub_transaksi_kredit    = $this->getVar('id_sub_transaksi_kredit', TRUE);
				$id_sub_transaksi_pajak     = $this->getVar('id_sub_transaksi_pajak', TRUE);
				$id_jurnal_debet     		= $this->getVar('id_jurnal_debet', TRUE);
				$id_jurnal_kredit    		= $this->getVar('id_jurnal_kredit', TRUE);
				$id_jurnal_pajak     		= $this->getVar('id_jurnal_pajak', TRUE);				
				$tanggal                    = $this->getVar('tanggal', TRUE);
				$id_jenis_transaksi         = $this->getVar('id_jenis_transaksi', TRUE);
				$id_pihak_penerima			= $this->getVar('id_pihak_penerima', TRUE);
				$petugas                    = $this->getVar('petugas', TRUE);
				$nominal                    = $this->getVar('nominal', TRUE);
				
				$pajak                      =& $this->getInitVar('pajak', 0);
				if (numValue($pajak) > 0)
					$pajak_nominal	= numValue($pajak) / (100 - numValue($pajak)) * numValue($nominal);
				else
					$pajak_nominal	= 0;				
				$keterangan                 =& $this->getInitVar('keterangan', '');
				
				$keterangan                 = (empty($keterangan) ? NULL : $keterangan);
				
				$page                       = $this->getVar('page', TRUE);
				$filter                     = $this->getVar('filter', TRUE);
				$keyword                    = $this->getVar('keyword', TRUE);
				
				// Periksa apakah sistem sudah melakukan tutup buku untuk periode tersebut...
				$month = substr($tanggal, 5, 2);
				$year  = substr($tanggal, 0, 4);
				
				$posted = $this->db->getField('posted',
						'SELECT COUNT(*) AS posted FROM akun.akmt_periode WHERE bulan = ? AND tahun = ? AND flag_temp = 2',
						array($month, $year));
				
				if ($posted == 1)
					throw new Exception('Transaksi untuk periode tersebut sudah tutup buku');				
				
				$sql = 	"
						SELECT
						b.id_mapping_kode_akun AS id_mapping_debet,
						b.id_akdd_detail_coa AS id_coa_debet,
						c.id_mapping_kode_akun AS id_mapping_kredit,
						c.id_akdd_detail_coa AS id_coa_kredit,
						d.id_mapping_kode_akun AS id_mapping_pajak,
						d.id_akdd_detail_coa AS id_coa_pajak,
						d.flag_debet_kredit AS posisi_pajak
						FROM
						trans.jenis_transaksi a
						INNER JOIN trans.mapping_kode_akun b ON a.id_jenis_transaksi = b.id_jenis_transaksi AND b.flag_pajak = 1 AND b.flag_debet_kredit = 1
						INNER JOIN trans.mapping_kode_akun c ON a.id_jenis_transaksi = c.id_jenis_transaksi AND c.flag_pajak = 1 AND c.flag_debet_kredit = 2
						LEFT JOIN trans.mapping_kode_akun d ON a.id_jenis_transaksi = d.id_jenis_transaksi AND d.flag_pajak = 2
						WHERE
						a.id_jenis_transaksi = ?
						";
				$mapping = $this->db->getRow($sql, array($id_jenis_transaksi));				
				
				if (!is_numeric($mapping['id_mapping_pajak']) || empty($mapping['posisi_pajak'])) {
					// Tidak memiliki mapping untuk pajak.
					$pajak 			= 0;
					$pajak_nominal 	= 0;
				}								

				$update                 = array();
				$update['id_dd_users']  = $id_dd_users;
				$update['tanggal']      = $tanggal;
				$update['pajak']		= numValue($pajak);
				$update['petugas']      = $petugas;
				$update['keterangan']   = $keterangan;
				$this->db->update('trans.transaksi', $update, 'id_transaksi = ?', array($id_transaksi));
				
				$update					= array();
				$update['tanggal']		= $tanggal;
				$update['keterangan']	= $keterangan;
				$this->db->update('akun.akmt_jurnal', $update, 'id_akmt_jurnal = ?', array($id_akmt_jurnal));
				
				$nominal_debet 	= 100 / (100 - numValue($pajak)) * numValue($nominal);
				$nominal_kredit	= 100 / (100 - numValue($pajak)) * numValue($nominal);
				
				if (is_numeric($mapping['id_mapping_pajak']) && !empty($mapping['posisi_pajak'])) {					
					// Dengan pajak...										
					$update                         = array();
					$update['id_mapping_kode_akun'] = $mapping['id_mapping_pajak'];
					$update['id_dd_users']          = $id_dd_users;
					$update['nominal']              = $pajak_nominal;
					$this->db->update('trans.sub_transaksi', $update, 'id_sub_transaksi = ?', array($id_sub_transaksi_pajak));										
					
					if ($this->db->getAffected() == 0) {
					    $insert							= array();
					    $insert['id_transaksi']			= $id_transaksi;
					    $insert['id_mapping_kode_akun']	= $mapping['id_mapping_pajak'];
					    $insert['id_dd_users']			= $id_dd_users;
					    $insert['nominal']				= $pajak_nominal;
					    $this->db->insert('trans.sub_transaksi', $insert);					
					}
					
					$update							= array();
					$update['id_akdd_detail_coa']	= $mapping['id_coa_pajak'];
					$update['flag_position']		= ($mapping['posisi_pajak'] == 1 ? 'd' : 'k');
					$update['jumlah']				= $pajak_nominal;
					$this->db->update('akun.akmt_jurnal_det', $update, 'id_akmt_jurnal_det = ?', array($id_jurnal_pajak));
					
					if ($this->db->getAffected() == 0) {
						$insert							= array();
						$insert['id_akmt_jurnal']		= $id_akmt_jurnal;
						$insert['id_akdd_detail_coa']	= $mapping['id_coa_pajak'];
						$insert['flag_position']		= ($mapping['posisi_pajak'] == 1 ? 'd' : 'k');
						$insert['jumlah']				= $pajak_nominal;
						$this->db->insert('akun.akmt_jurnal_det', $insert);
					}
					
					if ($mapping['posisi_pajak'] == 1) {
						// Pajak berada di debet...
						$nominal_debet 	-= $pajak_nominal;
					} else {
						// Pajak berada di kredit...
						$nominal_kredit	-= $pajak_nominal;
					}
				} else
				    $this->db->delete('trans.sub_transaksi', 'id_sub_transaksi = ?', array($id_sub_transaksi_pajak)); 				
				
				// Update sisi debet...
				$update                         = array();
				$update['id_mapping_kode_akun'] = $mapping['id_mapping_debet'];
				$update['id_dd_users']          = $id_dd_users;
				$update['nominal']              = $nominal_debet;
				$this->db->update('trans.sub_transaksi', $update, 'id_sub_transaksi = ?', array($id_sub_transaksi_debet));
				
				$update							= array();
				$update['id_akdd_detail_coa']	= $mapping['id_coa_debet'];
				$update['flag_position']		= 'd';
				$update['jumlah']				= $nominal_debet;
				$this->db->update('akun.akmt_jurnal_det', $update, 'id_akmt_jurnal_det = ?', array($id_jurnal_debet));
				
				// Update sisi kredit...
				$update                         = array();
				$update['id_mapping_kode_akun'] = $mapping['id_mapping_kredit'];
				$update['id_dd_users']          = $id_dd_users;
				$update['nominal']              = $nominal_kredit;
				$this->db->update('trans.sub_transaksi', $update, 'id_sub_transaksi = ?', array($id_sub_transaksi_kredit));
				
				$update							= array();
				$update['id_akdd_detail_coa']	= $mapping['id_coa_kredit'];
				$update['flag_position']		= 'k';
				$update['jumlah']				= $nominal_kredit;
				$this->db->update('akun.akmt_jurnal_det', $update, 'id_akmt_jurnal_det = ?', array($id_jurnal_kredit));
				
				// Merubah atau memasukan pihak penerima...	
				if (is_numeric($id_mapping_penerima)) {
					$update							= array();
					$update['id_pihak_penerima']	= $id_pihak_penerima;
					$update['id_dd_users']			= $id_dd_users;
					$this->db->update('trans.mapping_penerima', $update, 'id_mapping_penerima = ?', array($id_mapping_penerima));
				} else {
					$insert 						= array();
					$insert['id_transaksi'] 		= $id_transaksi;
					$insert['id_pihak_penerima']	= $id_pihak_penerima;
					$insert['id_dd_users']			= $id_dd_users;
					$this->db->insert('trans.mapping_penerima', $insert);
				}					
															
				$this->db->endTrans();
		
				$this->session->set_flashdata('page', $page);
				$this->session->set_flashdata('filter', $filter);
				$this->session->set_flashdata('keyword', $keyword);
			} catch (Exception $e) {
				$this->db->endTrans(false);
				echo "Tidak dapat menyimpan data transaksi pengeluaran\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
        }
        
		public function del() {
			$this->password->getUrlAccess('/akun/transaksiPengeluaran', 'hapus');
				
			try {
				$this->db->beginTrans();
		
				$arr_id_transaksi = $this->getVar('id_list', TRUE);
		
				$where_delete = str_repeat('?,', count($arr_id_transaksi));
				$where_delete = 'id_transaksi IN (' . substr($where_delete, 0, -1) . ')';
				
				$this->db->delete('akun.akmt_jurnal_det', "id_akmt_jurnal IN (SELECT id_akmt_jurnal FROM trans.mapping_transaksi_jurnal WHERE {$where_delete})", $arr_id_transaksi);
				$this->db->resetSequence('akun.akmt_jurnal_det', 'id_akmt_jurnal_det', 'akun.akmt_jurnal_det_id_akmt_jurnal_det_seq');
				
				$this->db->delete('akun.akmt_jurnal', "id_akmt_jurnal IN (SELECT id_akmt_jurnal FROM trans.mapping_transaksi_jurnal WHERE {$where_delete})", $arr_id_transaksi);
				$this->db->resetSequence('akun.akmt_jurnal', 'id_akmt_jurnal', 'akun.akmt_jurnal_id_akmt_jurnal_seq');
				
				$this->db->resetSequence('trans.mapping_transaksi_jurnal', 'id_mapping_transaksi_jurnal', 'trans.mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq');
		
				$this->db->delete('trans.sub_transaksi', $where_delete, $arr_id_transaksi);				
				$this->db->resetSequence('trans.sub_transaksi', 'id_sub_transaksi', 'trans.sub_transaksi_id_sub_transaksi_seq');
				
				$this->db->delete('trans.transaksi', $where_delete, $arr_id_transaksi);
				$this->db->resetSequence('trans.transaksi', 'id_transaksi', 'trans.transaksi_id_transaksi_seq');
				
				$this->db->resetSequence('trans.mapping_penerima', 'id_mapping_penerima', 'trans.mapping_penerima_id_mapping_penerima_seq');				
		
				$this->db->endTrans();
			} catch (Exception $e) {
				$this->db->endTrans(false);
				$this->session->set_flashdata('s4b_error', "Tidak dapat menghapus data transaksi pengeluaran\n\nPenjelasan Teknis:\n{$e->getMessage()}");
			}
				
			redirect('akun/transaksiPengeluaran');
		}		       
		
		public function report($filter = 1, $keyword = '') {
			$this->password->getUrlAccess('/akun/transaksiPengeluaran', 'cetak');
				
			/**************************** BEGIN HEAD ****************************/
		
			$mainCols 			= array();
		
			$arrCol 			= array();
			$arrCol['title'] 	= 'NO.';
			$arrCol['width'] 	= 10;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'R';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;
		
			array_push($mainCols, $arrCol);
						
			$arrCol 			= array();
			$arrCol['title'] 	= 'TANGGAL';
			$arrCol['width'] 	= 50;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'C';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;
			
			array_push($mainCols, $arrCol);
			
			$arrCol 			= array();
			$arrCol['title'] 	= 'NO. BUKTI';
			$arrCol['width'] 	= 50;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'C';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;
				
			array_push($mainCols, $arrCol);
				
			$arrCol 			= array();
			$arrCol['title'] 	= 'NOMINAL';
			$arrCol['width'] 	= 50;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'R';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;
		
			array_push($mainCols, $arrCol);
		
			$arrCol 			= array();
			$arrCol['title'] 	= 'KETERANGAN';
			$arrCol['width'] 	= 100;
			$arrCol['align'] 	= 'C';
			$arrCol['calign'] 	= 'L';
			$arrCol['span'] 	= 2;
			$arrCol['sub'] 		= null;
		
			array_push($mainCols, $arrCol);
				
			/**************************** END HEAD ****************************/
				
			$params = array();
			$params['arrHead'] = $mainCols;
			$params['orientation'] = 'P';
			$params['format'] = 'A4';
		
			$this->load->library('Report', $params);
			$this->load->helper(array('date', 'number'));
		
			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(25);
		
			$this->report->SetReportMainTitle('LAPORAN JURNAL PENGELUARAN');
			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->Open();
			$this->report->AddPage();
		
			/**************************** BEGIN CONTENT ****************************/
		
			// Default where...
			$sql_plus = '1=1';
			$params   = array();
		
			// Filter checking...
			if (!empty($keyword)) {
				switch ($filter) {
					case 1 :
						$sql_plus = 'a.no_bukti ILIKE ?';
						$params[] = "%{$keyword}%";
						break;
					default :
						$sql_plus = '1=1';
				}
			}
							
			$sql =	"
					SELECT
					a.id_transaksi,
					a.tanggal,
					a.no_bukti,					
					SUM((CASE WHEN c.flag_debet_kredit = 1 THEN 1 ELSE 0 END) * b.nominal) AS nominal,
					a.keterangan
					FROM
					trans.transaksi a
					INNER JOIN trans.sub_transaksi b ON a.id_transaksi = b.id_transaksi
					INNER JOIN trans.mapping_kode_akun c ON b.id_mapping_kode_akun = c.id_mapping_kode_akun
					INNER JOIN trans.jenis_transaksi d ON c.id_jenis_transaksi = d.id_jenis_transaksi
					INNER JOIN trans.sub_kode_kas e ON d.id_sub_kode_kas = e.id_sub_kode_kas
					INNER JOIN trans.kode_kas f ON e.id_kode_kas = f.id_kode_kas
					WHERE
					f.flag_in_out = 'o'
					AND
					{$sql_plus}
					GROUP BY
					a.id_transaksi,
					a.tanggal,
					a.no_bukti,
					a.keterangan
					";
											
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);
	
			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();
		
				$arrData[] = $i++ . '.';
				$arrData[] = getLocalDate($row['tanggal']);
				$arrData[] = $row['no_bukti'];
				$arrData[] = numFormat($row['nominal']);
				$arrData[] = $row['keterangan'];
				$this->report->InsertRow($arrData);
			}
		
			/**************************** END CONTENT ****************************/
	
			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}
		 		
	}
	
/* End of file transaksiPengeluaran.php */
/* Location: ./system/application/controllers/akun/transaksiPengeluaran.php */	
