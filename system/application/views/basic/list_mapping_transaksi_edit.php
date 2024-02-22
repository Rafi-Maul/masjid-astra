		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='basic/mappingTransaksi/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>				
						<tr>
							<td class='label'>Kode Kas</td>
							<td class='input'><?php echo $mapping_transaksi['kas']; ?>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>Sub Kode</td>
							<td class='input'><?php echo $mapping_transaksi['sub_kas']; ?>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>Transaksi</td>
							<td class='input'><?php echo $mapping_transaksi['transaksi']; ?>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>Debet</td>
							<td class='input'>
								<select name='id_coa_debet' class='required' style='width: 425px;'>
									<option value=''>-- Pilih Kode Akun --</option>
									<?php foreach ($arr_kode_akun as $kode_akun) { ?>
									<option value='<?php echo $kode_akun['id_akdd_detail_coa']; ?>' <?php if ($mapping_transaksi['id_coa_debet'] == $kode_akun['id_akdd_detail_coa']) { ?>selected<?php } ?>><?php echo $kode_akun['uraian']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>					
						<tr>
							<td class='label'>Kredit</td>
							<td class='input'>
								<select name='id_coa_kredit' class='required' style='width: 425px;'>
									<option value=''>-- Pilih Kode Akun --</option>
									<?php foreach ($arr_kode_akun as $kode_akun) { ?>
									<option value='<?php echo $kode_akun['id_akdd_detail_coa']; ?>' <?php if ($mapping_transaksi['id_coa_kredit'] == $kode_akun['id_akdd_detail_coa']) { ?>selected<?php } ?>><?php echo $kode_akun['uraian']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>					
						<tr>
							<td class='label'>Pajak</td>
							<td class='input' nowrap>
								<select name='flag_debet_kredit'>
									<option value=''>-- Posisi Pajak --</option>
									<option value='1' <?php if ($mapping_transaksi['posisi_pajak'] == 1) { ?>selected<?php } ?>>Debet</option>
									<option value='2' <?php if ($mapping_transaksi['posisi_pajak'] == 2) { ?>selected<?php } ?>>Kredit</option>
								</select>														
								&nbsp;
								<select name='id_coa_pajak' style='width: 300px;'>
									<option value=''>-- Pilih Kode Akun --</option>
									<?php foreach ($arr_kode_akun as $kode_akun) { ?>
									<option value='<?php echo $kode_akun['id_akdd_detail_coa']; ?>' <?php if ($mapping_transaksi['id_coa_pajak'] == $kode_akun['id_akdd_detail_coa']) { ?>selected<?php } ?>><?php echo $kode_akun['uraian']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>					
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_jenis_transaksi' value='<?php echo $id_jenis_transaksi; ?>'/>
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
