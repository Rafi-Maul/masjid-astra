		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='basic/subKodeKas/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Kode Kas</td>
							<td class='input'>
								<select name='id_kode_kas' class='required'>
									<option value=''>-- Pilih Kode Kas --</option>
									<?php foreach ($arr_kode_kas as $kode_kas) { ?>
									<option value='<?php echo $kode_kas['id_kode_kas']; ?>' <?php if ($kode_kas['id_kode_kas'] == $sub_kode_kas['id_kode_kas']) { ?>selected<?php } ?>><?php echo $kode_kas['kas']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Sub Kode</td>
							<td class='input'><input type='text' name='kode' class='required' size='5' maxLength='2' value='<?php echo $sub_kode_kas['kode']; ?>'/></td>
						</tr>
						<tr>
							<td class='label'>Sub Kas</td>
							<td class='input'><input type='text' name='sub_kas' class='required' size='45' value="<?php echo $sub_kode_kas['sub_kas']; ?>"/></td>
						</tr>		
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='keterangan' rows='3' cols='45'><?php echo $sub_kode_kas['keterangan']; ?></textarea>
							</td>
						</tr>	
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_sub_kode_kas' value='<?php echo $sub_kode_kas['id_sub_kode_kas']; ?>'/>
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
