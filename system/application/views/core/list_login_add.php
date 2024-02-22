		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='core/login/addAct'>
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
									<option value='<?php echo $group['id_dd_groups']; ?>'><?php echo $group['group_name']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>												
						<tr>
							<td class='label'>Login</td>
							<td class='input'><input type='text' name='username' class='required' size='45'/></td>
						</tr>
						<tr>
							<td class='label'>Kata Sandi</td>
							<td class='input'><input type='password' name='passkeys1' class='required' size='45'/></td>
						</tr>							
						<tr>
							<td class='label'>Konfirmasi Kata Sandi</td>
							<td class='input'><input type='password' name='passkeys2' class='required' size='45'/></td>
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