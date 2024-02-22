		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='basic/rekeningBank/addAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Bank</td>
							<td class='input'>
								<select name='id_bank' class='required'>
									<option value=''>-- Pilih Bank --</option>
									<?php foreach ($arr_bank as $bank) { ?>
									<option value='<?php echo $bank['id_bank']; ?>'><?php echo $bank['nama']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>No. Rekening</td>
							<td class='input'><input type='text' name='no_rekening' class='required' size='45'/></td>
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
