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
			<form id='main-form' name='main-form' method='post' action='akun/transaksiPenerimaan/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>No. Bukti</td>
							<td class='input'><?php echo $transaksi['no_bukti']; ?></td>
						</tr>																							
						<tr>
							<td class='label'>Tanggal</td>
							<td class='input'><?php setInputDate('tanggal', 1, 1, substr($transaksi['tanggal'], -2), substr($transaksi['tanggal'], 5, 2), substr($transaksi['tanggal'], 0, 4)); ?></td>
						</tr>
						<tr>
							<td class='label'>Kas</td>
							<td class='input'>
								<select name='id_kode_kas' class='required' onchange='javascript: rubahKas(this);' style='width: 200px;'>
									<option value=''>-- Pilih Kas --</option>
									<?php foreach ($arr_kas as $kas) { ?>
									<option value='<?php echo $kas['id_kode_kas']; ?>' <?php if ($kas['id_kode_kas'] == $transaksi['id_kode_kas']) { ?>selected<?php } ?>><?php echo $kas['kas']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>			
						<tr>
							<td class='label'>Sub Kas</td>
							<td class='input'>
								<select name='id_sub_kode_kas' class='required' onchange='javascript: rubahSubKas(this);' style='width: 200px;'>
									<option value=''>-- Pilih Sub Kas --</option>
									<?php foreach ($arr_sub_kas as $sub_kas) { ?>
									<option value='<?php echo $sub_kas['id_sub_kode_kas']; ?>' <?php if ($sub_kas['id_sub_kode_kas'] == $transaksi['id_sub_kode_kas']) { ?>selected<?php } ?>><?php echo $sub_kas['sub_kas']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Transaksi</td>
							<td class='input'>
								<select name='id_jenis_transaksi' class='required' style='width: 200px;'>
									<option value=''>-- Pilih Transaksi --</option>
									<?php foreach ($arr_jenis as $jenis) { ?>
									<option value='<?php echo $jenis['id_jenis_transaksi']; ?>' <?php if ($jenis['id_jenis_transaksi'] == $transaksi['id_jenis_transaksi']) { ?>selected<?php } ?>><?php echo $jenis['transaksi']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Petugas</td>
							<td class='input'><input name='petugas' type='text' class='required' style='width: 200px;' value="<?php echo $transaksi['petugas']; ?>"/></td>
						</tr>												
						<tr>
							<td class='label'>Nominal</td>
							<td class='input'><input name='nominal' type='text' class='number required' value='<?php echo numFormat($transaksi['nominal']); ?>'/></td>
						</tr>
						<tr>
							<td class='label'>Pajak</td>
							<td class='input'><input name='pajak' type='text' class='number' value='<?php echo numFormat($transaksi['pajak']); ?>'/>&nbsp;%</td>
						</tr>	
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='keterangan' rows='3' cols='45'><?php echo $transaksi['keterangan']; ?></textarea>
							</td>
						</tr>							
						<tr>
							<td class='label' colspan='2'>
							    <input type='hidden' name='id_transaksi' value='<?php echo $transaksi['id_transaksi']; ?>'/>
							    <input type='hidden' name='id_akmt_jurnal' value='<?php echo $transaksi['id_akmt_jurnal']; ?>'/>
							    <input type='hidden' name='id_sub_transaksi_debet' value='<?php echo $transaksi['id_sub_transaksi_debet']; ?>'/>
							    <input type='hidden' name='id_sub_transaksi_kredit' value='<?php echo $transaksi['id_sub_transaksi_kredit']; ?>'/>
							    <input type='hidden' name='id_sub_transaksi_pajak' value='<?php echo $transaksi['id_sub_transaksi_pajak']; ?>'/>
							    <input type='hidden' name='id_jurnal_debet' value='<?php echo $transaksi['id_jurnal_debet']; ?>'/>
							    <input type='hidden' name='id_jurnal_kredit' value='<?php echo $transaksi['id_jurnal_kredit']; ?>'/>
							    <input type='hidden' name='id_jurnal_pajak' value='<?php echo $transaksi['id_jurnal_pajak']; ?>'/>							    							    
							    <input type='hidden' name='page' value='<?php echo $page; ?>'/>
							    <input type='hidden' name='filter' value='<?php echo $filter; ?>'/>
							    <input type='hidden' name='keyword' value='<?php echo $keyword; ?>'/>
							</td>
						</tr>	
						<tr>
							<td class='button-space' colspan='2'>
								<input type='submit' name='submit' onclick='javascript: return submitReqForm(this);' value='Submit'/>
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
			function rubahKas(elm) {
				var oForm;
				oForm = elm.form;				
				removeOptions(oForm.id_sub_kode_kas, '');
				removeOptions(oForm.id_jenis_transaksi, '');
				changeOptions(elm, oForm.id_sub_kode_kas, 'trans.sub_kode_kas', "(kode::TEXT || '. '::TEXT || sub_kas::TEXT)", 'id_sub_kode_kas', 'ORDER BY kode', false);				
			}

			function rubahSubKas(elm) {
				var oForm;
				oForm = elm.form;				
				removeOptions(oForm.id_jenis_transaksi, '');
				changeOptions(elm, oForm.id_jenis_transaksi, 'trans.jenis_transaksi', 'transaksi', 'id_jenis_transaksi', 'ORDER BY transaksi', false);						
			}
			//-->
		</script>
		<!-- END : Process Form -->
