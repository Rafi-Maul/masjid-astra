		<?php $ci =& get_instance(); ?>
		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='akun/coa/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Klasifikasi</td>
							<td class='input'><?php echo $coa['uraian_klasifikasi']; ?></td>
						</tr>							
						<tr>
							<td class='label'>Level</td>
							<td class='input'><?php echo $coa['level_number']; ?></td>
						</tr>							
						<tr>
							<td class='label'>Akun Induk</td>
							<td class='input'><?php echo $coa['coa_induk']; ?></td>
						</tr>							
						<tr>
							<td class='label'>Kode Akun</td>
							<td class='input'><input type='text' name='coa_number' class='required coa-number' value='<?php echo substr($coa['coa_number'], $offset, $coa['level_length']); ?>' maxlength='<?php echo $coa['level_length']; ?>'/></td>
						</tr>							
						<tr>
							<td class='label'>Uraian</td>
							<td class='input'>
								<textarea name='uraian' rows='3' cols='45' class='required'><?php echo $coa['uraian']; ?></textarea>
							</td>
						</tr>							
						<tr>
							<td class='label'>Klasifikasi Aktiva Bersih</td>
							<td class='input'>
								<select name='id_akdd_klasifikasi_modal' class='required' <?php if (($coa['id_akdd_main_coa'] == $ci->getIDModal()) && ($coa['level_number'] == $level_detail)) {  } else { ?>disabled<?php } ?>>
									<option value=''>-- Pilih Tipe Aktiva --</option>
									<?php foreach ($arr_modal as $modal) { ?>
									<option value='<?php echo $modal['id_akdd_klasifikasi_modal']; ?>' <?php if ($modal['id_akdd_klasifikasi_modal'] == $coa['id_akdd_klasifikasi_modal']) { ?>selected<?php } ?>><?php echo $modal['klasifikasi']; ?></option>
									<?php } ?>									
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Sub COA</td>
							<td class='input'>
								<textarea name='sub_coa' rows='3' cols='45' class='required' <?php if (($coa['id_akdd_main_coa'] == $ci->getIDModal()) && ($coa['level_number'] == $level_detail)) {  } else { ?>disabled<?php } ?>><?php echo $coa['sub_coa']; ?></textarea>
							</td>
						</tr>													
						<tr>
							<td class='label'>Muncul di Jurnal</td>
							<td class='input'>
								<select name='flag_mapping' class='required' <?php echo $coa['level_number']==$level_detail?'':'disabled'; ?>>
									<option value='0' <?php echo $coa['flag_mapping']=='0'?'selected':''; ?>>Jurnal Umum</option>
									<option value='1' <?php echo $coa['flag_mapping']=='1'?'selected':''; ?>>Jurnal Umum + Jurnal Penerimaan</option>
									<option value='2' <?php echo $coa['flag_mapping']=='2'?'selected':''; ?>>Jurnal Umum + Jurnal Penyaluran</option>
									<option value='3' <?php echo $coa['flag_mapping']=='3'?'selected':''; ?>>Semua Jurnal</option>
								</select>                               
							</td>
						</tr>
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_akdd_detail_coa' value='<?php echo $coa['id_akdd_detail_coa']; ?>'/>
								<input type='hidden' name='level_number' value='<?php echo $coa['level_number']; ?>'/>
								<input type='hidden' name='id_akdd_detail_coa_ref' value='<?php echo $coa['id_akdd_detail_coa_ref']; ?>'/>
								<input type='hidden' name='offset' value='<?php echo $offset; ?>'/>
								<input type='hidden' name='coa_parent' value='<?php echo str_pad(substr($coa['coa_number'], 0, $offset), $total_length, '0', STR_PAD_RIGHT); ?>'/>
								<input type='hidden' name='level_length' value='<?php echo $coa['level_length']; ?>'/>
								<input type='hidden' name='total_length' value='<?php echo $total_length; ?>'/>
								<input type='hidden' name='id_akdd_klasifikasi_modal_prev' value='<?php echo $coa['id_akdd_klasifikasi_modal']; ?>'/>
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