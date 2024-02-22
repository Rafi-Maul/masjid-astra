<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class TutupBuku extends MyController {
	
		public function __construct() {
			log_message('DEBUG', 'akun::TutupBuku Class Initialized');
			parent::__construct();
		}
		
		public function index() {
			$this->password->getUrlAccess();
			
			$this->load->helper('date');
			$this->load->helper('number');
			
			$prev_month = $this->db->getField('bulan_tahun', 
											  "
											  SELECT 
											  (
											  CASE 
											  WHEN bulan = 12 THEN
											  ((tahun + 1)::VARCHAR(4) || lpad(1::VARCHAR(2), 2, '0')::VARCHAR(2))
											  ELSE
											  (tahun::VARCHAR(4) || lpad((bulan + 1)::VARCHAR(2), 2, '0')::VARCHAR(2))
											  END
											  )::VARCHAR(6) AS bulan_tahun 	
											  FROM
											  akun.akmt_periode
											  WHERE
											  flag_temp = 2
											  ORDER BY
											  tahun DESC,
											  bulan DESC
											  LIMIT 1
											  ");
			
			$arr_month =& $this->db->getRows("
											 SELECT
											 DATE_PART('YEAR', tanggal) AS tahun,
											 DATE_PART('MONTH', tanggal) AS bulan
											 FROM
											 akun.akmt_jurnal
											 WHERE
											 flag_posting < 2
											 GROUP BY
											 DATE_PART('YEAR', tanggal),
											 DATE_PART('MONTH', tanggal)
											 ORDER BY
											 DATE_PART('YEAR', tanggal),
											 DATE_PART('MONTH', tanggal)
											 ");
			if (count($arr_month) > 0) {
				$current_month = $arr_month[0]['bulan'];
				$current_year  = $arr_month[0]['tahun'];
			} else {
				$current_month = date('n');
				$current_year  = date('Y');
			}			
		
			// Get post and/or flash data...
			$page    =& $this->getInitVar('page', 1);
			$filter  =& $this->getInitVar('filter', $current_year . str_pad($current_month, 2, '0', STR_PAD_LEFT));
			
			// Default where...
			$sql_plus = "DATE_PART('YEAR', a.tanggal) = ? AND DATE_PART('MONTH', a.tanggal) = ?";
			$params   = array(intval(substr($filter, 0, 4)), intval(substr($filter, -2)));			
			
			$sql = "
				   SELECT
				   a.tanggal,
				   a.no_bukti,
				   a.keterangan,
				   SUM(CASE WHEN b.flag_position = 'd' THEN b.jumlah ELSE 0 END) AS jumlah,
				   a.flag_temp
				   FROM
				   akun.akmt_jurnal a
				   INNER JOIN akun.akmt_jurnal_det b ON a.id_akmt_jurnal = b.id_akmt_jurnal
				   WHERE
				   a.flag_temp > 0
				   AND
				   {$sql_plus}
				   GROUP BY
				   a.tanggal,
				   a.no_bukti,
				   a.keterangan,
				   a.flag_temp
				   ORDER BY
				   a.tanggal,
				   a.no_bukti
				   ";
				   			
			try {
				$arr_jurnal =& $this->db->createPaging($page, $this->getListPerPage(), $sql, $params);
			} catch (Exception $e) {
				show_error($e->getMessage());
			}		
			
			$this->setHidden('filter', $filter);
		
			$data 			  	= array();
			$data['page']	  	= $page;
			$data['filter']	  	= $filter;
			$data['arr_jurnal'] = $arr_jurnal;
			$data['arr_month'] 	= $arr_month;
			$data['prev_month'] = $prev_month;
			$this->load->viewPage('akun/list_tutup', $data);			
		}
		
		public function proses() {
			$this->password->getUrlAccess('/akun/tutupBuku', 'proses');
			
			$this->load->helper('date');
			
			$closing_response = array();
		
			try {		
				$filter = $this->getVar('periode', TRUE);
				
				$year  = substr($filter, 0, 4);
				$month = intval(substr($filter, -2));
				
				$this->load->library('Closing');
				$this->closing->generate(true);
									
				$this->db->beginTrans();
				
				// Bila belum ada approval maka ditolak...
				$non_approval = $this->db->getField('non_approval',
													"
													SELECT 
													COUNT(*) AS non_approval 
													FROM 
													akun.akmt_jurnal 
													WHERE 
													DATE_PART('MONTH', tanggal) = ?
													AND
													DATE_PART('YEAR', tanggal) = ?
													AND
													flag_temp < 2
													", array($month, $year));
													
				if ($non_approval > 0)
					throw new Exception('Masih terdapat data jurnal yang belum disetujui !');
				
				// Tutup buku jurnal...
				$update 				= array();
				$update['flag_posting'] = 2;
				$this->db->update('akun.akmt_jurnal', 
								  $update,
								  "
								  DATE_PART('MONTH', tanggal) = ?
								  AND
								  DATE_PART('YEAR', tanggal) = ?
								  ", 
								  array($month, $year));
								  
				// Tutup buku periode...
				$update 			 = array();
				$update['flag_temp'] = 2;
				$this->db->update('akun.akmt_periode',
								  $update,
								  'bulan = ? AND tahun = ?',
								  array($month, $year));
				
				// Tutup juga periode berikutnya (untuk akhir tahun)...
				if ($month == 12) {
					$next_year = $year + 1;
					$this->db->update('akun.akmt_periode',
									  $update,
									  'bulan = 0 AND tahun = ?',
									  array($next_year));					
				}							
								
				$this->db->endTrans();

				$closing_response['flag'] 	  = 1;
				$closing_response['message']  = 'Proses tutup buku untuk bulan ' . getMonthString($month) . ", {$year} berhasil";
				
			} catch (Exception $e) {
				log_message('DEBUG', 'There is exception in TutupBuku::proses');
				$this->db->endTrans(false);

				$closing_response['flag'] 	  = 0;
				$closing_response['message']  = 'Proses tutup buku untuk bulan ' . getMonthString($month) . ", {$year} tidak berhasil\n\nPenjelasan Teknis:\n{$e->getMessage()}";
			}
			log_message('DEBUG', 'Response : ' . json_encode($closing_response));
			echo json_encode($closing_response);
		}
		
		public function report($filter) {
			$this->password->getUrlAccess('/akun/tutupBuku', 'cetak');
			
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
			$arrCol['title'] = 'PERSETUJUAN';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'TANGGAL';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
			$arrCol['span'] = 2;
			$arrCol['sub'] = null;

			array_push($mainCols, $arrCol);
			
			$arrCol = array();
			$arrCol['title'] = 'NO. BUKTI';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'C';
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
			$arrCol['title'] = 'NOMINAL';
			$arrCol['width'] = 30;
			$arrCol['align'] = 'C';
			$arrCol['calign'] = 'R';
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
			$this->load->helper('number');

			$this->report->SetLogo($this->getImgFolder() . '/logo.jpg');
			$this->report->SetLogoWidth(25);

			$this->report->SetReportMainTitle('LAPORAN TUTUP BUKU');
			$this->report->SetReportTitle('TANGGAL CETAK', strtoupper(getCurrentDate(false)));
			$this->report->SetReportTitle('BULAN', strtoupper(getMonthString(intval(substr($filter, -2)))) . ', ' . substr($filter, 0, 4));
			$this->report->Open();
			$this->report->AddPage();

			/**************************** BEGIN CONTENT ****************************/

			// Default where...
			$sql_plus = "DATE_PART('YEAR', a.tanggal) = ? AND DATE_PART('MONTH', a.tanggal) = ?";
			$params   = array(intval(substr($filter, 0, 4)), intval(substr($filter, -2)));			
			
			$sql = "

				   SELECT
				   a.tanggal,
				   a.no_bukti,
				   a.keterangan,
				   SUM(CASE WHEN b.flag_position = 'd' THEN b.jumlah ELSE 0 END) AS jumlah,
				   a.flag_temp
				   FROM
				   akun.akmt_jurnal a
				   INNER JOIN akun.akmt_jurnal_det b ON a.id_akmt_jurnal = b.id_akmt_jurnal
				   WHERE
				   a.flag_temp > 0
				   AND
				   {$sql_plus}
				   GROUP BY
				   a.tanggal,
				   a.no_bukti,
				   a.keterangan,
				   a.flag_temp
				   ORDER BY
				   a.tanggal,
				   a.no_bukti
				   ";
			
			// Retrieve data from database...
			$rows =& $this->db->getRows($sql, $params);

			$i = 1;
			foreach ($rows as $row) {
				$arrData = array();

				$arrData[] = $i++ . '.';
				$arrData[] = ($row['flag_temp'] == 1 ? 'Belum' : 'Sudah');
				$arrData[] = getLocalDate($row['tanggal']);
				$arrData[] = $row['no_bukti'];
				$arrData[] = $row['keterangan'];
				$arrData[] = numFormat($row['jumlah']);
				$this->report->InsertRow($arrData);
			}

			/**************************** END CONTENT ****************************/

			$this->report->ShowPDF($this->session->userdata('session_id') . '_' . time(), true);
		}				
		
	}
	
/* End of file tutupBuku.php */
/* Location: ./system/application/controllers/akun/tutupBuku.php */		
