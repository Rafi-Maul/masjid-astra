		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='basic/kodeKas/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Kode</td>
							<td class='input'><input type='text' name='kode' class='required' size='45' value='<?php echo $kode_kas['kode']; ?>'/></td>
						</tr>
						<tr>
							<td class='label'>Kas</td>
							<td class='input'><input type='text' name='kas' class='required' size='45' value="<?php echo $kode_kas['kas']; ?>"/></td>
						</tr>	
						<tr>
							<td class='label'>Tipe</td>
							<td class='input'>
								<select name='flag_in_out' class='required'>
									<option value=''>-- Pilih Tipe --</option>
									<option value='i' <?php if ($kode_kas['flag_in_out'] == 'i') { ?>selected<?php } ?>>Penerimaan</option>
									<option value='o' <?php if ($kode_kas['flag_in_out'] == 'o') { ?>selected<?php } ?>>Pengeluaran</option>
								</select>
							</td>
						</tr>											
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='keterangan' rows='3' cols='45'><?php echo $kode_kas['keterangan']; ?></textarea>
							</td>
						</tr>	
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_kode_kas' value='<?php echo $kode_kas['id_kode_kas']; ?>'/>
								<input type='hidden' name='page' value='<?php echo $page; ?>'/>
								<input type='hidden' name='filter' value='<?php echo $filter; ?>'/>
								<input type='hidden' name='keyword' value='<?php echo $keyword; ?>'/>																
							</td>
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
