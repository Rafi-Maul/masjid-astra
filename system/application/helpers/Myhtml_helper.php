<?php  
	if (!defined('BASEPATH')) exit('No direct script access allowed');

	/**
	 * initTab
	 *
	 * Initialization tab system based on parent menu (sub menu) id.
	 *
	 * @access	public
	 * @param	integer	The id of parent menu (sub menu)
	 */	
	if (!function_exists('initTab')) {
		function initTab($id) {
			$instance =& get_instance();
			$con =& $instance->adodb->getConnection();

			$id_dd_kelompok = $instance->session->userdata('id_dd_kelompok');

			$sql =	"
					SELECT
						a.*
					FROM 
						dd_tab a
						INNER JOIN
						dd_tab_acl b ON a.id_dd_tab = b.id_dd_tab
					WHERE
						a.id_dd_sub_menu = ?
						AND
						b.id_dd_kelompok = ?
					ORDER BY
						a.tab_order
					";

			$stmt =& $con->Prepare($sql);
			$res =& $con->Execute($stmt, array($id, $id_dd_kelompok));
			$arrTab =& $res->GetRows();

			$totalRows = count($arrTab);

			$i = 0;
			$fActive = FALSE;
			foreach ($arrTab as $tab) {
				if ($tab['flag_active'] == 't') $fActive = TRUE;
				if (($i == ($totalRows - 1)) && (!$fActive)) $tab['flag_active'] = 't';
				echo "<div class='" . (($tab['flag_active'] == 't') ? 'active' : 'inactive') . "'><a href='" . $tab['tab_url'] . "' target='tab-iframe'>" . $tab['tab_menu'] . "</a></div>";
				$i++;
			}
		}
	}

	/**
	 * checkACL
	 *
	 * Checking system for ACL on page.
	 *
	 * @access	public
	 * @param	integer	The id of access type.
	 */	
	if (!function_exists('checkACL')) {

		define('CONST_ACL_ADD', 1);
		define('CONST_ACL_EDT', 2);
		define('CONST_ACL_DEL', 3);
		define('CONST_ACL_PRO', 4);

		function checkACL($type = CONST_ACL_ADD) {
			$instance =& get_instance();
			$con =& $instance->adodb->getConnection();
			$id_dd_kelompok = $instance->session->userdata('id_dd_kelompok');
			$url = $instance->uri->segment(1) . '/' . $instance->uri->segment(2) . '/' . $instance->uri->segment(3);
			switch ($type) {
				case CONST_ACL_ADD :					
					$sql =	"
							SELECT
								b.flag_add
							FROM
								dd_privilleges_url_kelompok_v a
								INNER JOIN
								dd_privilleges b ON a.id_dd_privilleges = b.id_dd_privilleges
							WHERE
								a.url = ?
								AND
								a.id_dd_kelompok = ?
							";
					$stmt =& $con->Prepare($sql);
					$res =& $con->Execute($stmt, array($url, $id_dd_kelompok));
					$flag =& $res->Fields('flag_add');
					break;
				case CONST_ACL_EDT :
					$sql =	"
							SELECT
								b.flag_edit
							FROM
								dd_privilleges_url_kelompok_v a
								INNER JOIN
								dd_privilleges b ON a.id_dd_privilleges = b.id_dd_privilleges
							WHERE
								a.url = ?
								AND
								a.id_dd_kelompok = ?
							";
					$stmt =& $con->Prepare($sql);
					$res =& $con->Execute($stmt, array($url, $id_dd_kelompok));
					$flag =& $res->Fields('flag_edit');
					break;
				case CONST_ACL_DEL :
					$sql =	"
							SELECT
								b.flag_del
							FROM
								dd_privilleges_url_kelompok_v a
								INNER JOIN
								dd_privilleges b ON a.id_dd_privilleges = b.id_dd_privilleges
							WHERE
								a.url = ?
								AND
								a.id_dd_kelompok = ?
							";
					$stmt =& $con->Prepare($sql);
					$res =& $con->Execute($stmt, array($url, $id_dd_kelompok));
					$flag =& $res->Fields('flag_del');
					break;
				case CONST_ACL_PRO :
					$sql =	"
							SELECT
								b.flag_process
							FROM
								dd_privilleges_url_kelompok_v a
								INNER JOIN
								dd_privilleges b ON a.id_dd_privilleges = b.id_dd_privilleges
							WHERE
								a.url = ?
								AND
								a.id_dd_kelompok = ?
							";
					$stmt =& $con->Prepare($sql);
					$res =& $con->Execute($stmt, array($url, $id_dd_kelompok));
					$flag =& $res->Fields('flag_process');
					break;
				default :
					show_error('Parameter ACL tidak valid.');
			}

			return (($flag == 't') ? TRUE : FALSE);
		}
	}

/* End of file Myhtml_helper.php */
/* Location: ./system/application/helpers/Myhtml_helper.php */