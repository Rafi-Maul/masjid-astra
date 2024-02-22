		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='core/login/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>Group</td>
							<td class='input'>
								<select name='id_dd_groups' class='required'>
									<option value=''>-- Pilih Group --</option>
									<?php foreach ($arr_groups as $group) { ?>
									<option value='<?php echo $group['id_dd_groups']; ?>' <?php if ($group['id_dd_groups'] == $user['id_dd_groups']) { ?>selected<?php } ?>><?php echo $group['group_name']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>												
						<tr>
							<td class='label'>Login</td>
							<td class='input'><input type='text' name='username' class='required' size='45' value='<?php echo $user['username']; ?>'/></td>
						</tr>
						<tr>
							<td class='label'>Kata Kunci</td>
							<td class='input'>
								<select name='status_password' onchange='javascript: rubahKunci(this);'>
									<option value='0'>Tetap</option>
									<option value='1'>Dirubah</option>									
								</select>
							</td>
						</tr>		
						<tr>
							<td class='label'>Sebelumnya</td>
							<td class='input'><input type='password' id='prev_passkeys' name='prev_passkeys' class='required' size='30' disabled/></td>
						</tr>											
						<tr>
							<td class='label'>Kata Kunci</td>
							<td class='input'><input type='password' id='passkeys1' name='passkeys1' class='required' size='30' disabled/></td>
						</tr>																	
						<tr>
							<td class='label'>Konfirmasi</td>
							<td class='input'><input type='password' id='passkeys2' name='passkeys2' class='required' size='30' disabled/></td>
						</tr>																							
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='note' rows='3' cols='45'><?php echo $user['note']; ?></textarea>
							</td>
						</tr>	
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_dd_users' value='<?php echo $user['id_dd_users']; ?>'/>
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
		<script language='javascript' type='text/javascript'>
			<!--
			function rubahKunci(elm) {
				var oForm;
				
				oForm = elm.form;
				if (elm.value == 0) {
					// Tidak ganti password
					$('#prev_passkeys').attr('disabled', 'disabled');
					$('#prev_passkeys').val('');
					$('#passkeys1').attr('disabled', 'disabled');
					$('#passkeys1').val('');
					$('#passkeys2').attr('disabled', 'disabled');										
					$('#passkeys2').val('');					
				} else {
					// Ganti password
					$('#prev_passkeys').removeAttr('disabled');
					$('#passkeys1').removeAttr('disabled');
					$('#passkeys2').removeAttr('disabled');										
				}
			}
			//-->
		</script>
		<!-- END : Process Form -->
