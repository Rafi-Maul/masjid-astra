<?php  
	if (!defined('BASEPATH')) exit('No direct script access allowed');

	/**
	 * getCurrentDate
	 *
	 * Returns a string of current day (in Indonesian).
	 *
	 * @access	public
	 * @param	bool	TRUE for short format, FALSE for long format, default is short format
	 * @return	string
	 */	
	if (!function_exists('getCurrentDate')) {		
		function getCurrentDate($short = TRUE) {
			$arrMonth = array();
			$arrMonth[1] = array('short' => 'Jan', 'long' => 'Januari');
			$arrMonth[2] = array('short' => 'Feb', 'long' => 'Februari');
			$arrMonth[3] = array('short' => 'Mar', 'long' => 'Maret');
			$arrMonth[4] = array('short' => 'Apr', 'long' => 'April');
			$arrMonth[5] = array('short' => 'Mei', 'long' => 'Mei');
			$arrMonth[6] = array('short' => 'Jun', 'long' => 'Juni');
			$arrMonth[7] = array('short' => 'Jul', 'long' => 'Juli');
			$arrMonth[8] = array('short' => 'Agu', 'long' => 'Agustus');
			$arrMonth[9] = array('short' => 'Sep', 'long' => 'September');
			$arrMonth[10] = array('short' => 'Okt', 'long' => 'Oktober');
			$arrMonth[11] = array('short' => 'Nov', 'long' => 'November');
			$arrMonth[12] = array('short' => 'Des', 'long' => 'Desember');

			$month = date('n');

			if ($arrMonth !== FALSE) {
				$dateStr = date("d") . ' ' . (($short) ? $arrMonth[$month]['short'] : $arrMonth[$month]['long']) . ' ' . date("Y");
				return $dateStr;
			} else
				return null;
		}
	}

	/**
	 * setInputDate
	 *
	 * Returns a string of current day.
	 *
	 * @access	public
	 * @param	string	Name of input date
	 * @param	integer Number of previous year(s)
	 * @param	integer Number of next year(s)
	 * @param	integer Default day
	 * @param	integer Default month
	 * @param	integer Default year
	 * @return	string
	 */	
	if (!function_exists('setInputDate')) {
		function setInputDate($name, $preYear = 1, $nexYear = 1, $day = '', $month = '', $year = '') {
			$fToDay = ((empty($day)) && (empty($month)) && (empty($year)));

			$arrMonth = array();
			$arrMonth[1] = array('short' => 'Jan', 'long' => 'Januari');
			$arrMonth[2] = array('short' => 'Feb', 'long' => 'Februari');
			$arrMonth[3] = array('short' => 'Mar', 'long' => 'Maret');
			$arrMonth[4] = array('short' => 'Apr', 'long' => 'April');
			$arrMonth[5] = array('short' => 'Mei', 'long' => 'Mei');
			$arrMonth[6] = array('short' => 'Jun', 'long' => 'Juni');
			$arrMonth[7] = array('short' => 'Jul', 'long' => 'Juli');
			$arrMonth[8] = array('short' => 'Agu', 'long' => 'Agustus');
			$arrMonth[9] = array('short' => 'Sep', 'long' => 'September');
			$arrMonth[10] = array('short' => 'Okt', 'long' => 'Oktober');
			$arrMonth[11] = array('short' => 'Nov', 'long' => 'November');
			$arrMonth[12] = array('short' => 'Des', 'long' => 'Desember');

			$day = empty($day) ? date('j') : intval($day);
			$month = empty($month) ? date('n') : intval($month);
			$year = empty($year) ? date('Y') : intval($year);
			$yearNow = date('Y');

			$loYear = $year - $preYear;
			$hiYear = $year + $nexYear;
			$yearRange = range($loYear, $hiYear);
			if ($loYear > $yearNow || $hiYear < $yearNow) $yearRange[] = $yearNow;

			$maxDay = date('t', mktime(0, 0, 0, $month, $day, $year));

			$yearFormat = $year;
			$monthFormat = str_pad($month, 2, '0', STR_PAD_LEFT);
			$dayFormat = str_pad($day, 2, '0', STR_PAD_LEFT);

			$currentDate = "{$yearFormat}-{$monthFormat}-{$dayFormat}";

			?>
			<table class='inputDate' border='0' cellspacing='0' cellpadding='0'>
				<tr>
					<td>
						<select id='<?php echo $name; ?>Day' size='1' onchange="javascript: setDate('<?php echo $name; ?>');" class='required'>
							<?php
								for ($i = 1; $i <= $maxDay; $i++) {
							?>
							<option value='<?php echo $i; ?>' <?php if ($i == $day) { ?>selected<?php } ?>><?php echo str_pad($i, 2, '0', STR_PAD_LEFT); ?></option>
							<?php
								}
							?>
						</select>				
					</td>
					<td>
						<select id='<?php echo $name;?>Month' size='1' onchange="javascript: dateChange('<?php echo $name;?>Day', '<?php echo $name;?>Month', '<?php echo $name;?>Year'); setDate('<?php echo $name; ?>');" class='required'>
							<?php
								for ($i = 1; $i <= 12; $i++) {
							?>
							<option value='<?php echo $i; ?>' <?php if ($i == $month) { ?>selected<?php } ?>><?php echo $arrMonth[$i]['short']; ?></option>
							<?php
								}
							?>
						</select>				
					</td>
					<td>
						<select id='<?php echo $name;?>Year' size='1' onchange="javascript: dateChange('<?php echo $name;?>Day', '<?php echo $name;?>Month', '<?php echo $name;?>Year'); setDate('<?php echo $name; ?>');" class='required'>
							<?php
								//for ($i = $loYear; $i <= $hiYear; $i++) {
								foreach ($yearRange as $i) {
							?>							
							<option value='<?php echo $i; ?>' <?php if ($i == $year) { ?>selected<?php } ?>><?php echo $i; ?></option>
							<?php
								}
							?>
						</select>
					</td>
				</tr>
			</table>
			<input type='hidden' name='<?php echo $name; ?>' id='<?php echo $name; ?>' value='<?php echo $currentDate; ?>'/>
			<script language='javascript' type='text/javascript'>
				<!--
				setToday('<?php echo $name; ?>Day', '<?php echo $name; ?>Month', '<?php echo $name; ?>Year', <?php echo ($fToDay ? 'true' : 'false'); ?>);
				//-->
			</script>
			<?php
		}
	 }

	/**
	 * getLocalDate
	 *
	 * Returns a string of current date in dd-mm-YYYY.
	 *
	 * @access	public
	 * @param	string	Input date
	 * @return	string
	 */	
	if (!function_exists('getLocalDate')) {
		function getLocalDate($date, $full = FALSE) {
			if ($full) {
				$arrDate = preg_split('[- :]', $date, 6);
				if ($arrDate === FALSE)
					die('Tidak Bisa Mengekstrak Tanggal !!!');
				if (count($arrDate) == 6)
					return "{$arrDate[2]}-{$arrDate[1]}-{$arrDate[0]} {$arrDate[3]}:{$arrDate[4]}:{$arrDate[5]}";
				else
					return "{$arrDate[2]}-{$arrDate[1]}-{$arrDate[0]}";
			} else {
				$arrDate = preg_split('[-]', $date, 3);
				if ($arrDate === FALSE)
					die('Tidak Bisa Mengekstrak Tanggal !!!');
				return "{$arrDate[2]}-{$arrDate[1]}-{$arrDate[0]}";
			}
		}

	}

	/**
	 *
	 * getMonthString
	 *
	 * Returns a string of current month value
	 */
	if (!function_exists('getMonthString')) {
		function getMonthString($value, $fLong = true) {
			$arrMonth = array();
			$arrMonth[1] = array('short' => 'Jan', 'long' => 'Januari');
			$arrMonth[2] = array('short' => 'Feb', 'long' => 'Februari');
			$arrMonth[3] = array('short' => 'Mar', 'long' => 'Maret');
			$arrMonth[4] = array('short' => 'Apr', 'long' => 'April');
			$arrMonth[5] = array('short' => 'Mei', 'long' => 'Mei');
			$arrMonth[6] = array('short' => 'Jun', 'long' => 'Juni');
			$arrMonth[7] = array('short' => 'Jul', 'long' => 'Juli');
			$arrMonth[8] = array('short' => 'Agu', 'long' => 'Agustus');
			$arrMonth[9] = array('short' => 'Sep', 'long' => 'September');
			$arrMonth[10] = array('short' => 'Okt', 'long' => 'Oktober');
			$arrMonth[11] = array('short' => 'Nov', 'long' => 'November');
			$arrMonth[12] = array('short' => 'Des', 'long' => 'Desember');

			if ($fLong)
				return $arrMonth[$value]['long'];
			else
				return $arrMonth[$value]['short'];
		}
	}

/* End of file Mydate_helper.php */
/* Location: ./system/application/helpers/Mydate_helper.php */
