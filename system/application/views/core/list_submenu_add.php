		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='core/subMenu/addAct'>
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
									<option value='<?php echo $modul['id_dd_moduls']; ?>'><?php echo $modul['modul']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Menu</td>
							<td class='input'>
								<select name='id_dd_menus' class='required'>
									<option value=''>-- Pilih Menu --</option>
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
									<option value='<?php echo $i; ?>'><?php echo $i; ?></option>
									<?php
										}
									?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Sub Menu</td>
							<td class='input'><input type='text' name='sub_menu' class='required' size='45'/></td>
						</tr>							
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='note' rows='3' cols='45'></textarea>
							</td>
						</tr>	
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>	
						<tr>
							<td class='button-space' colspan='2'>
								<input type='submit' name='submit' onclick="javascript: return submitReqForm(this);" value='Submit'/>
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
				changeOptions(elm, oForm.id_dd_menus, 'dd_menus', 'menu', 'id_dd_menus', 'ORDER BY order_number', false);
			}
			//-->
		</script>