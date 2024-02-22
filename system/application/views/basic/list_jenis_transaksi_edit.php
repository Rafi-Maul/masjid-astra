		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='basic/jenisTransaksi/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Kode Kas</td>
							<td class='input'>
								<select name='id_kode_kas' class='required' onchange='javascript: rubahKodeKas(this);'>
									<option value=''>-- Pilih Kode Kas --</option>
									<?php foreach ($arr_kode_kas as $kode_kas) { ?>
									<option value='<?php echo $kode_kas['id_kode_kas']; ?>' <?php if ($jenis_transaksi['id_kode_kas'] == $kode_kas['id_kode_kas']) { ?>selected<?php } ?>><?php echo $kode_kas['kas']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label'>Sub Kode</td>
							<td class='input'>
								<select name='id_sub_kode_kas' class='required'>
									<option value=''>-- Pilih Sub Kode Kas --</option>
									<?php foreach ($arr_sub_kode_kas as $sub_kode_kas) { ?>
									<option value='<?php echo $sub_kode_kas['id_sub_kode_kas']; ?>' <?php if ($jenis_transaksi['id_sub_kode_kas'] == $sub_kode_kas['id_sub_kode_kas']) { ?>selected<?php } ?>><?php echo $sub_kode_kas['sub_kas']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>					
						<tr>
							<td class='label'>Transaksi</td>
							<td class='input'><input type='text' name='transaksi' class='required' size='45' value="<?php echo $jenis_transaksi['transaksi']; ?>"/></td>
						</tr>		
						<tr>
							<td class='label'>Klasifikasi Penerima</td>
							<td class='input'>
								<select name='id_klasifikasi_penerima' class='required' <?php if ($jenis_transaksi['flag_in_out'] == 'i') { ?>disabled<?php } ?>>
									<option value='0' <?php if (!is_numeric($jenis_transaksi['id_klasifikasi_penerima'])) { ?>selected<?php } ?>>Tidak Terklasifikasi/Terdaftar</option>
									<?php foreach ($arr_klasifikasi as $klasifikasi) { ?>
									<option value='<?php echo $klasifikasi['id_klasifikasi_penerima']; ?>' <?php if ($jenis_transaksi['id_klasifikasi_penerima'] == $klasifikasi['id_klasifikasi_penerima']) { ?>selected<?php } ?>><?php echo $klasifikasi['klasifikasi']; ?></option>
									<?php } ?>									
								</select>
							</td>
						</tr>						
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='keterangan' rows='3' cols='45'><?php echo $jenis_transaksi['keterangan']; ?></textarea>
							</td>
						</tr>	
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_jenis_transaksi' value='<?php echo $jenis_transaksi['id_jenis_transaksi']; ?>'/>
								<input type='hidden' name='flag_in_out' value='<?php echo $jenis_transaksi['flag_in_out']; ?>' class='required'/>
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
		<script language='javascript' type='text/javascript'>
			<!--	
			function rubahKodeKas(elm) {
				var oForm;
				oForm = elm.form;
				$("select[name='id_klasifikasi_penerima']").val('0').attr('disabled', 'disabled');
				$("input[name='flag_in_out']").val('');				
				removeOptions(oForm.id_sub_kode_kas, '');
				changeOptions(elm, oForm.id_sub_kode_kas, 'trans.sub_kode_kas', 'sub_kas', 'id_sub_kode_kas', 'ORDER BY sub_kas', false);
				if (elm.value != '') {
					$.post('basic/jenisTransaksi/getInOut', {id_kode_kas : elm.value}, function(data) {
						if (data.status == 1) {
							// Berhasil
							if (data.message == 'o')
								$("select[name='id_klasifikasi_penerima']").removeAttr('disabled');
							$("input[name='flag_in_out']").val(data.message);							
						} else {
							// Gagal
							alert("Tidak berhasil mendapatkan informasi jenis transaksi\n" + data.message);
						}					
					}, 'json');				
				}
			}
			//-->
		</script>		
