		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='<?php echo base_url() ?>basic/<?php echo $tipe; ?>/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>								
						<tr>
							<td class='label'>Nama</td>
							<td class='input'><input type='text' name='nama' class='required' size='45' value="<?php echo $penerima['nama']; ?>"/></td>
						</tr>							
						<tr>
							<td class='label'>Alamat</td>
							<td class='input'>
								<textarea name='alamat' rows='3' cols='45'><?php echo $penerima['alamat']; ?></textarea>							
							</td>
						</tr>
						<tr>
							<td class='label'>No. HP</td>
							<td class='input'><input type='text' name='no_hp' size='45' value="<?php echo $penerima['no_hp']; ?>"/></td>
						</tr>													
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='keterangan' rows='3' cols='45'><?php echo $penerima['keterangan']; ?></textarea>
							</td>
						</tr>	
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_pihak_penerima' value='<?php echo $penerima['id_pihak_penerima']; ?>'/>
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
