<?php
	if (!defined('BASEPATH')) exit('No direct script access allowed');

	define('FPDF_FONTPATH', APPPATH . '_3rd/fpdf/font/');
	require_once(APPPATH . '_3rd/fpdf/fpdf.php');

	class Report extends FPDF {

		// Constants

		const footerHeight = -8;
		const footerFontSize = 8;
		const footerFont = 'Arial';
		const footerPage = 'Halaman ';
		const fillColor = '250, 250, 250';
		const redLineColor = 200;
		const greenLineColor = 200;
		const blueLineColor = 200;
		const textColor = '0, 0, 0';

		// Object 

		private $instance;

		// Properties
		
		private $orientation;
		private $paperFormat;
		private $format;
		/**
		*	A4		= 210	x 297	mm
		*	A3		= 297	x 420	mm
		*	A2		= 420	x 594	mm
		*	Letter	= 215.9	x 279.4 mm
		*	Legal	= 215.9	x 355.6	mm
		*/

		private $locLogo;
		private $widthLogo;
		private $heightLogo;

		private $flagFooter;
		private $arrTitle;
		private $mainTitle;
		private $flagBP;
		private $noBP;
		private $tglBP;

		private $arrCols;
		private $arrWidth;
		private $arrLabel;
		private $rowHeight;
		private $arrAlign;
		private $tempFolder;

		private $top;
		private $left;

		private $numFields;
		private $numSpans;
		private $fSpans;
		private $maxLength;

		// Tambahan untuk diagram

		private $legends;
		private $wLegend;
		private $sum;
		private $NbVal;

		// Private methods

		private function CheckPageBreak($h) {
			//If the height h would cause an overflow, add a new page immediately
			if ($this->GetY() + $h > $this->PageBreakTrigger)
				$this->AddPage($this->CurOrientation);
		}

		private function SetHeader(&$cols, $num, $flagNext) {
			$x = $this->GetX();

			if ($flagNext)
				$this->SetXY($x, $this->top);

			if ($cols['sub'] == null) {
				if ($this->PageNo() == 1) {
					$this->numFields++;
					$this->arrWidth[] = $cols['width'];
					$this->maxLength += $cols['width'];
					$this->arrAlign[] = isset($cols['calign']) ? $cols['calign'] : $cols['align'];
					$this->arrLabel[] = isset($cols['label']) ? $cols['label'] : $this->numFields;
				}
			} 

			if (($this->PageNo() == 1) && ($num == 0) && ($this->fSpans)) {
				$this->numSpans += $cols['span'];
				if ($cols['sub'] == null)
					$this->fSpans = false;
			}

			// BugFixed : Untuk menanggulangi sub kolom lebih dari 2 baris.
			$prevY = $this->GetY();

			$this->Cell($cols['width'], ($this->rowHeight * $cols['span']), $cols['title'], 'TBLR', 0, $cols['align'], ($this->flagBP ? 0 : 1));

			if (is_array($cols['sub'])) {
				if (count($cols['sub']) > 1) {
					$this->Ln();
					$this->SetX($x);
					for ($i = 0; $i < count($cols['sub']); $i++) {
						$this->SetHeader($cols['sub'][$i], $num, false);
					}
					// BugFixed : Untuk menanggulangi sub kolom lebih dari 2 baris.
					$this->SetXY($this->GetX(), $prevY);
				}
			}
		}

		private function StartTransform() {
			//save the current graphic state
			$this->_out('q');
		}

		private function ScaleX($s_x, $x = '', $y = '') {
			$this->Scale($s_x, 100, $x, $y);
		}

		private function ScaleY($s_y, $x = '', $y = '') {
			$this->Scale(100, $s_y, $x, $y);
		}

		private function ScaleXY($s, $x = '', $y = '') {
			$this->Scale($s, $s, $x, $y);
		}

		private function Scale($s_x, $s_y, $x = '', $y = '') {
			if ($x === '')
				$x = $this->x;
			if ($y === '')
				$y = $this->y;
			if (($s_x == 0) || ($s_y == 0))
				$this->Error('Please use values unequal to zero for Scaling');
			$y = ($this->h - $y) * $this->k;
			$x *= $this->k;
			//calculate elements of transformation matrix
			$s_x /= 100;
			$s_y /= 100;
			$tm[0] = $s_x;
			$tm[1] = 0;
			$tm[2] = 0;
			$tm[3] = $s_y;
			$tm[4] = $x * (1 - $s_x);
			$tm[5] = $y * (1 - $s_y);
			//scale the coordinate system
			$this->Transform($tm);
		}

		private function MirrorH($x = '') {
			$this->Scale(-100, 100, $x);
		}

		private function MirrorV($y = '') {
			$this->Scale(100, -100, '', $y);
		}

		private function MirrorP($x = '', $y = '') {
			$this->Scale(-100, -100, $x, $y);
		}

		private function MirrorL($angle = 0, $x = '', $y = '') {
			$this->Scale(-100, 100, $x, $y);
			$this->Rotate(-2 * ($angle - 90), $x, $y);
		}

		private function TranslateX($t_x) {
			$this->Translate($t_x, 0, $x, $y);
		}

		private function TranslateY($t_y) {
			$this->Translate(0, $t_y, $x, $y);
		}
		
		private function Translate($t_x, $t_y) {
			//calculate elements of transformation matrix
			$tm[0] = 1;
			$tm[1] = 0;
			$tm[2] = 0;
			$tm[3] = 1;
			$tm[4] = $t_x * $this->k;
			$tm[5] = -$t_y * $this->k;
			//translate the coordinate system
			$this->Transform($tm);
		}

		private function Rotate($angle, $x = '', $y = '') {
			if ($x === '')
				$x = $this->x;
			if ($y === '')
				$y = $this->y;
			$y = ($this->h - $y) * $this->k;
			$x *= $this->k;
			//calculate elements of transformation matrix
			$tm[0] = cos(deg2rad($angle));
			$tm[1] = sin(deg2rad($angle));
			$tm[2] = -$tm[1];
			$tm[3] = $tm[0];
			$tm[4] = $x + $tm[1] * $y-$tm[0] * $x;
			$tm[5] = $y - $tm[0] * $y-$tm[1] * $x;
			//rotate the coordinate system around ($x,$y)
			$this->Transform($tm);
		}

		private function SkewX($angle_x, $x = '', $y = '') {
			$this->Skew($angle_x, 0, $x, $y);
		}

		private function SkewY($angle_y, $x = '', $y = '') {
			$this->Skew(0, $angle_y, $x, $y);
		}
		
		private function Skew($angle_x, $angle_y, $x = '', $y = '') {
			if ($x === '')
				$x = $this->x;
			if ($y === '')
				$y = $this->y;
			if (($angle_x <= -90) || ($angle_x >= 90) || ($angle_y <= -90) || ($angle_y >= 90))
				$this->Error('Please use values between -90� and 90� for skewing');
			$x *= $this->k;
			$y = ($this->h-$y) * $this->k;
			//calculate elements of transformation matrix
			$tm[0] = 1;
			$tm[1] = tan(deg2rad($angle_y));
			$tm[2] = tan(deg2rad($angle_x));
			$tm[3] = 1;
			$tm[4] = -$tm[2] * $y;
			$tm[5] = -$tm[1] * $x;
			//skew the coordinate system
			$this->Transform($tm);
		}

		private function Transform($tm) {
			$this->_out(sprintf('%.3f %.3f %.3f %.3f %.3f %.3f cm', $tm[0], $tm[1], $tm[2], $tm[3], $tm[4], $tm[5]));
		}

		private function StopTransform() {
			//restore previous graphic state
			$this->_out('Q');
		}

		private function checksum_code39($code) {

			//Compute the modulo 43 checksum

			$chars = array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
									'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
									'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
									'W', 'X', 'Y', 'Z', '-', '.', ' ', '$', '/', '+', '%');
			$sum = 0;
			for ($i = 0; $i < strlen($code); $i++) {
				$a = array_keys($chars, $code{$i});
				$sum += $a[0];
			}
			$r = $sum % 43;
			return $chars[$r];
		}

		private function encode_code39_ext($code) {

			//Encode characters in extended mode

			$encode = array(
				chr(0) => '%U', chr(1) => '$A', chr(2) => '$B', chr(3) => '$C',
				chr(4) => '$D', chr(5) => '$E', chr(6) => '$F', chr(7) => '$G',
				chr(8) => '$H', chr(9) => '$I', chr(10) => '$J', chr(11) => '�K',
				chr(12) => '$L', chr(13) => '$M', chr(14) => '$N', chr(15) => '$O',
				chr(16) => '$P', chr(17) => '$Q', chr(18) => '$R', chr(19) => '$S',
				chr(20) => '$T', chr(21) => '$U', chr(22) => '$V', chr(23) => '$W',
				chr(24) => '$X', chr(25) => '$Y', chr(26) => '$Z', chr(27) => '%A',
				chr(28) => '%B', chr(29) => '%C', chr(30) => '%D', chr(31) => '%E',
				chr(32) => ' ', chr(33) => '/A', chr(34) => '/B', chr(35) => '/C',
				chr(36) => '/D', chr(37) => '/E', chr(38) => '/F', chr(39) => '/G',
				chr(40) => '/H', chr(41) => '/I', chr(42) => '/J', chr(43) => '/K',
				chr(44) => '/L', chr(45) => '-', chr(46) => '.', chr(47) => '/O',
				chr(48) => '0', chr(49) => '1', chr(50) => '2', chr(51) => '3',
				chr(52) => '4', chr(53) => '5', chr(54) => '6', chr(55) => '7',
				chr(56) => '8', chr(57) => '9', chr(58) => '/Z', chr(59) => '%F',
				chr(60) => '%G', chr(61) => '%H', chr(62) => '%I', chr(63) => '%J',
				chr(64) => '%V', chr(65) => 'A', chr(66) => 'B', chr(67) => 'C',
				chr(68) => 'D', chr(69) => 'E', chr(70) => 'F', chr(71) => 'G',
				chr(72) => 'H', chr(73) => 'I', chr(74) => 'J', chr(75) => 'K',
				chr(76) => 'L', chr(77) => 'M', chr(78) => 'N', chr(79) => 'O',
				chr(80) => 'P', chr(81) => 'Q', chr(82) => 'R', chr(83) => 'S',
				chr(84) => 'T', chr(85) => 'U', chr(86) => 'V', chr(87) => 'W',
				chr(88) => 'X', chr(89) => 'Y', chr(90) => 'Z', chr(91) => '%K',
				chr(92) => '%L', chr(93) => '%M', chr(94) => '%N', chr(95) => '%O',
				chr(96) => '%W', chr(97) => '+A', chr(98) => '+B', chr(99) => '+C',
				chr(100) => '+D', chr(101) => '+E', chr(102) => '+F', chr(103) => '+G',
				chr(104) => '+H', chr(105) => '+I', chr(106) => '+J', chr(107) => '+K',
				chr(108) => '+L', chr(109) => '+M', chr(110) => '+N', chr(111) => '+O',
				chr(112) => '+P', chr(113) => '+Q', chr(114) => '+R', chr(115) => '+S',
				chr(116) => '+T', chr(117) => '+U', chr(118) => '+V', chr(119) => '+W',
				chr(120) => '+X', chr(121) => '+Y', chr(122) => '+Z', chr(123) => '%P',
				chr(124) => '%Q', chr(125) => '%R', chr(126) => '%S', chr(127) => '%T');

			$code_ext = '';
			for ($i = 0; $i < strlen($code); $i++) {
				if (ord($code{$i}) > 127)
					$this->Error('Invalid character: ' . $code{$i});
				$code_ext .= $encode[$code{$i}];
			}
			return $code_ext;
		}

		private function draw_code39($code, $x, $y, $w, $h) {

			//Draw bars

			for ($i = 0; $i < strlen($code); $i++) {
				if($code{$i} == '1')
					$this->Rect($x + $i * $w, $y, $w, $h, 'F');
			}
		}

		private function SetLegends($data, $format) {
			$this->legends = array();
			$this->wLegend = 0;
			$this->sum = array_sum($data);
			$this->NbVal = count($data);

			foreach ($data as $l => $val) {
				$p = sprintf('%.2f', $val / $this->sum * 100) . '%';
				$legend = str_replace(array('%l', '%v', '%p'), array($l, $val, $p), $format);
				$this->legends[] = $legend;
				$this->wLegend = max($this->GetStringWidth($legend), $this->wLegend);
			}
		}

		private function _Arc($x1, $y1, $x2, $y2, $x3, $y3) {
			$h = $this->h;
			$this->_out(sprintf('%.2f %.2f %.2f %.2f %.2f %.2f c',
				$x1 * $this->k,
				($h - $y1) * $this->k,
				$x2 * $this->k,
				($h - $y2) * $this->k,
				$x3 * $this->k,
				($h - $y3) * $this->k));
		}

		private function CleanFiles($dir) {
			// Delete temporary files every 600 seconds => 10 minutes
			$t = time();
			$h = opendir($dir);
			while ($file = readdir($h)) {
				if ((substr($file, 0, 3) == 'tmp') && (substr($file, -4) == '.pdf')) {
					$path = $dir . '/' . $file;
					if (($t - filemtime($path)) > 600)
						@unlink($path);
				}
			}
			closedir($h);
		}


		// Public methods

		/**
		*
		*	Constructor
		*	$arrCols		: Array of columns (see example).
		*	$orientation	: 'P' for portrait, 'L' for landscape.
		*	$format			: 'A2', 'A3', 'A4', 'Letter', 'Legal' or custom size [ex. array(100, 100)].
		*	$tempFolder		: Location for temporary folder.
		*	$rowHeight		: The line height of cell.
		*
		*/

		public function __construct($params) {
			$this->instance =& get_instance();

			$arrCols = ((isset($params['arrHead'])) ? $params['arrHead'] : null);
			$orientation = ((isset($params['orientation'])) ? $params['orientation'] : 'P');
			$format = ((isset($params['format'])) ? $params['format'] : null);
			$tempFolder = ((isset($params['tempFolder'])) ? $params['tempFolder'] : APPPATH . '_tmp');
			$rowHeight = ((isset($params['rowHeight'])) ? $params['rowHeight'] : 5);
			
			$this->paperFormat = $format;

			if (is_array($format)) {
				$paperWidth = $format[0];
				$paperHeight = $format[1];
			} else {
				if (is_null($format)) {
					if (strtolower($orientation) == 'p') {
						$paperWidth = 0;
						foreach ($arrCols as $arrCol)
							$paperWidth += $arrCol['width'];
						$paperWidth += 25;
						$paperHeight = $paperWidth * sqrt(2);
					} else {
						$paperHeight = 0;
						foreach ($arrCols as $arrCol)
							$paperHeight += $arrCol['width'];
						$paperHeight += 25;
						$paperWidth = $paperHeight * 1/sqrt(2);
					}

				} else if (!is_array($format)) {

					// Jika menggunakan ukuran kertas dalam daftar, yaitu : 'A2', 'A3', 'A4', 'Letter', 'Legal'

					/**
					*	A4		= 210	x 297	mm
					*	A3		= 297	x 420	mm
					*	A2		= 420	x 594	mm
					*	Letter	= 215.9	x 279.4 mm
					*	Legal	= 215.9	x 355.6	mm
					*/

					switch (strtolower($format)) {
						case 'a2' :
							$pRatio = 594/420;
							$lRatio = 420/594;
							$paperWidth = 420;
							$paperHeight = 594;
							break;
						case 'a3' :
							$pRatio = 420/297;
							$lRatio = 297/420;
							$paperWidth = 297;
							$paperHeight = 420;
							break;
						case 'a4' :
							$pRatio = 297/210;
							$lRatio = 210/297;
							$paperWidth = 210;
							$paperHeight = 297;
							break;
						case 'letter' :
							$pRatio = 279.4/215.9;
							$lRatio = 215.9/279.4;
							$paperWidth = 215.9;
							$paperHeight = 279.4;
							break;
						case 'legal' :
							$pRatio = 355.6/215.9;
							$lRatio = 215.9/355.6;
							$paperWidth = 215.9;
							$paperHeight = 355.6;
							break;
						default :
							die('Invalid format for paper size !');
					}

					if (is_array($arrCols)) {
						if (strtolower($orientation) == 'p') {
							$paperWidth = 0;
							foreach ($arrCols as $arrCol)
								$paperWidth += $arrCol['width'];
							$paperWidth += 25;
							$paperHeight = $paperWidth * $pRatio;
						} else {
							$paperHeight = 0;
							foreach ($arrCols as $arrCol)
								$paperHeight += $arrCol['width'];
							$paperHeight += 25;
							$paperWidth = $paperHeight * $lRatio;
						}				
					} 
					/*
					if (strtolower($format) == 'a2')
						$format = array(420, 594);
					*/
				}
			}
	
			$format = array($paperWidth, $paperHeight);				

			parent::__construct($orientation, 'mm', $format);
			$this->orientation = $orientation;
			$this->format = $format;
			$this->arrCols = $arrCols;
			$this->tempFolder = $tempFolder;
			$this->rowHeight = $rowHeight;
			$this->numFields = 0;
			$this->numSpans = 0;
			$this->fSpans = true;
			$this->maxLength = 0;
			$this->locLogo = '';
			$this->flagFooter = true;
			$this->arrTitle = array();
			$this->mainTitle = null;
			$this->flagBP = false;
			$this->noBP = null;
			$this->tglBP = null;
			$this->arrWidth = array();
			$this->arrAlign = array();
			$this->arrLabel = array();
			
			$this->SetDrawColor(self::redLineColor, self::greenLineColor, self::blueLineColor);
			
			$this->SetMargins(15, 10, 10);

			$this->AliasNbPages();
			$this->SetAutoPageBreak(true, 10);

			$this->CleanFiles($this->tempFolder);
/*
			// Book Antiqua
			$this->AddFont('Book Antiqua - Bold', 'B', 'antquab.php');
			$this->AddFont('Book Antiqua - Bold Italic', 'BI', 'antquabi.php');
			$this->AddFont('Book Antiqua - Italic', 'I', 'antquai.php');
			$this->AddFont('Book Antiqua', '', 'bkant.php');

			// Tahoma
			$this->AddFont('Tahoma', '', 'tahoma.php');
			$this->AddFont('Tahoma - Bold', 'B', 'tahomabd.php');

			// Trebuchet
			$this->AddFont('Trebuchet', '', 'trebuc.php');
			$this->AddFont('Trebuchet - Bold', 'B', 'trebucbd.php');
			$this->AddFont('Trebuchet - Bold Italic', 'BI', 'trebucbi.php');
			$this->AddFont('Trebuchet - Italic', 'I', 'trebucit.php');

			// Verdana
			$this->AddFont('Verdana', '', 'verdana.php');
			$this->AddFont('Verdana - Bold', 'B', 'verdanab.php');
			$this->AddFont('Verdana - Italic', 'I', 'verdanai.php');
			$this->AddFont('Verdana - Bold Italic', 'BI', 'verdanaz.php');
*/
			// Other Properties
			$this->SetTitle("Laporan Keuangan Masjid");
			$this->SetSubject("Laporan Keuangan Masjid");
			$this->SetAuthor("Supported by Masjid Astra");
			$this->SetCreator("Supported by Masjid Astra");
		}

		public function GetWidth() {
			if ($this->DefOrientation == 'P')
				return $this->format[0];
			else
				return $this->format[1];
		}

		public function GetHeight() {
			if ($this->DefOrientation == 'P')
				return $this->format[1];
			else
				return $this->format[0];
		}

		public function Header() {
			if (is_array($this->arrCols)) {
				$this->SetFillColor(self::fillColor);
				$this->SetTextColor(self::textColor);
			}

			if ($this->PageNo() == 1) {
				if (!empty($this->locLogo)) {
					$this->Image($this->locLogo, $this->lMargin, $this->tMargin, $this->widthLogo, $this->heightLogo);
					$this->Ln($this->rowHeight * 2);
				}
				$this->SetFont('Helvetica', 'B', 11);
				if (!is_null($this->mainTitle)) {
					$this->MultiCell(0, $this->rowHeight, $this->mainTitle, 0, 'C');
					$this->Ln();
				}
				$this->SetFont('Helvetica', 'B', 9);
				if (count($this->arrTitle) > 0) {
					$maxLength = 0;
					foreach ($this->arrTitle as $caption => $content) {
						$maxLength = max($maxLength, $this->GetStringWidth($caption));
					}
					// Add 5 mm more...
					$maxLength += 5;
					foreach ($this->arrTitle as $caption => $content) {
						$this->Cell($maxLength, $this->rowHeight, $caption);
						$this->Cell(10, $this->rowHeight, ':');
						$this->Cell(0, $this->rowHeight, $content);
						$this->Ln();
					}
				}
				if ($this->flagBP) {
					$this->Image("{$this->instance->getImgFolder()}/logo.jpg", ($this->lMargin + 5), ($this->tMargin + 5), 25, 25);
					$this->Cell(165, 32, "{$this->instance->getCompanyName()}\nBUKTI PEMBUKUAN (BP)", 1, 0, 'C');
					$this->Cell(55, 6, 'NOMOR BP', 1, 0, 'C');
					$this->Cell(55, 6, 'BP DIBUAT OLEH :', 1, 1, 'C');

					$this->SetX(180);

					$this->Cell(55, 20, $this->noBP, 1, 0, 'C');
					$this->Cell(55, 20, '', 1, 1, 'C');

					$this->SetX(180);

					$this->Cell(55, 6, $this->tglBP, 1, 0, 'C');
					$this->Cell(55, 6, $this->tglBP, 1, 1, 'C');
				}
			}

			$this->top = $this->GetY();
			$this->left = $this->GetX();

			if (is_array($this->arrCols)) {				

				$this->SetFont('Helvetica', 'B', 8);

				$max = count($this->arrCols);
				for ($i = 0; $i < $max; $i++) {
					if ($i > 0) 
						$flagNext = true;
					else
						$flagNext = false;	
					$this->SetHeader($this->arrCols[$i], $i, $flagNext);
				}

				/*********** BugFixed : Akibat penambahan bugfixed baris lebih dari 2 maka diperlukan kode ini ***********/
				$this->SetY($this->top);
				$this->Ln($this->rowHeight * $this->numSpans);
				/*********** BugFixed : Akibat penambahan bugfixed baris lebih dari 2 maka diperlukan kode ini ***********/

				for ($i = 0; $i < $this->numFields; $i++) {
					$this->Cell($this->arrWidth[$i], $this->rowHeight, $this->arrLabel[$i], 'TBLR', 0, 'C', ($this->flagBP ? 0 : 1));
				}
				$this->Ln();
				$y = $this->GetY();
				$this->Line($this->left, $y, ($this->left + $this->maxLength), $y);
				$this->SetXY($this->left, $y);
			}
		}

		public function SetNoHeader() {
			unset($this->arrCols);
		}

		public function Footer() {
			if ($this->flagFooter) {
				/*
				if (is_array($this->arrCols))
					$this->Line(($this->left + $this->maxLength), $this->top, ($this->left + $this->maxLength), ($this->top + ($this->rowHeight * ($this->numSpans + 1))));
				*/
				
				$this->SetY(self::footerHeight);
				$this->SetFont(self::footerFont, 'I', self::footerFontSize);
				$this->Cell(0, $this->rowHeight, self::footerPage . $this->PageNo() . '/{nb}', 0, 0, 'R');
			}
		}

		/**
		*
		*	Cell
		*
		*	These methods allow multiline text with the delimiter "\n".
		*	If the cell contains a single line and its length exceeds the size of the cell, the text will be compressed to fit.
		*
		*	$w			: Width of cell.
		*	$h			: Height of cell.
		*	$border		:
		*	$ln			:
		*	$align		:
		*	$fill		:
		*	$link		:
		*
		*/

		public function Cell($w, $h = 0, $txt = '', $border = 0, $ln = 0, $align = '', $fill = 0, $link = '') {
			//Output a cell
			$k = $this->k;
			if ((($this->y + $h) > $this->PageBreakTrigger) && ((!$this->InFooter) && ($this->AcceptPageBreak()))) {
				$x = $this->x;
				$ws = $this->ws;
				if ($ws > 0) {
					$this->ws = 0;
					$this->_out('0 Tw');
				}
				$this->AddPage($this->CurOrientation);
				$this->x = $x;
				if ($ws > 0) {
					$this->ws = $ws;
					$this->_out(sprintf('%.3f Tw', $ws * $k));
				}
			}
			if ($w == 0)
				$w = $this->w-$this->rMargin - $this->x;
			$s = '';
			// begin change Cell function 12.08.2003 
			if (($fill == 1) || ($border > 0)) {
				if ($fill == 1)
					$op = ($border > 0) ? 'B' : 'f';
				else
					$op = 'S';
				if ($border > 1) {
					$s = sprintf(' q %.2f w %.2f %.2f %.2f %.2f re %s Q ', $border,
						$this->x * $k, ($this->h-$this->y) * $k, $w * $k, -$h * $k, $op);
				} else
					$s = sprintf('%.2f %.2f %.2f %.2f re %s ', $this->x * $k, ($this->h-$this->y) * $k, $w * $k, -$h * $k, $op);
			}
			if (is_string($border)) {
				$x = $this->x;
				$y = $this->y;
				if (is_int(strpos($border, 'L')))
					$s .= sprintf('%.2f %.2f m %.2f %.2f l S ', $x * $k, ($this->h - $y) * $k, $x * $k, ($this->h - ($y + $h)) * $k);
				else if (is_int(strpos($border, 'l')))
					$s .= sprintf('q 2 w %.2f %.2f m %.2f %.2f l S Q ', $x * $k, ($this->h - $y) * $k, $x * $k, ($this->h - ($y + $h)) * $k);
					
				if (is_int(strpos($border, 'T')))
					$s .= sprintf('%.2f %.2f m %.2f %.2f l S ', $x * $k, ($this->h - $y) * $k, ($x + $w) * $k, ($this->h - $y) * $k);
				else if (is_int(strpos($border, 't')))
					$s .= sprintf('q 2 w %.2f %.2f m %.2f %.2f l S Q ', $x * $k, ($this->h - $y) * $k, ($x + $w) * $k, ($this->h - $y) * $k);
				
				if (is_int(strpos($border, 'R')))
					$s .= sprintf('%.2f %.2f m %.2f %.2f l S ', ($x + $w) * $k, ($this->h - $y) * $k, ($x + $w) * $k, ($this->h - ($y + $h)) * $k);
				else if (is_int(strpos($border, 'r')))
					$s .= sprintf('q 2 w %.2f %.2f m %.2f %.2f l S Q ', ($x + $w) * $k, ($this->h - $y) * $k, ($x + $w) * $k, ($this->h - ($y + $h)) * $k);
				
				if (is_int(strpos($border, 'B')))
					$s .= sprintf('%.2f %.2f m %.2f %.2f l S ', $x * $k, ($this->h - ($y + $h)) * $k, ($x + $w) * $k, ($this->h - ($y + $h)) * $k);
				else if (is_int(strpos($border, 'b')))
					$s .= sprintf('q 2 w %.2f %.2f m %.2f %.2f l S Q ', $x * $k, ($this->h - ($y + $h)) * $k, ($x + $w) * $k, ($this->h - ($y + $h)) * $k);
			}
			if (trim($txt) != '') {
				$cr = substr_count($txt, "\n");
				if ($cr > 0) { // Multi line
					$txts = explode("\n", $txt);
					$lines = count($txts);
					//$dy=($h-2*$this->cMargin)/$lines;
					for ($l = 0; $l < $lines; $l++) {
						$txt = $txts[$l];
						$w_txt = $this->GetStringWidth($txt);
						if ($align == 'R')
							$dx = $w - $w_txt - $this->cMargin;
						else if ($align == 'C')
							$dx = ($w - $w_txt) / 2;
						else
							$dx = $this->cMargin;

						$txt = str_replace(')', '\\)', str_replace('(', '\\(', str_replace('\\', '\\\\', $txt)));
						if ($this->ColorFlag)
							$s .= 'q ' . $this->TextColor . ' ';
						$s .= sprintf('BT %.2f %.2f Td (%s) Tj ET ',
							($this->x + $dx) * $k,
							($this->h - ($this->y + .5 * $h + (.7 + $l - $lines / 2) * $this->FontSize)) * $k,
							$txt);
						if ($this->underline)
							$s .= ' ' . $this->_dounderline($this->x + $dx, $this->y + .5 * $h + .3 * $this->FontSize, $txt);
						if ($this->ColorFlag)
							$s .= ' Q ';
						if ($link)
							$this->Link($this->x + $dx, $this->y + .5 * $h - .5 * $this->FontSize, $w_txt, $this->FontSize, $link);
					}
				} else { // Single line
					$w_txt = $this->GetStringWidth($txt);
					$Tz = 100;
					if ($w_txt > $w - 2 * $this->cMargin) { // Need compression
						$Tz = ($w - 2 * $this->cMargin) / $w_txt * 100;
						$w_txt = $w - 2 * $this->cMargin;
					}
					if ($align =='R')
						$dx = $w - $w_txt - $this->cMargin;
					else if ($align == 'C')
						$dx = ($w - $w_txt) / 2;
					else
						$dx = $this->cMargin;
					$txt = str_replace(')', '\\)', str_replace('(', '\\(', str_replace('\\', '\\\\', $txt)));
					if ($this->ColorFlag)
						$s .= 'q ' . $this->TextColor . ' ';
					$s .= sprintf('q BT %.2f %.2f Td %.2f Tz (%s) Tj ET Q ',
								($this->x + $dx) * $k,
								($this->h - ($this->y + .5 * $h + .3 * $this->FontSize)) * $k,
								$Tz, $txt);
					if ($this->underline)
						$s .= ' ' . $this->_dounderline($this->x + $dx, $this->y + .5 * $h + .3 * $this->FontSize, $txt);
					if ($this->ColorFlag)
						$s .= ' Q ';
					if ($link)
						$this->Link($this->x + $dx, $this->y + .5 * $h - .5 * $this->FontSize , $w_txt, $this->FontSize, $link);
				}
			}
			// end change Cell function 12.08.2003
			if ($s)
				$this->_out($s);
			$this->lasth = $h;
			if ($ln > 0) {
				//Go to next line
				$this->y += $h;
				if ($ln == 1)
					$this->x = $this->lMargin;
			} else
				$this->x += $w;
		}

		public function VCell($w, $h = 0, $txt = '', $border = 0, $ln = 0, $align = '', $fill = 0) {
			//Output a cell
			$k = $this->k;
			if ($this->y + $h > $this->PageBreakTrigger and !$this->InFooter and $this->AcceptPageBreak()) {
				$x = $this->x;
				$ws = $this->ws;
				if ($ws > 0) {
					$this->ws = 0;
					$this->_out('0 Tw');
				}
				$this->AddPage($this->CurOrientation);
				$this->x = $x;
				if ($ws > 0) {
					$this->ws = $ws;
					$this->_out(sprintf('%.3f Tw', $ws * $k));
				}
			}
			if ($w == 0)
				$w = $this->w - $this->rMargin - $this->x;
			$s = '';
			// begin change Cell function 
			if ($fill == 1 or $border > 0) {
				if ($fill == 1)
					$op = ($border > 0) ? 'B' : 'f';
				else
					$op = 'S';
				if ($border > 1) {
					$s = sprintf(' q %.2f w %.2f %.2f %.2f %.2f re %s Q ', $border,
								$this->x * $k, ($this->h - $this->y) * $k, $w * $k, -$h * $k, $op);
				} else
					$s = sprintf('%.2f %.2f %.2f %.2f re %s ', $this->x * $k, ($this->h - $this->y) * $k, $w * $k, -$h * $k, $op);
			}
			if (is_string($border)) {
				$x = $this->x;
				$y = $this->y;
				if (is_int(strpos($border, 'L')))
					$s .= sprintf('%.2f %.2f m %.2f %.2f l S ', $x * $k, ($this->h - $y) * $k, $x * $k, ($this->h - ($y + $h)) * $k);
				else if (is_int(strpos($border, 'l')))
					$s .= sprintf('q 2 w %.2f %.2f m %.2f %.2f l S Q ', $x * $k, ($this->h - $y) * $k, $x * $k, ($this->h - ($y + $h)) * $k);
					
				if (is_int(strpos($border, 'T')))
					$s .= sprintf('%.2f %.2f m %.2f %.2f l S ', $x * $k, ($this->h - $y) * $k, ($x + $w) * $k, ($this->h - $y) * $k);
				else if (is_int(strpos($border, 't')))
					$s .= sprintf('q 2 w %.2f %.2f m %.2f %.2f l S Q ', $x * $k, ($this->h - $y) * $k, ($x + $w) * $k, ($this->h - $y) * $k);
				
				if (is_int(strpos($border, 'R')))
					$s .= sprintf('%.2f %.2f m %.2f %.2f l S ', ($x + $w) * $k, ($this->h - $y) * $k, ($x + $w) * $k, ($this->h - ($y + $h)) * $k);
				else if (is_int(strpos($border, 'r')))
					$s .= sprintf('q 2 w %.2f %.2f m %.2f %.2f l S Q ', ($x + $w) * $k, ($this->h - $y) * $k, ($x + $w) * $k, ($this->h - ($y + $h)) * $k);
				
				if (is_int(strpos($border, 'B')))
					$s .= sprintf('%.2f %.2f m %.2f %.2f l S ', $x * $k, ($this->h - ($y + $h)) * $k, ($x + $w) * $k, ($this->h - ($y + $h)) * $k);
				else if (is_int(strpos($border, 'b')))
					$s .= sprintf('q 2 w %.2f %.2f m %.2f %.2f l S Q ', $x * $k, ($this->h - ($y + $h)) * $k, ($x + $w) * $k, ($this->h - ($y + $h)) * $k);
			}
			if (trim($txt) != '') {
				$cr = substr_count($txt, "\n");
				if ($cr > 0) { // Multi line
					$txts = explode("\n", $txt);
					$lines = count($txts);
					for ($l = 0; $l < $lines; $l++) {
						$txt = $txts[$l];
						$w_txt = $this->GetStringWidth($txt);
						if ($align == 'U')
							$dy = $this->cMargin + $w_txt;
						else if ($align == 'D')
							$dy = $h - $this->cMargin;
						else
							$dy = ($h + $w_txt) / 2;
						$txt = str_replace(')', '\\)', str_replace('(', '\\(', str_replace('\\', '\\\\', $txt)));
						if ($this->ColorFlag)
							$s .= 'q ' . $this->TextColor . ' ';
						$s .= sprintf('BT 0 1 -1 0 %.2f %.2f Tm (%s) Tj ET ',
							($this->x + .5 * $w + (.7 + $l - $lines / 2) * $this->FontSize) * $k,
							($this->h - ($this->y + $dy)) * $k, $txt);
						if ($this->ColorFlag)
							$s .= ' Q ';
					}
				} else { // Single line
					$w_txt = $this->GetStringWidth($txt);
					$Tz = 100;
					if ($w_txt > $h - 2 * $this->cMargin) {
						$Tz = ($h - 2 * $this->cMargin) / $w_txt * 100;
						$w_txt = $h - 2 * $this->cMargin;
					}
					if ($align == 'U')
						$dy = $this->cMargin + $w_txt;
					else if ($align == 'D')
						$dy = $h - $this->cMargin;
					else
						$dy = ($h + $w_txt) / 2;
					$txt = str_replace(')', '\\)', str_replace('(', '\\(',str_replace('\\', '\\\\', $txt)));
					if ($this->ColorFlag)
						$s .= 'q ' . $this->TextColor . ' ';
					$s .= sprintf('q BT 0 1 -1 0 %.2f %.2f Tm %.2f Tz (%s) Tj ET Q ',
								($this->x + .5 * $w + .3 * $this->FontSize) * $k,
								($this->h - ($this->y + $dy)) * $k, $Tz, $txt);
					if ($this->ColorFlag)
						$s .= ' Q ';
				}
			}
			// end change Cell function 
			if ($s)
				$this->_out($s);
			$this->lasth = $h;
			if ($ln > 0) {
				//Go to next line
				$this->y += $h;
				if ($ln == 1)
					$this->x = $this->lMargin;
			} else
				$this->x += $w;
		}

		public function MultiCellBltArray($w, $h, $blt_array, $border = 0, $align = 'J', $fill = 0) {
			if (!is_array($blt_array)) {
				die('MultiCellBltArray requires an array with the following keys: bullet, margin, text, indent, spacer');
				exit;
			}
					
			//Save x
			$bak_x = $this->x;
			
			for ($i = 0; $i < sizeof($blt_array['text']); $i++) {
				//Get bullet width including margin
				$blt_width = $this->GetStringWidth($blt_array['bullet'] . $blt_array['margin']) + $this->cMargin * 2;
				
				// SetX
				$this->SetX($bak_x);
				
				//Output indent
				if ($blt_array['indent'] > 0)
					$this->Cell($blt_array['indent']);
				
				//Output bullet
				$this->Cell($blt_width, $h, $blt_array['bullet'] . $blt_array['margin'], 0, '', $fill);
				
				//Output text
				$this->MultiCell($w - $blt_width, $h, $blt_array['text'][$i], $border, $align, $fill);
				
				//Insert a spacer between items if not the last item
				if ($i != sizeof($blt_array['text']) - 1)
					$this->Ln($blt_array['spacer']);
				
				//Increment bullet if it's a number
				if (is_numeric($blt_array['bullet']))
					$blt_array['bullet']++;
			}
		
			//Restore x
			$this->x = $bak_x;
		}

		public function SetRowHeight($h) {
			// Set the height of each line row
			$this->rowHeight = $h;
		}

		public function InsertRow(&$data) {
			$this->SetFont('Helvetica', '', 8);

			//Calculate the height of the row
			$nb = 0;
			for ($i = 0; $i < $this->numFields; $i++) {
				if (!isset($data[$i]))
					$data[$i] = '';
				$nb = max($nb, $this->NbLines($this->arrWidth[$i], $data[$i]));
			}
			$h = $this->rowHeight * $nb;

			//Issue a page break first if needed
			$this->CheckPageBreak($h);
			
			//Draw the cells of the row
			for ($i = 0; $i < count($data); $i++) {
				$w = $this->arrWidth[$i];
				$a = isset($this->arrAlign[$i]) ? $this->arrAlign[$i] : 'L';
				//Save the current position
				$x = $this->GetX();
				$y = $this->GetY();
				//Draw the border
				$this->Rect($x, $y, $w, $h);
				//Print the text
				$this->MultiCell($w, $this->rowHeight, $data[$i], 0, $a);
				//Put the position to the right of the cell
				$this->SetXY($x + $w, $y);
			}
			//Go to the next line
			$this->Ln($h);
		}

		public function ShowPDF($name = 'undefined', $plain = false) {
			if (is_dir($this->tempFolder)) {
				$pdfFile = $this->tempFolder . "/tmp_{$name}.pdf";
				$this->Output($pdfFile);
				$this->instance->load->helper('url');
				$urlFile = site_url("system/application/_tmp/tmp_{$name}.pdf");
				if ($plain) {
					echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html><head><script language='javascript' type='text/javascript'>document.location='{$urlFile}';</script></head></html>";
				} else {
					if (is_null($this->paperFormat))
						$strFormat = "SEMUA JENIS KERTAS TIPE A";
					else if (is_array($this->paperFormat))
						$strFormat = "LEBAR : {$this->paperFormat[0]}mm/TINGGI : {$this->paperFormat[1]}mm";
					else
						$strFormat = strtoupper($this->paperFormat);
					

					if ($this->DefOrientation == 'P')
						$strOrientation = 'PORTRAIT';
					else
						$strOrientation = 'LANDSCAPE';
				
					$strHTML =	"
								<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
								<html>
									<head>
										<title>LAPORAN</title>
										<style type='text/css'>
											body {
												margin: 0px;
												font-family: tahoma, verdana, arial;
												font-size: 8pt;					
												background-color: #ECE9D8;
											}

											div {
												text-align: right;
												font-weight: bold;
												padding: 2px 2px 1px 2px;
												border-top: 1px solid #FFFFFF;
												border-bottom: 1px solid #ACA899;
												border-left: 1px solid #FFFFFF;
												border-right: 1px solid #ACA899;
											}

											iframe {
												width: 100%;
												border-top: 1px solid #FFFFFF;
												border-bottom: 1px solid #ACA899;
												border-left: 1px solid #FFFFFF;
												border-right: 1px solid #ACA899;
											}
										</style>
									</head>
									<body scroll='no'>
										<div id='top'>UKURAN KERTAS : {$strFormat}, ORIENTASI : {$strOrientation}</div>
										<iframe id='content' src='{$urlFile}'>
											Halaman ini membutuhkan browser yang mendukung inline frame.
										</iframe>
										<div id='bot'>{$this->instance->getAppName()}</div>
										<script language='javascript' type='text/javascript'>
											<!--
											var topElm, contentElm, botElm;

											window.onload = function(e) {											
												topElm = document.getElementById('top');
												contentElm = document.getElementById('content');
												botElm = document.getElementById('bot');
												
												resizeLayout(e);
											}
											
											window.onresize = function(e) {
												resizeLayout(e);
											}
											
											function resizeLayout(e) {
												if (typeof(e) != 'undefined') {
													// Firefox
													contentElm.style.height = innerHeight - topElm.offsetHeight - botElm.offsetHeight - 18 + 'px';
												} else {
													// IE
													contentElm.style.height = document.documentElement.clientHeight - topElm.offsetHeight - botElm.offsetHeight - 4 + 'px';	
												}
											}
											//-->
										</script>
									</body>
								</html>
								";
					echo $strHTML;
				}
				
			} else
				$this->Error('Invalid path for temporary folder');
		}

		public function SetLogo($fileLogo = '', $width = 0, $height = 0) {
			if (file_exists($fileLogo)) {
				$this->locLogo = $fileLogo;
				$this->widthLogo = $width;
				$this->heightLogo = $height;
			} else
				$this->Error("{$fileLogo} is invalid! Please use valid image file location for setting logo image");
		}
		
		public function SetLogoWidth($size) {
			$this->widthLogo = $size;	
		}
		
		public function SetLogoHeight($size) {
			$this->heightLogo = $size;			
		}

		public function SetReportTitle($caption, $content) {
			$this->arrTitle[$caption] = $content;
		}

		public function SetReportMainTitle($content) {
			if (empty($content))
				$this->Error('Please don\'t use empty string as main title');
			else
				$this->mainTitle = $content;
		}

		public function SetBP($no, $tgl) {
			$this->flagBP = true;
			$this->noBP = $no;
			$this->tglBP = $tgl;
		}

		public function SetFooter($flag = true) {
			if (is_bool($flag))
				$this->flagFooter = $flag;
			else
				$this->Error('Please use boolean type for setting footer flag');
		}

		public function CircularText($x, $y, $r, $text, $align = "top", $kerning = 120, $fontwidth = 100) {
			$kerning /= 100;
			$fontwidth /= 100;		
			if ($kerning == 0) $this->Error('Please use values unequal to zero for kerning');
			if ($fontwidth == 0) $this->Error('Please use values unequal to zero for font width');		
			//get width of every letter
			for ($i = 0; $i < strlen($text); $i++) {
				$w[$i] = $this->GetStringWidth($text[$i]);
				$w[$i] *= $kerning * $fontwidth;
				//total width of string
				$t += $w[$i];
			}
			//circumference
			$u = ($r * 2) * M_PI;
			//total width of string in degrees
			$d = ($t / $u) * 360;
			$this->StartTransform();
			// rotate matrix for the first letter to center the text
			// (half of total degrees)
			if ($align == 'top') {
				$this->Rotate($d / 2, $x, $y);
			} else {
				$this->Rotate(-$d / 2, $x, $y);
			}
			//run through the string
			for ($i = 0; $i < strlen($text); $i++) {
				if ($align == 'top') {
					//rotate matrix half of the width of current letter + half of the width of preceding letter
					if ($i == 0) {
						$this->Rotate(-(($w[$i] / 2) / $u) * 360, $x, $y);
					} else {
						$this->Rotate(-(($w[$i] / 2 + $w[$i - 1] / 2) / $u) * 360, $x, $y);
					}
					if ($fontwidth != 1) {
						$this->StartTransform();
						$this->ScaleX($fontwidth * 100, $x, $y);
					}
					$this->SetXY($x - $w[$i] / 2, $y - $r);
				} else {
					//rotate matrix half of the width of current letter + half of the width of preceding letter
					if ($i == 0) {
						$this->Rotate((($w[$i] / 2) / $u) * 360, $x, $y);
					} else {
						$this->Rotate((($w[$i] / 2 + $w[$i - 1] / 2) / $u) * 360, $x, $y);
					}
					if ($fontwidth != 1) {
						$this->StartTransform();
						$this->ScaleX($fontwidth * 100, $x, $y);
					}
					$this->SetXY($x - $w[$i] / 2, $y + $r - ($this->FontSize));
				}
				$this->Cell($w[$i], $this->FontSize, $text[$i], 0, 0, 'C');
				if ($fontwidth != 1) {
					 $this->StopTransform();
				}
			}
			$this->StopTransform();
		}

		/**
		*	Code39 Ext
		*	For creating barcode (code 39 Ext).
		*/
		public function Code39Ext($x, $y, $code, $text = true, $ext = true, $cks = false, $w = 0.4, $h = 20, $wide = true) {

			//Display code
			if ($text) {
				$this->SetFont('Helvetica', '', 9);
				$this->Text($x, $y + $h + 4, $code);
			}

			if ($ext) {
				//Extended encoding
				$code = $this->encode_code39_ext($code);
			} else {
				//Convert to upper case
				$code = strtoupper($code);
				//Check validity
				if (!preg_match('|^[0-9A-Z. $/+%-]*$|', $code))
					$this->Error('Invalid barcode value: ' . $code);
			}

			//Compute checksum
			if ($cks)
				$code .= $this->checksum_code39($code);

			//Add start and stop characters
			$code = '*' . $code . '*';

			//Conversion tables
			$narrow_encoding = array (
				'0' => '101001101101', '1' => '110100101011', '2' => '101100101011',
				'3' => '110110010101', '4' => '101001101011', '5' => '110100110101',
				'6' => '101100110101', '7' => '101001011011', '8' => '110100101101',
				'9' => '101100101101', 'A' => '110101001011', 'B' => '101101001011',
				'C' => '110110100101', 'D' => '101011001011', 'E' => '110101100101',
				'F' => '101101100101', 'G' => '101010011011', 'H' => '110101001101',
				'I' => '101101001101', 'J' => '101011001101', 'K' => '110101010011',
				'L' => '101101010011', 'M' => '110110101001', 'N' => '101011010011',
				'O' => '110101101001', 'P' => '101101101001', 'Q' => '101010110011',
				'R' => '110101011001', 'S' => '101101011001', 'T' => '101011011001',
				'U' => '110010101011', 'V' => '100110101011', 'W' => '110011010101',
				'X' => '100101101011', 'Y' => '110010110101', 'Z' => '100110110101',
				'-' => '100101011011', '.' => '110010101101', ' ' => '100110101101',
				'*' => '100101101101', '$' => '100100100101', '/' => '100100101001',
				'+' => '100101001001', '%' => '101001001001' );

			$wide_encoding = array (
				'0' => '101000111011101', '1' => '111010001010111', '2' => '101110001010111',
				'3' => '111011100010101', '4' => '101000111010111', '5' => '111010001110101',
				'6' => '101110001110101', '7' => '101000101110111', '8' => '111010001011101',
				'9' => '101110001011101', 'A' => '111010100010111', 'B' => '101110100010111',
				'C' => '111011101000101', 'D' => '101011100010111', 'E' => '111010111000101',
				'F' => '101110111000101', 'G' => '101010001110111', 'H' => '111010100011101',
				'I' => '101110100011101', 'J' => '101011100011101', 'K' => '111010101000111',
				'L' => '101110101000111', 'M' => '111011101010001', 'N' => '101011101000111',
				'O' => '111010111010001', 'P' => '101110111010001', 'Q' => '101010111000111',
				'R' => '111010101110001', 'S' => '101110101110001', 'T' => '101011101110001',
				'U' => '111000101010111', 'V' => '100011101010111', 'W' => '111000111010101',
				'X' => '100010111010111', 'Y' => '111000101110101', 'Z' => '100011101110101',
				'-' => '100010101110111', '.' => '111000101011101', ' ' => '100011101011101',
				'*' => '100010111011101', '$' => '100010001000101', '/' => '100010001010001',
				'+' => '100010100010001', '%' => '101000100010001');

			$encoding = $wide ? $wide_encoding : $narrow_encoding;

			//Inter-character spacing
			$gap = ($w > 0.29) ? '00' : '0';

			//Convert to bars
			$encode = '';
			for ($i = 0; $i < strlen($code); $i++)
				$encode .= $encoding[$code{$i}] . $gap;

			//Draw bars
			$this->draw_code39($encode, $x, $y, $w, $h);
		}

		/**
		*	Code39
		*	For creating barcode (Code39).
		*/
		function Code39($xpos, $ypos, $code, $baseline=0.5, $height=5){

			$wide = $baseline;
			$narrow = $baseline / 3 ;
			$gap = $narrow;

			$barChar['0'] = 'nnnwwnwnn';
			$barChar['1'] = 'wnnwnnnnw';
			$barChar['2'] = 'nnwwnnnnw';
			$barChar['3'] = 'wnwwnnnnn';
			$barChar['4'] = 'nnnwwnnnw';
			$barChar['5'] = 'wnnwwnnnn';
			$barChar['6'] = 'nnwwwnnnn';
			$barChar['7'] = 'nnnwnnwnw';
			$barChar['8'] = 'wnnwnnwnn';
			$barChar['9'] = 'nnwwnnwnn';
			$barChar['A'] = 'wnnnnwnnw';
			$barChar['B'] = 'nnwnnwnnw';
			$barChar['C'] = 'wnwnnwnnn';
			$barChar['D'] = 'nnnnwwnnw';
			$barChar['E'] = 'wnnnwwnnn';
			$barChar['F'] = 'nnwnwwnnn';
			$barChar['G'] = 'nnnnnwwnw';
			$barChar['H'] = 'wnnnnwwnn';
			$barChar['I'] = 'nnwnnwwnn';
			$barChar['J'] = 'nnnnwwwnn';
			$barChar['K'] = 'wnnnnnnww';
			$barChar['L'] = 'nnwnnnnww';
			$barChar['M'] = 'wnwnnnnwn';
			$barChar['N'] = 'nnnnwnnww';
			$barChar['O'] = 'wnnnwnnwn';
			$barChar['P'] = 'nnwnwnnwn';
			$barChar['Q'] = 'nnnnnnwww';
			$barChar['R'] = 'wnnnnnwwn';
			$barChar['S'] = 'nnwnnnwwn';
			$barChar['T'] = 'nnnnwnwwn';
			$barChar['U'] = 'wwnnnnnnw';
			$barChar['V'] = 'nwwnnnnnw';
			$barChar['W'] = 'wwwnnnnnn';
			$barChar['X'] = 'nwnnwnnnw';
			$barChar['Y'] = 'wwnnwnnnn';
			$barChar['Z'] = 'nwwnwnnnn';
			$barChar['-'] = 'nwnnnnwnw';
			$barChar['.'] = 'wwnnnnwnn';
			$barChar[' '] = 'nwwnnnwnn';
			$barChar['*'] = 'nwnnwnwnn';
			$barChar['$'] = 'nwnwnwnnn';
			$barChar['/'] = 'nwnwnnnwn';
			$barChar['+'] = 'nwnnnwnwn';
			$barChar['%'] = 'nnnwnwnwn';

			$this->SetFont('Arial','',10);
			$this->Text($xpos, $ypos + $height + 4, $code);
			$this->SetFillColor(0);

			$code = '*'.strtoupper($code).'*';
			for($i=0; $i<strlen($code); $i++){
				$char = $code{$i};
				if(!isset($barChar[$char])){
					$this->Error('Invalid character in barcode: '.$char);
				}
				$seq = $barChar[$char];
				for($bar=0; $bar<9; $bar++){
					if($seq{$bar} == 'n'){
						$lineWidth = $narrow;
					}else{
						$lineWidth = $wide;
					}
					if($bar % 2 == 0){
						$this->Rect($xpos, $ypos, $lineWidth, $height, 'F');
					}
					$xpos += $lineWidth;
				}
				$xpos += $gap;
			}
		}

		/**
		*	Codabar
		*	For creating barcode (Codabar).
		*/
		function Codabar($xpos, $ypos, $code, $start='A',$end='A', $basewidth=0.35, $height=16) {
			$barChar = array (
				'0' => array (6.5, 10.4, 6.5, 10.4, 6.5, 24.3, 17.9),
				'1' => array (6.5, 10.4, 6.5, 10.4, 17.9, 24.3, 6.5),
				'2' => array (6.5, 10.0, 6.5, 24.4, 6.5, 10.0, 18.6),
				'3' => array (17.9, 24.3, 6.5, 10.4, 6.5, 10.4, 6.5),
				'4' => array (6.5, 10.4, 17.9, 10.4, 6.5, 24.3, 6.5),
				'5' => array (17.9,    10.4, 6.5, 10.4, 6.5, 24.3, 6.5),
				'6' => array (6.5, 24.3, 6.5, 10.4, 6.5, 10.4, 17.9),
				'7' => array (6.5, 24.3, 6.5, 10.4, 17.9, 10.4, 6.5),
				'8' => array (6.5, 24.3, 17.9, 10.4, 6.5, 10.4, 6.5),
				'9' => array (18.6, 10.0, 6.5, 24.4, 6.5, 10.0, 6.5),
				'$' => array (6.5, 10.0, 18.6, 24.4, 6.5, 10.0, 6.5),
				'-' => array (6.5, 10.0, 6.5, 24.4, 18.6, 10.0, 6.5),
				':' => array (16.7, 9.3, 6.5, 9.3, 16.7, 9.3, 14.7),
				'/' => array (14.7, 9.3, 16.7, 9.3, 6.5, 9.3, 16.7),
				'.' => array (13.6, 10.1, 14.9, 10.1, 17.2, 10.1, 6.5),
				'+' => array (6.5, 10.1, 17.2, 10.1, 14.9, 10.1, 13.6),
				'A' => array (6.5, 8.0, 19.6, 19.4, 6.5, 16.1, 6.5),
				'T' => array (6.5, 8.0, 19.6, 19.4, 6.5, 16.1, 6.5),
				'B' => array (6.5, 16.1, 6.5, 19.4, 6.5, 8.0, 19.6),
				'N' => array (6.5, 16.1, 6.5, 19.4, 6.5, 8.0, 19.6),
				'C' => array (6.5, 8.0, 6.5, 19.4, 6.5, 16.1, 19.6),
				'*' => array (6.5, 8.0, 6.5, 19.4, 6.5, 16.1, 19.6),
				'D' => array (6.5, 8.0, 6.5, 19.4, 19.6, 16.1, 6.5),
				'E' => array (6.5, 8.0, 6.5, 19.4, 19.6, 16.1, 6.5),
			);
			$this->SetFont('Arial','',13);
			$this->Text($xpos, $ypos + $height + 4, $code);
			$this->SetFillColor(0);
			$code = strtoupper($start.$code.$end);
			for($i=0; $i<strlen($code); $i++){
				$char = $code[$i];
				if(!isset($barChar[$char])){
					$this->Error('Invalid character in barcode: '.$char);
				}
				$seq = $barChar[$char];
				for($bar=0; $bar<7; $bar++){
					$lineWidth = $basewidth*$seq[$bar]/6.5;
					if($bar % 2 == 0){
						$this->Rect($xpos, $ypos, $lineWidth, $height, 'F');
					}
					$xpos += $lineWidth;
				}
				$xpos += $basewidth*10.4/6.5;
			}
		}

		public function SetDash($black = false, $white = false) {
			if (($black) && ($white))
				$s = sprintf('[%.3f %.3f] 0 d', $black * $this->k, $white * $this->k);
			else
				$s = '[] 0 d';
			$this->_out($s);
		}

		public function PieChart($w, $h, $data, $format, $colors = null) {
			$this->SetFont('Courier', '', 9);
			$this->SetLegends($data, $format);

			$XPage = $this->GetX();
			$YPage = $this->GetY();
			$margin = 2;
			$hLegend = 5;
			$radius = min($w - $margin * 4 - $hLegend - $this->wLegend, $h - $margin * 2);
			$radius = floor($radius / 2);
			$XDiag = $XPage + $margin + $radius;
			$YDiag = $YPage + $margin + $radius;
			if ($colors == null) {
				for ($i = 0; $i < $this->NbVal; $i++) {
					$gray = $i * intval(255 / $this->NbVal);
					$colors[$i] = array($gray, $gray, $gray);
				}
			}

			//Sectors
			$this->SetLineWidth(0.2);
			$angleStart = 0;
			$angleEnd = 0;
			$i = 0;
			foreach ($data as $val) {
				$angle = floor(($val * 360) / doubleval($this->sum));
				if ($angle != 0) {
					$angleEnd = $angleStart + $angle;
					$this->SetFillColor($colors[$i][0], $colors[$i][1], $colors[$i][2]);
					$this->Sector($XDiag, $YDiag, $radius, $angleStart, $angleEnd);
					$angleStart += $angle;
				}
				$i++;
			}
			if ($angleEnd != 360) {
				$this->Sector($XDiag, $YDiag, $radius, $angleStart - $angle, 360);
			}

			//Legends
			$this->SetFont('Courier', '', 9);
			$x1 = $XPage + 2 * $radius + 4 * $margin;
			$x2 = $x1 + $hLegend + $margin;
			$y1 = $YDiag - $radius + (2 * $radius - $this->NbVal * ($hLegend + $margin)) / 2;
			for ($i = 0; $i < $this->NbVal; $i++) {
				$this->SetFillColor($colors[$i][0], $colors[$i][1], $colors[$i][2]);
				$this->Rect($x1, $y1, $hLegend, $hLegend, 'DF');
				$this->SetXY($x2, $y1);
				$this->Cell(0, $hLegend, $this->legends[$i]);
				$y1 += $hLegend + $margin;
			}
		}

		public function BarDiagram($w, $h, $data, $format, $color = null, $maxVal = 0, $nbDiv = 4) {
			$this->SetFont('Courier', '', 9);
			$this->SetLegends($data, $format);

			$XPage = $this->GetX();
			$YPage = $this->GetY();
			$margin = 2;
			$YDiag = $YPage + $margin;
			$hDiag = floor($h - $margin * 2);
			$XDiag = $XPage + $margin * 2 + $this->wLegend;
			$lDiag = floor($w - $margin * 3 - $this->wLegend);
			if ($color == null)
				$color = array(155, 155, 155);
			if ($maxVal == 0) {
				$maxVal = max($data);
			}
			$valIndRepere = ceil($maxVal / $nbDiv);
			$maxVal = $valIndRepere * $nbDiv;
			$lRepere = floor($lDiag / $nbDiv);
			$lDiag = $lRepere * $nbDiv;
			$unit = $lDiag / $maxVal;
			$hBar = floor($hDiag / ($this->NbVal + 1));
			$hDiag = $hBar * ($this->NbVal + 1);
			$eBaton = floor($hBar * 80 / 100);

			$this->SetLineWidth(0.2);
			$this->Rect($XDiag, $YDiag, $lDiag, $hDiag);

			$this->SetFont('Courier', '', 9);
			$this->SetFillColor($color[0], $color[1], $color[2]);
			$i = 0;
			foreach ($data as $val) {
				//Bar
				$xval = $XDiag;
				$lval = (int)($val * $unit);
				$yval = $YDiag + ($i + 1) * $hBar - $eBaton / 2;
				$hval = $eBaton;
				$this->Rect($xval, $yval, $lval, $hval, 'DF');
				//Legend
				$this->SetXY(0, $yval);
				$this->Cell($xval - $margin, $hval, $this->legends[$i], 0, 0, 'R');
				$i++;
			}

			//Scales
			for ($i = 0; $i <= $nbDiv; $i++) {
				$xpos = $XDiag + $lRepere * $i;
				$this->Line($xpos, $YDiag, $xpos, $YDiag + $hDiag);
				$val = $i * $valIndRepere;
				$xpos = $XDiag + $lRepere * $i - $this->GetStringWidth($val) / 2;
				$ypos = $YDiag + $hDiag - $margin;
				$this->Text($xpos, $ypos, $val);
			}
		}

		public function Sector($xc, $yc, $r, $a, $b, $style = 'FD', $cw = true, $o = 90) {
			if ($cw) {
				$d = $b;
				$b = $o - $a;
				$a = $o - $d;
			} else {
				$b += $o;
				$a += $o;
			}
			$a = ($a % 360) + 360;
			$b = ($b % 360) + 360;
			if ($a > $b)
				$b += 360;
			$b = $b / 360 * 2 * M_PI;
			$a = $a / 360 * 2 * M_PI;
			$d = $b - $a;
			if ($d == 0 )
				$d = 2 * M_PI;
			$k = $this->k;
			$hp = $this->h;
			if ($style == 'F')
				$op = 'f';
			else if (($style == 'FD') || ($style == 'DF'))
				$op = 'b';
			else
				$op = 's';
			if (sin($d / 2))
				$MyArc = 4 / 3 * (1 - cos($d / 2)) / sin($d / 2) * $r;
			//first put the center
			$this->_out(sprintf('%.2f %.2f m', ($xc) * $k, ($hp - $yc) * $k));
			//put the first point
			$this->_out(sprintf('%.2f %.2f l', ($xc + $r * cos($a)) * $k, (($hp - ($yc - $r * sin($a))) * $k)));
			//draw the arc
			if ($d < M_PI / 2) {
				$this->_Arc($xc + $r * cos($a) + $MyArc * cos(M_PI / 2 + $a),
							$yc - $r * sin($a) - $MyArc * sin(M_PI / 2 + $a),
							$xc + $r * cos($b) + $MyArc * cos($b - M_PI / 2),
							$yc - $r * sin($b) - $MyArc * sin($b - M_PI / 2),
							$xc + $r * cos($b),
							$yc - $r * sin($b)
							);
			} else {
				$b = $a + $d / 4;
				$MyArc = 4 / 3 * (1 - cos($d / 8)) / sin($d / 8) * $r;
				$this->_Arc($xc + $r * cos($a) + $MyArc * cos(M_PI / 2 + $a),
							$yc - $r * sin($a) - $MyArc * sin(M_PI / 2 + $a),
							$xc + $r * cos($b) + $MyArc * cos($b - M_PI / 2),
							$yc - $r * sin($b)- $MyArc * sin($b - M_PI / 2),
							$xc + $r * cos($b),
							$yc - $r * sin($b)
							);
				$a = $b;
				$b = $a + $d / 4;
				$this->_Arc($xc + $r * cos($a) + $MyArc * cos(M_PI / 2 + $a),
							$yc - $r * sin($a) - $MyArc * sin(M_PI / 2 + $a),
							$xc + $r * cos($b) + $MyArc * cos($b - M_PI / 2),
							$yc - $r * sin($b) - $MyArc * sin($b - M_PI / 2),
							$xc + $r * cos($b),
							$yc - $r * sin($b)
							);
				$a = $b;
				$b = $a + $d / 4;
				$this->_Arc($xc + $r * cos($a) + $MyArc * cos(M_PI / 2 + $a),
							$yc - $r * sin($a) - $MyArc * sin(M_PI / 2 + $a),
							$xc + $r * cos($b) + $MyArc * cos($b - M_PI / 2),
							$yc - $r * sin($b) - $MyArc * sin($b - M_PI / 2),
							$xc + $r * cos($b),
							$yc - $r * sin($b)
							);
				$a = $b;
				$b = $a + $d / 4;
				$this->_Arc($xc + $r * cos($a) + $MyArc * cos(M_PI / 2 + $a),
							$yc - $r * sin($a) - $MyArc * sin(M_PI / 2 + $a),
							$xc + $r * cos($b) + $MyArc * cos($b - M_PI / 2),
							$yc - $r * sin($b) - $MyArc * sin($b - M_PI / 2),
							$xc + $r * cos($b),
							$yc - $r * sin($b)
							);
			}
			//terminate drawing
			$this->_out($op);
		}

		public function RoundedRect($x, $y, $w, $h, $r, $style = '', $angle = '1234') {
			$k = $this->k;
			$hp = $this->h;
			if ($style == 'F')
				$op = 'f';
			else if ($style == 'FD' or $style == 'DF')
				$op = 'B';
			else
				$op = 'S';
			$MyArc = 4 / 3 * (sqrt(2) - 1);
			$this->_out(sprintf('%.2f %.2f m', ($x + $r) * $k, ($hp - $y) * $k));

			$xc = $x + $w - $r;
			$yc = $y + $r;
			$this->_out(sprintf('%.2f %.2f l', $xc * $k, ($hp - $y) * $k));
			if (strpos($angle, '2') === false)
				$this->_out(sprintf('%.2f %.2f l', ($x + $w) * $k, ($hp - $y) * $k));
			else
				$this->_Arc($xc + $r * $MyArc, $yc - $r, $xc + $r, $yc - $r * $MyArc, $xc + $r, $yc);

			$xc = $x + $w - $r;
			$yc = $y + $h - $r;
			$this->_out(sprintf('%.2f %.2f l', ($x + $w) * $k, ($hp - $yc) * $k));
			if (strpos($angle, '3') === false)
				$this->_out(sprintf('%.2f %.2f l', ($x + $w) * $k, ($hp - ($y + $h)) * $k));
			else
				$this->_Arc($xc + $r, $yc + $r * $MyArc, $xc + $r * $MyArc, $yc + $r, $xc, $yc + $r);

			$xc = $x + $r;
			$yc = $y + $h - $r;
			$this->_out(sprintf('%.2f %.2f l', $xc * $k, ($hp - ($y + $h)) * $k));
			if (strpos($angle, '4') === false)
				$this->_out(sprintf('%.2f %.2f l', ($x) * $k, ($hp - ($y + $h)) * $k));
			else
				$this->_Arc($xc - $r * $MyArc, $yc + $r, $xc - $r, $yc + $r * $MyArc, $xc - $r, $yc);

			$xc = $x + $r ;
			$yc = $y + $r;
			$this->_out(sprintf('%.2f %.2f l', ($x) * $k, ($hp - $yc) * $k));
			if (strpos($angle, '1') === false) {
				$this->_out(sprintf('%.2f %.2f l', ($x) * $k, ($hp - $y) * $k));
				$this->_out(sprintf('%.2f %.2f l', ($x + $r) * $k, ($hp - $y) * $k));
			} else
				$this->_Arc($xc - $r, $yc - $r * $MyArc, $xc - $r * $MyArc, $yc - $r, $xc, $yc - $r);
			$this->_out($op);
		}

		public function GetRowHeight() {
			return $this->rowHeight;
		}

		public function GetNumSpans() {
			return $this->numSpans;
		}

		public function _putpages() {
			$nb = $this->page;
			if (!empty($this->AliasNbPages)) {
				//Replace number of pages
				for($n = 1; $n <= $nb; $n++)
					$this->pages[$n] = ($this->compress) ? gzcompress(str_replace($this->AliasNbPages, $nb, gzuncompress($this->pages[$n]))) : str_replace($this->AliasNbPages, $nb, $this->pages[$n]);
			}
			if ($this->DefOrientation == 'P') {
				$wPt = $this->fwPt;
				$hPt = $this->fhPt;
			} else {
				$wPt = $this->fhPt;
				$hPt = $this->fwPt;
			}
			$filter = ($this->compress) ? '/Filter /FlateDecode ' : '';
			for($n = 1; $n <= $nb; $n++) {
				//Page
				$this->_newobj();
				$this->_out('<</Type /Page');
				$this->_out('/Parent 1 0 R');
				if (isset($this->OrientationChanges[$n]))
					$this->_out(sprintf('/MediaBox [0 0 %.2f %.2f]', $hPt, $wPt));
				$this->_out('/Resources 2 0 R');
				if (isset($this->PageLinks[$n])) {
					//Links
					$annots = '/Annots [';
					foreach ($this->PageLinks[$n] as $pl) {
						$rect = sprintf('%.2f %.2f %.2f %.2f', $pl[0], $pl[1], $pl[0] + $pl[2], $pl[1] - $pl[3]);
						$annots .= '<</Type /Annot /Subtype /Link /Rect [' . $rect . '] /Border [0 0 0] ';
						if (is_string($pl[4]))
							$annots .= '/A <</S /URI /URI ' . $this->_textstring($pl[4]) . '>>>>';
						else {
							$l = $this->links[$pl[4]];
							$h = isset($this->OrientationChanges[$l[0]]) ? $wPt : $hPt;
							$annots .= sprintf('/Dest [%d 0 R /XYZ 0 %.2f null]>>', 1 + 2 * $l[0], $h-$l[1] * $this->k);
						}
					}
					$this->_out($annots . ']');
				}
				$this->_out('/Contents ' . ($this->n + 1) . ' 0 R>>');
				$this->_out('endobj');
				//Page content
				$this->_newobj();
				$this->_out('<<' . $filter . '/Length ' . strlen($this->pages[$n]) . '>>');
				$this->_putstream($this->pages[$n]);
				$this->_out('endobj');
			}
			//Pages root
			$this->offsets[1] = strlen($this->buffer);
			$this->_out('1 0 obj');
			$this->_out('<</Type /Pages');
			$kids='/Kids [';
			for ($i = 0; $i < $nb; $i++)
				$kids .= (3 + 2 * $i) . ' 0 R ';
			$this->_out($kids . ']');
			$this->_out('/Count ' . $nb);
			$this->_out(sprintf('/MediaBox [0 0 %.2f %.2f]', $wPt, $hPt));
			$this->_out('>>');
			$this->_out('endobj');
		}

		public function _endpage() {
			//End of page contents
			$this->pages[$this->page] = ($this->compress) ? gzcompress($this->pages[$this->page]) : $this->pages[$this->page];
			$this->state = 1;
		}

		// Public Static methods

		public static function Convert($srcFormat, $desFormat, $value, $type = 'w') {
			$srcFormat = strtolower(trim($srcFormat));
			$desFormat = strtolower(trim($desFormat));
			$type = strtolower(trim($type));

			$arrRatio = array();

			/**
			*	A4		= 210	x 297	mm
			*	A3		= 297	x 420	mm
			*	A2		= 420	x 594	mm
			*	Letter	= 215.9	x 279.4 mm
			*	Legal	= 215.9	x 355.6	mm
			*/

			$arrRatio['a4']['a4']['w'] = 1;
			$arrRatio['a4']['a4']['h'] = 1;

			$arrRatio['a4']['a3']['w'] = 297 / 210;
			$arrRatio['a4']['a3']['h'] = 420 / 297;

			$arrRatio['a4']['a2']['w'] = 420 / 210;
			$arrRatio['a4']['a2']['h'] = 594 / 297;

			$arrRatio['a4']['letter']['w'] = 215.9 / 210;
			$arrRatio['a4']['letter']['h'] = 279.4 / 297;

			$arrRatio['a4']['legal']['w'] = 215.9 / 210;
			$arrRatio['a4']['legal']['h'] = 355.6 / 297;

			/**
			*	A4		= 210	x 297	mm
			*	A3		= 297	x 420	mm
			*	A2		= 420	x 594	mm
			*	Letter	= 215.9	x 279.4 mm
			*	Legal	= 215.9	x 355.6	mm
			*/

			$arrRatio['a3']['a4']['w'] = 210 / 297;
			$arrRatio['a3']['a4']['h'] = 297 / 420;

			$arrRatio['a3']['a3']['w'] = 1;
			$arrRatio['a3']['a3']['h'] = 1;

			$arrRatio['a3']['a2']['w'] = 420 / 297;
			$arrRatio['a3']['a2']['h'] = 594 / 420;

			$arrRatio['a3']['letter']['w'] = 215.9 / 297;
			$arrRatio['a3']['letter']['h'] = 279.4 / 420;

			$arrRatio['a3']['legal']['w'] = 215.9 / 297;
			$arrRatio['a3']['legal']['h'] = 355.6 / 420;

			/**
			*	A4		= 210	x 297	mm
			*	A3		= 297	x 420	mm
			*	A2		= 420	x 594	mm
			*	Letter	= 215.9	x 279.4 mm
			*	Legal	= 215.9	x 355.6	mm
			*/

			$arrRatio['a2']['a4']['w'] = 210 / 420;
			$arrRatio['a2']['a4']['h'] = 297 / 594;

			$arrRatio['a2']['a3']['w'] = 297 / 420;
			$arrRatio['a2']['a3']['h'] = 420 / 594;

			$arrRatio['a2']['a2']['w'] = 1;
			$arrRatio['a2']['a2']['h'] = 1;

			$arrRatio['a2']['letter']['w'] = 215.9 / 420;
			$arrRatio['a2']['letter']['h'] = 279.4 / 594;

			$arrRatio['a2']['legal']['w'] = 215.9 / 420;
			$arrRatio['a2']['legal']['h'] = 355.6 / 594;

			/**
			*	A4		= 210	x 297	mm
			*	A3		= 297	x 420	mm
			*	A2		= 420	x 594	mm
			*	Letter	= 215.9	x 279.4 mm
			*	Legal	= 215.9	x 355.6	mm
			*/

			$arrRatio['letter']['a4']['w'] = 210 / 215.9;
			$arrRatio['letter']['a4']['h'] = 297 / 279.4;

			$arrRatio['letter']['a3']['w'] = 297 / 215.9;
			$arrRatio['letter']['a3']['h'] = 420 / 279.4;

			$arrRatio['letter']['a2']['w'] = 420 / 215.9;
			$arrRatio['letter']['a2']['h'] = 594 / 279.4;

			$arrRatio['letter']['letter']['w'] = 1;
			$arrRatio['letter']['letter']['h'] = 1;

			$arrRatio['letter']['legal']['w'] = 215.9 / 215.9;
			$arrRatio['letter']['legal']['h'] = 355.6 / 279.4;

			/**
			*	A4		= 210	x 297	mm
			*	A3		= 297	x 420	mm
			*	A2		= 420	x 594	mm
			*	Letter	= 215.9	x 279.4 mm
			*	Legal	= 215.9	x 355.6	mm
			*/

			$arrRatio['legal']['a4']['w'] = 210 / 215.9;
			$arrRatio['legal']['a4']['h'] = 297 / 355.6;

			$arrRatio['legal']['a3']['w'] = 297 / 215.9;
			$arrRatio['legal']['a3']['h'] = 420 / 355.6;

			$arrRatio['legal']['a2']['w'] = 420 / 215.9;
			$arrRatio['legal']['a2']['h'] = 594 / 355.6;

			$arrRatio['legal']['letter']['w'] = 215.9 / 215.9;
			$arrRatio['legal']['letter']['h'] = 279.4 / 355.6;

			$arrRatio['legal']['legal']['w'] = 1;
			$arrRatio['legal']['legal']['h'] = 1;

			if (is_numeric($value)) {
				if (isset($arrRatio[$srcFormat][$desFormat][$type]))
					return ($value * $arrRatio[$srcFormat][$desFormat][$type]);
				else
					return false;
			} else
				return false;
		}
		
		public function NbLines($w, $txt) {
			//Computes the number of lines a MultiCell of width w will take
			$cw =& $this->CurrentFont['cw'];
			if ($w == 0)
				$w = $this->w - $this->rMargin - $this->x;
			$wmax = ($w - 2 * $this->cMargin) * 1000 / $this->FontSize;
			$s = str_replace("\r", '', $txt);
			$nb = strlen($s);
			if (($nb > 0) && ($s[$nb-1] == "\n"))
				$nb--;
			$sep = -1;
			$i = 0;
			$j = 0;
			$l = 0;
			$nl = 1;
			while ($i < $nb) {
				$c = $s[$i];
				
				if ($c == "\n") {
					$i++;
					$sep = -1;
					$j = $i;
					$l = 0;
					$nl++;
					continue;
				}

				if($c == ' ')
					$sep = $i;
				
				$l += $cw[$c];

				if ($l > $wmax) {
					if ($sep == -1) {
						if ($i == $j)
							$i++;
					} else
						$i = $sep + 1;
					$sep = -1;
					$j = $i;
					$l = 0;
					$nl++;
				} else
					$i++;
			}
			return $nl;
		}
		
	}

/* End of file Report.php */
/* Location: ./system/application/libraries/Report.php */