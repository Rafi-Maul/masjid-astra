<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class Closing {
		private $ci;
		private $deleted;
	
		public function __construct() {
			log_message('DEBUG', 'libraries::Closing Class Initialized');
			$this->ci =& get_instance();
		}
		
		/**
		 * generate
		 *
		 * Metode ini digunakan untuk melakukan proses penyusunan dari data-data jurnal 
		 * yang akan dimasukan ke dalam alur saldo akhir akun.
		 */
		public function generate($throw_error = false) {
			log_message('DEBUG', 'Closing::generate Called');
			
			try {
			
				// BEGIN : Buat proteksi untuk proses closing agar hanya dapat dijalankan satu proses dalam waktu yang sama.
				$mem_obj = new Memcache();
				if ($mem_obj->pconnect('127.0.0.1') === FALSE)
					throw new Exception('Tidak Bisa Membuka Koneksi MemCache Server !!!');

				while ($mem_obj->add('flag_proses_closing_yayasan', 1) === FALSE) {
					// Menunggu 1/2 menit.
					sleep(30);
				}
				// BEGIN : Buat proteksi untuk proses closing agar hanya dapat dijalankan satu proses dalam waktu yang sama.
						
			
				$this->deleted = false;
			
				$starting_date = $this->ci->db->getRow('
													   SELECT
													   tahun,
													   bulan
													   FROM
													   akun.akmt_periode
													   WHERE
													   flag_temp = 2
													   ORDER BY
													   tahun DESC,
													   bulan DESC
													   ');
													   
				if (count($starting_date) > 0) {
					$starting_year  = $starting_date['tahun'];
					$starting_month = $starting_date['bulan'];
				} else
					return;
					
				$end_date = $this->ci->db->getRow("
												  SELECT
												  DATE_PART('YEAR', tanggal) AS tahun, 
												  DATE_PART('MONTH', tanggal) AS bulan
												  FROM
												  akun.akmt_jurnal
												  WHERE 
												  flag_posting < 2
												  ORDER BY
												  tanggal DESC
												  LIMIT 1
												  ");
												  
				$end_year  = isset($end_date['tahun']) ? $end_date['tahun'] : null;
				$end_month = isset($end_date['bulan']) ? $end_date['bulan'] : null;
				
				if (!is_numeric($end_year) || !is_numeric($end_month))
					return;
						
				$this->ci->db->beginTrans();
				
				$current_year  = $starting_year;
				$current_month = $starting_month;
											
				$current_month++;
								 				 											
				while (intval($current_year . str_pad($current_month, 2, '0', STR_PAD_LEFT)) <= intval($end_year . str_pad($end_month, 2, '0', STR_PAD_LEFT))) {
										
					$this->close($current_year, $current_month);									
						
					if ($current_month == 12) {
						$current_month = 1;
						$current_year++;
					} else
						$current_month++;
				}																	 				
				
				$this->ci->db->endTrans();
			} catch (Exception $e) {
				log_message('DEBUG', "There's exception in Closing::generate, {$e->getMessage()}");			
				$this->ci->db->endTrans(false);
				if ($throw_error)
					throw $e;
				else
					show_error($e->getMessage());
			}		
			
			try {
				// END : Buat proteksi untuk proses closing agar hanya dapat dijalankan satu proses dalam waktu yang sama.
				if ($mem_obj->delete('flag_proses_closing_yayasan', 0) === FALSE)				
					throw new Exception('Tidak Bisa Menghapus flag_proses_closing, Lakukan Restart Server !!!');
					
				if ($mem_obj->close() === FALSE)
					throw new Exception('Tidak Bisa Menutup Koneksi MemCache Server !!!');
				// END : Buat proteksi untuk proses closing agar hanya dapat dijalankan satu proses dalam waktu yang sama.					
				
			} catch (Exception $e) {
				if ($throw_error)
					throw $e;
				else
					show_error($e->getMessage());
			}
		}
		
		private function close($year, $month) {
			log_message('DEBUG', 'Closing::close Called');
			
			$prev_year = $year;
			$prev_month = $month - 1;
					
			if ($this->needProcess($year, $month)) {
				if (!$this->deleted) {
					$this->ci->db->delete('akun.akmt_buku_besar', 
										  'tanggal >= ? AND id_akmt_periode NOT IN (SELECT id_akmt_periode FROM akun.akmt_periode WHERE ((bulan = 0 AND flag_temp = 2) OR (bulan = 0 AND tahun = ?)))', 
										  array("{$year}-{$month}-01", $year));
					
					$this->ci->db->resetSequence('akun.akmt_buku_besar',
												 'id_akmt_buku_besar',
												 'akun.akmt_buku_besar_id_akmt_buku_besar_seq');

					$this->ci->db->delete('akun.akmt_periode', 
										  '((tahun = ? AND bulan >= ?) OR tahun > ?) AND id_akmt_periode NOT IN (SELECT id_akmt_periode FROM akun.akmt_periode WHERE bulan = 0 AND flag_temp = 2)', 
										  array($year, $month, $year));
												 
					$this->ci->db->resetSequence('akun.akmt_periode',
												 'id_akmt_periode',
												 'akun.akmt_periode_id_akmt_periode_seq');
					$this->deleted = true;												 
				}
			} else
				return;
	
			$arr_saldo =& $this->ci->db->getRows('
												 SELECT
												 a.id_akdd_detail_coa,
												 (CASE WHEN c.akhir IS NULL THEN 0 ELSE c.akhir END) AS saldo
												 FROM
												 akun.akdd_coa_level_detail_v a
												 LEFT JOIN
												 (
													SELECT
													ba.id_akdd_detail_coa,
													MAX(ba.id_akmt_buku_besar) AS id_akmt_buku_besar
													FROM
													akun.akmt_buku_besar ba
													INNER JOIN akun.akmt_periode bb ON ba.id_akmt_periode = bb.id_akmt_periode
													WHERE
													bb.tahun = ?
													AND
													bb.bulan = ?
													GROUP BY
													ba.id_akdd_detail_coa
												 ) b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
												 LEFT JOIN akun.akmt_buku_besar c ON a.id_akdd_detail_coa = c.id_akdd_detail_coa AND b.id_akmt_buku_besar = c.id_akmt_buku_besar
												 ', array($prev_year, $prev_month));
												 
			// Simpan saldo akhir dalam format COA.
			$arr_coa = array();
			foreach ($arr_saldo as $saldo) {
				$arr_coa[$saldo['id_akdd_detail_coa']] = $saldo['saldo'];
			}
			
			// Melakukan pemeriksaan apakah terdapat data jurnal yang belum selesai ?
			if ($this->anyBadJurnal())
			throw new Exception('Ada jurnal yang masih belum selesai !');
			
			/*******************************************************************
			 * Ambil transaksi dari jurnal.
			 ******************************************************************* 
			 * Proses jurnal yang diproses adalah yang sudah disetujui saja.
			 ******************************************************************* 
			 */ 
			$arr_trans =& $this->ci->db->getRows("
												 SELECT
												 c.id_akdd_main_coa,
												 a.id_akmt_jurnal,
												 a.no_bukti,
												 a.tanggal,
												 c.id_akdd_detail_coa,
												 c.coa_number,
												 b.jumlah,
												 b.flag_position,
												 a.keterangan
												 FROM
												 akun.akmt_jurnal a
												 INNER JOIN akun.akmt_jurnal_det b ON a.id_akmt_jurnal = b.id_akmt_jurnal
												 INNER JOIN akun.akdd_detail_coa c ON b.id_akdd_detail_coa = c.id_akdd_detail_coa
												 WHERE
												 DATE_PART('MONTH', a.tanggal) = ?
												 AND
												 DATE_PART('YEAR', a.tanggal) = ?
												 AND
												 a.flag_temp = 2
												 ORDER BY
												 b.id_akdd_detail_coa,
												 a.tanggal,
												 a.no_bukti												 
												 ", array($month, $year));
												 
			// Setup periode tutup buku.
			$insert 			 = array();
			$insert['tahun'] 	 = $year;
			$insert['bulan'] 	 = $month;
			$insert['uraian'] 	 = "Tutup Buku Periode {$month}/{$year}";
			$insert['flag_temp'] = 1;
			$this->ci->db->insert('akun.akmt_periode', $insert);

			$id_akmt_periode = $this->ci->db->getLastID('akun.akmt_periode_id_akmt_periode_seq');
			
			// Memasukan saldo awal untuk tiap-tiap bulan.
			foreach ($arr_coa as $id_akdd_detail_coa => $saldo) {
				$insert 					  = array();
				$insert['id_akmt_periode'] 	  = $id_akmt_periode;
				$insert['id_akdd_detail_coa'] =  $id_akdd_detail_coa;
				$insert['no_bukti'] 		  = 'N/A';
				$insert['tanggal'] 			  = "{$year}-{$month}-01 00:00:00";
				$insert['keterangan'] 		  = 'Pindahan Saldo Dari Bulan Sebelumnya';
				$insert['awal'] 			  = $saldo;
				$insert['mutasi_debet'] 	  = 0;
				$insert['mutasi_kredit'] 	  = 0;
				$insert['akhir'] 			  = $saldo;
				$this->ci->db->insert('akun.akmt_buku_besar', $insert);
			}
			
			// Mengambil komponen-komponen kenaikan/penurunan saldo
			if ($month == 12) {
				$arr_naik_turun =& $this->ci->db->getRows('
														  SELECT
														  a.klasifikasi,
														  a.binary_code,
														  b.id_akdd_detail_coa,
														  b.sub_coa,
														  c.coa_number_num
														  FROM
														  akun.akdd_klasifikasi_modal a
														  INNER JOIN akun.akdd_detail_coa_lr b ON a.id_akdd_klasifikasi_modal = b.id_akdd_klasifikasi_modal
														  INNER JOIN akun.akdd_detail_coa c ON b.id_akdd_detail_coa = c.id_akdd_detail_coa
														  WHERE
														  a.binary_code <= 8	
														  ORDER BY
														  a.binary_code DESC
														  ');
			} else {
				$arr_naik_turun =& $this->ci->db->getRows('
														  SELECT
														  a.klasifikasi,
														  a.binary_code,
														  b.id_akdd_detail_coa,
														  b.sub_coa,
														  c.coa_number_num
														  FROM
														  akun.akdd_klasifikasi_modal a
														  INNER JOIN akun.akdd_detail_coa_lr b ON a.id_akdd_klasifikasi_modal = b.id_akdd_klasifikasi_modal
														  INNER JOIN akun.akdd_detail_coa c ON b.id_akdd_detail_coa = c.id_akdd_detail_coa
														  WHERE
														  a.binary_code BETWEEN 4 AND 8
														  ORDER BY
														  a.binary_code DESC
														  ');
			}			
			
			$nt_awal = array();
			$range 	 = array();			
			foreach ($arr_naik_turun as $naik_turun) {
				$klasifikasi 		= $naik_turun['klasifikasi'];
				$binary_code 		= $naik_turun['binary_code'];
				$id_akdd_detail_coa = $naik_turun['id_akdd_detail_coa'];
				$sub_coa 			= str_replace(' ', '', $naik_turun['sub_coa']);
				$coa_number			= $naik_turun['coa_number_num'];
				
				$nt_awal[$id_akdd_detail_coa] = $arr_coa[$id_akdd_detail_coa];
				
				$arr_sub = explode(',', $sub_coa);
				foreach ($arr_sub as $sub) {
					list($begin, $end) = explode('~', $sub);
					$range += array_fill(intval($begin), (intval($end) - intval($begin) + 1), array('id' => $id_akdd_detail_coa, 'code' => $binary_code));
				}							
			}

			foreach ($arr_trans as $trans) {
				$id_akmt_jurnal		= $trans['id_akmt_jurnal'];
				$id_akdd_main_coa 	= $trans['id_akdd_main_coa'];
			
				$insert 					  = array();
				$insert['id_akmt_periode'] 	  = $id_akmt_periode;
				$insert['id_akdd_detail_coa'] = $trans['id_akdd_detail_coa'];
				$insert['no_bukti'] 		  = $trans['no_bukti'];
				$insert['tanggal'] 			  = $trans['tanggal'];
				$insert['keterangan'] 		  = $trans['keterangan'];

				$insert['awal'] 			  = $arr_coa[$trans['id_akdd_detail_coa']];
				if ($trans['flag_position'] == 'd') {
					$insert['mutasi_debet']   = $trans['jumlah'];
					$insert['mutasi_kredit']  = 0;
				} else {
					$insert['mutasi_debet']   = 0;
					$insert['mutasi_kredit']  = $trans['jumlah'];
				}
				$saldo_akhir = $arr_coa[$trans['id_akdd_detail_coa']] + ($trans['jumlah'] * ($trans['flag_position'] == 'd' ? 1 : -1));
				$insert['akhir'] 			  = $saldo_akhir;
				$this->ci->db->insert('akun.akmt_buku_besar', $insert);

				$arr_coa[$trans['id_akdd_detail_coa']] = $saldo_akhir;		
			
				// Menghitung perubahan dana (kenaikan/penurunan)
				if (isset($range[$trans['coa_number']])) {
					$arr_coa[$range[$trans['coa_number']]['id']] += $trans['jumlah'] * ($trans['flag_position'] == 'd' ? 1 : -1);
				}				
			}
			
			$tstamp  	= mktime(0, 0, 0, $month, 1, $year);
			$pad_month	= str_pad($month, 2, '0', STR_PAD_LEFT);
			$tanggal 	= "{$year}-{$pad_month}-" . date('t', $tstamp);	
						
			// Menyusun kodifikasi untuk jurnal automatis.
			$kodifikasi_jurnal 	= $this->ci->db->getField('kode', 'SELECT kode FROM akun.akdd_kodifikasi_jurnal WHERE id_akdd_kodifikasi_jurnal = ?', array(7));
			if (empty($kodifikasi_jurnal))
				throw new Exception('Kodifikasi jurnal automatis tidak tersedia !');
			$month_pad 			= str_pad($month, 2, '0', STR_PAD_LEFT);
			$last_closing 		= $this->ci->db->getField('no_bukti', 'SELECT no_bukti FROM akun.akmt_jurnal WHERE no_bukti LIKE ? ORDER BY no_bukti DESC LIMIT 1', array("{$kodifikasi_jurnal}{$year}{$month_pad}%"));
			$prefix_no_bukti 	= "{$kodifikasi_jurnal}{$year}{$month_pad}";
			
			$no_bukti_numbering = intval(substr($last_closing, -8));
			
			foreach ($arr_naik_turun as $naik_turun) {
				$id_akdd_detail_coa = $naik_turun['id_akdd_detail_coa'];
				$perubahan_dana		= $arr_coa[$id_akdd_detail_coa] - $nt_awal[$id_akdd_detail_coa];
								
				// Saldo ABT/ABTT tidak dibutuhkan saat ini untuk perhitungan Kenaikan/Penurunan.
				if ($naik_turun['binary_code'] < 4) continue;

				$insert 					  = array();
				$insert['id_akmt_periode'] 	  = $id_akmt_periode;
				$insert['id_akdd_detail_coa'] = $id_akdd_detail_coa;
				//$insert['no_bukti'] 		  = 'N/A';
				$insert['no_bukti'] 		  = $prefix_no_bukti . str_pad(++$no_bukti_numbering, 8, '0', STR_PAD_LEFT);
				$insert['tanggal'] 			  = $tanggal;
				$insert['keterangan'] 		  = "Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - {$month}/{$year}";
				$insert['awal'] 			  = $nt_awal[$id_akdd_detail_coa];

				if ($perubahan_dana >= 0) {
					$insert['mutasi_debet']   = $perubahan_dana;
					$insert['mutasi_kredit']  = 0;
				} else {
					$insert['mutasi_debet']   = 0;
					$insert['mutasi_kredit']  = abs($perubahan_dana);
				}

				$insert['akhir'] 			  = $arr_coa[$id_akdd_detail_coa];
				$this->ci->db->insert('akun.akmt_buku_besar', $insert);				
			}

			
			// Rubah status jurnal...			
			$update 				= array();
			$update['flag_posting'] = 1;
			$this->ci->db->update('akun.akmt_jurnal', 
								  $update, 
								  "DATE_PART('MONTH', tanggal) = ? AND DATE_PART('YEAR', tanggal) = ? AND flag_temp = 2", 
								  array($month, $year));

			if ($month == 12) {
				$id_akmt_periode = $this->ci->db->getField('id_akmt_periode',
														   'SELECT id_akmt_periode FROM akun.akmt_periode WHERE flag_temp > 0 ORDER BY tahun DESC, bulan DESC');

				$arr_saldo =& $this->ci->db->getRows('
													 SELECT
													 a.id_akdd_detail_coa,
													 a.coa_number,
													 (CASE WHEN c.akhir IS NULL THEN 0 ELSE c.akhir END) AS saldo,
													 (CASE WHEN e.binary_code IS NULL THEN 0 ELSE e.binary_code END) AS code
													 FROM
													 akun.akdd_coa_level_detail_v a
													 LEFT JOIN
													 (
														SELECT
														id_akdd_detail_coa,
														MAX(id_akmt_buku_besar) AS id_akmt_buku_besar
														FROM
														akun.akmt_buku_besar
														WHERE
														id_akmt_periode = ?
														GROUP BY
														id_akdd_detail_coa
													 ) b ON a.id_akdd_detail_coa = b.id_akdd_detail_coa
													 LEFT JOIN akun.akmt_buku_besar c ON a.id_akdd_detail_coa = c.id_akdd_detail_coa AND b.id_akmt_buku_besar = c.id_akmt_buku_besar
													 LEFT JOIN akun.akdd_detail_coa_lr d ON a.id_akdd_detail_coa = d.id_akdd_detail_coa
													 LEFT JOIN akun.akdd_klasifikasi_modal e ON d.id_akdd_klasifikasi_modal = e.id_akdd_klasifikasi_modal
													 WHERE
													 a.id_akdd_main_coa IN (1, 2, 3)
													 ', array($id_akmt_periode));
													 
				$next_year = $year + 1;
				
				$insert 			 = array();
				$insert['tahun'] 	 = $next_year;
				$insert['bulan'] 	 = 0;
				$insert['uraian'] 	 = "Saldo Awal GL - {$next_year}";
				$insert['flag_temp'] = 1;
				$this->ci->db->insert('akun.akmt_periode', $insert);

				$id_akmt_periode = $this->ci->db->getLastID('akun.akmt_periode_id_akmt_periode_seq');

				$arr_perubahan_dana = array();
				$arr_awal_dana 		= array();
				$arr_dana			= array();
				foreach ($arr_saldo as $saldo) {
				
					if ($saldo['code'] > 2) {
						$arr_perubahan_dana[$range[$saldo['coa_number']]['id']] = $saldo['saldo'];
						$saldo['saldo']	  = 0;
					} 
					
					$insert 					  = array();
					$insert['id_akmt_periode'] 	  = $id_akmt_periode;
					$insert['id_akdd_detail_coa'] =  $saldo['id_akdd_detail_coa'];
					$insert['no_bukti'] 	 	  = 'N/A';
					$insert['tanggal'] 		 	  = "{$next_year}-01-01";
					$insert['keterangan'] 	 	  = "Saldo Awal GL - {$next_year}";
					$insert['awal'] 		 	  = $saldo['saldo'];
					$insert['mutasi_debet']  	  = 0;
					$insert['mutasi_kredit'] 	  = 0;
					$insert['akhir'] 		 	  = $saldo['saldo'];
					$this->ci->db->insert('akun.akmt_buku_besar', $insert);
					
					if (($saldo['code'] > 0) && ($saldo['code'] < 4)) {
						$arr_awal_dana[$saldo['id_akdd_detail_coa']] = $saldo['saldo'];
						$arr_dana[$saldo['id_akdd_detail_coa']] = $this->ci->db->getLastID('akun.akmt_buku_besar_id_akmt_buku_besar_seq');
					}					
				}
				
				foreach ($arr_dana as $id_akdd_detail_coa => $id_akmt_buku_besar) {
					$update = array();
					$update['awal'] = $arr_awal_dana[$id_akdd_detail_coa];
					if ($arr_perubahan_dana[$id_akdd_detail_coa] >= 0) {
						$update['mutasi_debet'] = $arr_perubahan_dana[$id_akdd_detail_coa];
						$update['mutasi_kredit'] = 0;					
					} else {
						$update['mutasi_debet'] = 0;
						$update['mutasi_kredit'] = abs($arr_perubahan_dana[$id_akdd_detail_coa]);										
					}
					$update['akhir'] = $arr_awal_dana[$id_akdd_detail_coa] + $arr_perubahan_dana[$id_akdd_detail_coa];
					$this->ci->db->update('akun.akmt_buku_besar', $update, 'id_akmt_buku_besar = ?', array($id_akmt_buku_besar));
				}

			}
			
		}		
		
		private function needProcess($year, $month) {
			log_message('DEBUG', 'Closing::needProcess Called');
			$flag_temp = $this->ci->db->getField('flag_temp', 
												 '
												 SELECT 
												 flag_temp
												 FROM
												 akun.akmt_periode
												 WHERE
												 tahun = ?
												 AND 
												 bulan = ?
												 ', array($year, $month));
			return (is_numeric($flag_temp) ? (($flag_temp == 0) ? true : false) : true);			
		}
		
		private function anyBadJurnal() {
			log_message('DEBUG', 'Closing::anyBadJurnal Called');
			$any_bad = $this->ci->db->getField('total', 'SELECT COUNT(*) AS total FROM akun.akmt_jurnal WHERE flag_temp = 0');
			
			return ($any_bad != 0);
		}
		
	}
	
/* End of file Closing.php */
/* Location: ./system/application/libraries/Closing.php */	
