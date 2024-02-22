<?php  
	if (!defined('BASEPATH')) exit('No direct script access allowed');

	if (!function_exists('numFormat')) {
		function numFormat($value, $decimal = 2) {
			return number_format($value, $decimal, ',', '.');
		}
	}

	if (!function_exists('numValue')) {
		function numValue($expression) {
			$pattern = ".";
			$replace = "";
			$result = str_replace($pattern, $replace, $expression);
			$pattern = ",";
			$replace = ".";
			$result = str_replace($pattern, $replace, $result);
			return $result;
		}
	}

/* End of file number.php */
/* Location: ./system/application/helpers/number_helper.php */