  		<!-- BEGIN : Head -->
		<div id='app-head'>
			<div id='left-side'>
				<!-- <div id='h-logo'><img src='<?php echo $img_folder; ?>/logo.gif'/></div> -->
				<div id='h-title'><?php echo $app_name; ?></div>
			</div>
			<div id='right-side'>
				<div id='h-title'><?php echo strtoupper($company_name); ?></div>
			</div>
		</div>
  		<!-- END : Head -->
		<!-- BEGIN : Modul -->
		<div id='modul'>
			<div id='left-modul'>
				<?php
					foreach ($arr_modul as $modul) {
				?>
				<a href='core/main/menu/<?php echo $modul['id_dd_moduls']; ?>' class='a-modul' target='menu-frame' title='<?php echo $modul['note']; ?>'><?php echo str_replace(' ', '&nbsp;', str_pad(strtoupper($modul['modul']), 10, ' ', STR_PAD_BOTH)); ?></a>
				<?php
					}
				?>
			</div>
			<div id='right-modul'>
				<?php if ($flag_debug == 1) { ?>
				<a href='javascript: toggleDebug();' class='a-modul' title='Debug'>DEBUG</a>
				<?php } ?>
				<?php if ($flag_reset == 1) { ?>
				<a href='javascript: reset();' class='a-modul' title='Reset Database'>RESET DB !</a>
				<?php } ?>
				<?php if ($flag_backup == 1) { ?>
				<a href='javascript: backup();' class='a-modul' title='Backup'>BACKUP !</a>
				<?php } ?>
				<a href='javascript: logout();' class='a-modul' title='Logout'><?php echo $username; ?>, LOGOUT</a>
			</div>
		</div>
		<!-- END : Modul -->
		<!-- BEGIN : Right IFrame -->
		<div id='tab-content'>
			<iframe id='main-frame' src='core/main/blank' name='main-frame' frameborder='0'></iframe>
		</div>
		<!-- END : Right IFrame -->
		<!-- BEGIN : Left IFrame -->
		<div id='left-container'>
			<iframe id='menu-frame' src='core/main/blank' name='menu-frame' frameborder='0'></iframe>
		</div>
		<script language='javascript' type='text/javascript'>
			<!--
			function logout() {
				if (confirm('Anda yakin untuk logout ?')) {
					location.href='<?php echo site_url("core/main/logoutAct");?>';
				}
			}

			function reset() {
				if (confirm('Semua pekerjaan dapat hilang, anda yakin untuk melakukan reset database ?')) openPop('core/main/resetAct', 'reset', 300, 200);
			}

			function backup() {
				openPop('core/main/backup', 'backup', 300, 200);
			}

			function toggleDebug() {
				openPop('core/main/debug', 'debug', 500, 200);
			}
			//-->
		</script>
		<!-- END : Left IFrame -->
