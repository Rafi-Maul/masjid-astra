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
			<form id='main-form' name='main-form' method='post' action='akun/transaksiPenerimaan/addAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>Tanggal</td>
							<td class='input'><?php setInputDate('tanggal', 1, 1); ?></td>
						</tr>
						<tr>
							<td class='label'>Kas</td>
							<td class='input'>
								<select name='id_kode_kas' class='required' onchange='javascript: rubahKas(this);' style='width: 200px;'>
									<option value=''>-- Pilih Kas --</option>
									<?php foreach ($arr_kas as $kas) { ?>
									<option value='<?php echo $kas['id_kode_kas']; ?>'><?php echo $kas['kas']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>			
						<tr>
							<td class='label'>Sub Kas</td>
							<td class='input'>
								<select name='id_sub_kode_kas' class='required' onchange='javascript: rubahSubKas(this);' style='width: 200px;'>
									<option value=''>-- Pilih Sub Kas --</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Transaksi</td>
							<td class='input'>
								<select name='id_jenis_transaksi' class='required' style='width: 200px;'>
									<option value=''>-- Pilih Transaksi --</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Petugas</td>
							<td class='input'><input name='petugas' type='text' class='required' style='width: 200px;'/></td>
						</tr>												
						<tr>
							<td class='label'>Nominal</td>
							<td class='input'><input name='nominal' type='text' class='number required'/></td>
						</tr>
						<tr>
							<td class='label'>Pajak</td>
							<td class='input'>
								<input name='pajak' type='text' class='number'/>&nbsp;%
							</td>
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
			-->
		</script>
		<!-- END : Process Form -->
