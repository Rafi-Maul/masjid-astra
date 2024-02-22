<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

	class DB {
		private $pdo;
		private $stmt;
		
		private $trans_count;
		private $row_count;
		
		private $hostname;
		private $username;
		private $password;
		private $database;
		private $dbdriver;
		private $pconnect;
		
		private $paging;
		
	
		public function __construct($group = '') {
			log_message('DEBUG', 'DB Class Initialized');
			require(APPPATH . 'config/database' . EXT);
			
			if ((!isset($db)) || (count($db) == 0)) {
				show_error('No database connection settings were found in the database config file.');
			}

			if ((empty($group)) && (!isset($active_group))) {
				show_error('You have specified an invalid database connection group.');
			}

			$group = (empty($group)) ? $active_group : $group;

			$this->hostname = $db[$group]['hostname'];
			$this->username = $db[$group]['username'];
			$this->password = $db[$group]['password'];
			$this->database = $db[$group]['database'];
			$this->dbdriver = $db[$group]['dbdriver'];
			$this->pconnect = $db[$group]['pconnect'];
			
			$dsn  = "{$this->dbdriver}:dbname={$this->database};host={$this->hostname}";
			$user = $this->username;
			$pass = $this->password; 
			
			$attr 							= array();
			if ($this->pconnect)
				$attr[PDO::ATTR_PERSISTENT] = true;
			$attr[PDO::ATTR_CASE] 			= PDO::CASE_LOWER;
			$attr[PDO::ATTR_ERRMODE] 		= PDO::ERRMODE_EXCEPTION; 
			
			$this->pdo = new PDO($dsn, $user, $pass, $attr);
			
			$this->paging = array();	

			$this->trans_count = 0;
		}
		
		public function beginTrans() {
			$this->pdo->beginTransaction();
			$this->trans_count++;
		}
				
		public function endTrans($success = true) {
			if ($this->trans_count > 0) {
				$this->trans_count--;
				
				if ($success)
					$this->pdo->commit();
				else
					$this->pdo->rollBack();
			}
		}
				
		public function &getRows($sql, $params = array()) {		
			log_message('DEBUG', 'DB::getRows Called');
			$this->stmt = $this->pdo->prepare($sql);
			$this->stmt->execute($params);
			$arr_result = $this->stmt->fetchAll();
			return $arr_result;
		}
		
		public function getRow($sql, $params = array()) {
			$this->stmt = $this->pdo->prepare($sql);
			$this->stmt->execute($params);
			$arr_result = $this->stmt->fetch(PDO::FETCH_ASSOC);
			return $arr_result;
		}
		
		public function getField($field, $sql, $params = array()) {
			$this->stmt = $this->pdo->prepare($sql);
			$this->stmt->execute($params);
			$arr_result = $this->stmt->fetch(PDO::FETCH_ASSOC);
			if (isset($arr_result[$field]))
				return $arr_result[$field];
			else
				return false;			
		}
		
		public function exec($sql, $params = array()) {
			$this->stmt = $this->pdo->prepare($sql);
			return $this->stmt->execute($params);		
		}
		
		public function &createPaging($page, $nrows, $sql, $params = array()) {
			$sql_total = "
						 SELECT 
						 COUNT(*) AS total 
						 FROM 
						 ({$sql}) AS s4b_alias
						 ";
			$arr = $this->getRow($sql_total, $params);
			$total_rows = $arr['total'];
			
			$total_pages = max(ceil($total_rows / $nrows), 1);
			$offset      = ($page - 1) * $nrows;
			
			$sql_limit = "{$sql} LIMIT {$nrows} OFFSET {$offset}";
			
			$paging_rows =& $this->getRows($sql_limit, $params);

			$start = ($page - 1) * $nrows;

           	$this->paging['total_rows']  = $total_rows;
			$this->paging['total_pages'] = $total_pages;
			$this->paging['page']        = $page;
			$this->paging['nrows']	     = $nrows;
			$this->paging['start']		 = $start;
			
			return $paging_rows;   
		}
		
		public function &getPaging($index = '') {
			if (empty($index))
				return $this->paging;
			else
				return $this->paging[$index];
		}
		
		public function insert($table, $data) {
			if (empty($data))
				throw new Exception('Data yang akan dimasukan tidak tersedia');
			$str_col = '';
			$str_mrk = '';
			$arr_val = array(); 
			foreach ($data as $col => $val) {
				if (!empty($str_col)) {
					$str_col .= ',';
					$str_mrk .= ',';
				}
				$str_col .= $col;
				$str_mrk .= '?';
				
				if (is_null($val))
					$arr_val[] = null;
				else
					$arr_val[] = trim($val);
			}
			$sql = "
				   INSERT INTO
				   {$table}
				   ({$str_col})
				   VALUES
				   ({$str_mrk})
				   ";
			
			$this->stmt 		= $this->pdo->prepare($sql);
			$return_value		= $this->stmt->execute($arr_val);
			$this->row_count	= $this->stmt->rowCount(); 
			
			return $return_value;
		}
		
		public function update($table, $data, $where = '', $params = array()) {			

			if (empty($data))
				throw new Exception('Data yang akan dirubah tidak tersedia');

			$str_set = '';
			$arr_val = array(); 
			foreach ($data as $col => $val) {
				if (!empty($str_set))
					$str_set .= ',';
				$str_set .= "{$col} = ?";
				if (is_null($val))
					$arr_val[] = null;
				else
					$arr_val[] = trim($val);
			}
			
			$arr_val = array_merge($arr_val, $params);

			if ($where != '') {
				$sql = "
					   UPDATE
					   {$table}
					   SET
					   {$str_set}
					   WHERE
					   {$where}
					   ";
			} else {
				$sql = "
					   UPDATE
					   {$table}
					   SET
					   {$str_set}
					   ";
			}

			$this->stmt 		= $this->pdo->prepare($sql);
			$return_value 		= $this->stmt->execute($arr_val);
			$this->row_count	= $this->stmt->rowCount(); 

			return $return_value; 
		}
		
		public function delete($table, $where = '', $params = array()) {

			if ($where != '') {
				$sql = "
					   DELETE FROM
					   {$table}
					   WHERE
					   {$where}	
					   ";
			} else {
				$sql = "
					   DELETE FROM
					   {$table}
					   ";
			}

			$this->stmt 		= $this->pdo->prepare($sql);
			$return_value		= $this->stmt->execute($params);
			$this->row_count	= $this->stmt->rowCount(); 
			
			return $return_value; 
		}
		
		public function getLastID($name = null) {
			$last_id = $this->pdo->lastInsertId($name);
			return $last_id;
		}
		
		public function resetSequence($table, $field, $name) {
			$sql_maks 	= "SELECT MAX({$field}) AS maks FROM {$table}";
			$arr 		= $this->getRow($sql_maks, array());
			$maks_id 	= $arr['maks'];
			
			if (empty($maks_id)) 
				$sql = "SELECT SETVAL('{$name}', 1, false)";
			else
				$sql = "SELECT SETVAL('{$name}', {$maks_id}, true)";				
			
			$this->pdo->exec($sql);
		}
		
		public function &getDBInfo() {
			$arrInfo = array();
			$arrInfo['hostname'] = $this->hostname;
			$arrInfo['username'] = $this->username;
			$arrInfo['password'] = $this->password;
			$arrInfo['database'] = $this->database;
			return $arrInfo;
		}
		
		/**
		 * Masih berguna ???
		 */		 		
		public function getErrorInfo() {
			$err_info = $this->stmt->errorInfo(); 
			return $err_info[2];
		}
		
		public function getAffected() {
			return $this->row_count;
		}
	}
	
/* End of file DB.php */
/* Location: ./system/application/libraries/DB.php */
