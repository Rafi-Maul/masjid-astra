		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='akun/jurnal/editAct'>
				<table align='center' id='tbl-top' border='0' cellpadding='0' cellspacing='0' width='600'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Cari Kode Akun</td>
							<td class='input'><input type='text' name='cari_kode'/></td>
						</tr>		
						<tr>
							<td class='label'>&nbsp;</td>
							<td class='input'><input type='button' name='button_cari_code' value='Cari !' class='submit01' onclick='javascript: searchCOA(this);'/></td>							
						</tr>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>							
						<tr>
							<td class='label'>Kode Akun</td>
							<td class='input'>
								<select id='id_akdd_detail_coa' name='id_akdd_detail_coa' class='required'>
									<option value=''>-- Pilih Kode Akun --</option>
									<option value='<?php echo $jurnal_detail['id_akdd_detail_coa']; ?>' selected><?php echo $jurnal_detail['coa_number'] . '-' . $jurnal_detail['uraian']; ?></option>
								</select>
							</td>
						</tr>	
						<tr>
							<td class='label'>Nominal</td>
							<td class='input'>
								<input type='text' name='jumlah' class='required number' value='<?php echo numFormat($jurnal_detail['jumlah']); ?>'/>
							</td>
						</tr>	
						<tr>
							<td class='label'>Posisi</td>
							<td class='input'>
								<select name='flag_position' class='required'>
									<option value=''>-- Pilih Posisi --</option>
									<option value='d' <?php if ($jurnal_detail['flag_position'] == 'd') { ?>selected<?php } ?>>Debet</option>
									<option value='k' <?php if ($jurnal_detail['flag_position'] == 'k') { ?>selected<?php } ?>>Kredit</option>
								</select>
							</td>
						</tr>							
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_akmt_jurnal' value='<?php echo $id_akmt_jurnal; ?>'/>
								<input type='hidden' name='id_akmt_jurnal_det' value='<?php echo $id_akmt_jurnal_det; ?>'/>								
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
		<script language='javascript' type='text/javascript'>
			<!--
			function searchCOA(elm) {
				var oForm;
				
				oForm = elm.form;
				$('form#main-form').css('visibility', 'hidden');
				$('option[value!=\'\']', $('select#id_akdd_detail_coa')).remove();
				$.post('akun/service/getCOA', {coa_uraian : oForm.cari_kode.value, metodenya: '<?php echo $metodenya; ?>'}, function(data) {
					$(data).each(function() {
						$('select#id_akdd_detail_coa').append('<option value=\'' + this.id_akdd_detail_coa + '\'>' + this.coa_uraian + '</option>');
					});
					
					$('form#main-form').css('visibility', 'visible');
				}, 'json');				
			}
			//-->
		</script>
		<!-- END : Process Form -->