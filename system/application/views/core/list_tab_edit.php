		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='core/tab/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Modul</td>
							<td class='input'>
								<select name='id_dd_moduls' class='required' onchange='javascript: rubahModul(this);'>
									<option value=''>-- Pilih Modul --</option>
									<?php foreach ($arr_moduls as $modul) { ?>
									<option value='<?php echo $modul['id_dd_moduls']; ?>' <?php if ($modul['id_dd_moduls'] == $tab['id_dd_moduls']) { ?>selected<?php } ?>><?php echo $modul['modul']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Menu</td>
							<td class='input'>
								<select name='id_dd_menus' class='required' onchange='javascript: rubahMenu(this);'>
									<option value=''>-- Pilih Menu --</option>
									<?php foreach ($arr_menus as $menu) { ?>
									<option value='<?php echo $menu['id_dd_menus']; ?>' <?php if ($menu['id_dd_menus'] == $tab['id_dd_menus']) { ?>selected<?php } ?>><?php echo $menu['menu']; ?></option>
									<?php } ?>									
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Sub Menu</td>
							<td class='input'>
								<select name='id_dd_sub_menus' class='required'>
									<option value=''>-- Pilih Sub Menu --</option>
									<?php foreach ($arr_submenus as $submenu) { ?>
									<option value='<?php echo $submenu['id_dd_sub_menus']; ?>' <?php if ($submenu['id_dd_sub_menus'] == $tab['id_dd_sub_menus']) { ?>selected<?php } ?>><?php echo $submenu['sub_menu']; ?></option>
									<?php } ?>									
								</select>
							</td>
						</tr>																		
						<tr>
							<td class='label'>Urutan</td>
							<td class='input'>
								<select name='order_number' class='required'>
									<?php
										for ($i = 1; $i < 10; $i++) {
									?>
									<option value='<?php echo $i; ?>' <?php if ($i == $tab['order_number']) { ?>selected<?php } ?>><?php echo $i; ?></option>
									<?php
										}
									?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Status</td>
							<td class='input'>
								<select name='flag_active' class='required'>
									<option value=''>-- Pilih Status --</option>
									<option value='1' <?php if ($tab['flag_active'] == 1) { ?>selected<?php } ?>>Default</option>
									<option value='0' <?php if ($tab['flag_active'] == 0) { ?>selected<?php } ?>>Bukan Default</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Tab</td>
							<td class='input'><input type='text' name='tab' class='required' size='45' value='<?php echo $tab['tab']; ?>'/></td>
						</tr>						
						<tr>
							<td class='label'>URL</td>
							<td class='input'><input type='text' name='url' class='required' size='45' value='<?php echo $tab['url']; ?>'/></td>
						</tr>																															
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='note' rows='3' cols='45'><?php echo $tab['note']; ?></textarea>
							</td>
						</tr>	
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_dd_tabs' value='<?php echo $tab['id_dd_tabs']; ?>'/>
								<input type='hidden' name='page' value='<?php echo $page; ?>'/>
								<input type='hidden' name='filter' value='<?php echo $filter; ?>'/>
								<input type='hidden' name='keyword' value='<?php echo $keyword; ?>'/>
							</td>
						</tr>	
						<tr>
							<td class='button-space' colspan='2'>
								<input type='submit' name='submit' onclick="javascript: return submitReqForm(this, true);" value='Submit'/>
								&nbsp;&nbsp;&nbsp;
								<input type='reset' name='reset' value='Reset' onclick='javascript: refreshPage();'/>
							</td>
						</tr>																							
					</tbody>
				</table>
			</form>
		</div>
		<!-- END : Process Form -->
		<script language='javascript' type='text/javascript'>
			<!--	
			function rubahModul(elm) {
				var oForm;
				oForm = elm.form;
				removeOptions(oForm.id_dd_sub_menus, '');
				removeOptions(oForm.id_dd_menus, '');
				changeOptions(elm, oForm.id_dd_menus, 'dd_menus', 'menu', 'id_dd_menus', 'ORDER BY order_number', false);
			}
			
			function rubahMenu(elm) {
				var oForm;
				oForm = elm.form;
				changeOptions(elm, oForm.id_dd_sub_menus, 'dd_sub_menus', 'sub_menu', 'id_dd_sub_menus', 'ORDER BY order_number', false);
			}			
			//-->
		</script>