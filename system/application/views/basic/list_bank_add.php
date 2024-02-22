		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='basic/bank/addAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Propinsi</td>
							<td class='input'>
								<select name='id_propinsi' class='required' onchange='javascript: rubahPropinsi(this);'>
									<option value=''>-- Pilih Propinsi --</option>
									<?php foreach ($arr_propinsi as $prop) { ?>
									<option value='<?php echo $prop['id_propinsi']; ?>'><?php echo $prop['nama']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Kota</td>
							<td class='input'>
								<select name='id_kota' class='required'>
									<option value=''>-- Pilih Kota --</option>
								</select>
							</td>
						</tr>						
						<tr>
							<td class='label'>Bank</td>
							<td class='input'><input type='text' name='nama' class='required' size='45'/></td>
						</tr>							
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='keterangan' rows='3' cols='45'></textarea>
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
			function rubahPropinsi(elm) {
				var oForm;
				oForm = elm.form;
				removeOptions(oForm.id_kota, '');
				changeOptions(elm, oForm.id_kota, 'trans.kota', 'nama', 'id_kota', 'ORDER BY nama', false);
			}
			//-->
		</script>		