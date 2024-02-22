  		<!-- BEGIN : Report -->
  		<div id='report'>
			<form class='report' action='sie/bukuBesar/history' method='post' target='laporan_buku'>
				<table class='report' border='0' cellspacing='0' cellpadding='2' align='center'>
					<tbody>
						<tr>
							<td class='title' colspan='2'>BB-01. LAPORAN BUKU BESAR</td>
						</tr>	
						<tr>
							<td class='label'>Periode</td>
							<td class='input'>
								<select name='month1' class='required'>
									<option value=''>-- Pilih Bulan --</option>
									<?php for ($i = 1; $i <= 12; $i++) { ?>
									<option value='<?php echo $i; ?>'><?php echo getMonthString($i); ?></option>
									<?php } ?>
								</select>
								&nbsp;
								<select name='year1' class='required'>
									<option value=''>-- Pilih Tahun --</option>
									<?php foreach ($arr_years as $year) { ?>
									<option value='<?php echo $year['tahun']; ?>'><?php echo $year['tahun']; ?></option>
									<?php } ?>
								</select>	
								&nbsp;
								s/d
								&nbsp;
								<select name='month2' class='required'>
									<option value=''>-- Pilih Bulan --</option>
									<?php for ($i = 1; $i <= 12; $i++) { ?>
									<option value='<?php echo $i; ?>'><?php echo getMonthString($i); ?></option>
									<?php } ?>
								</select>
								&nbsp;
								<select name='year2' class='required'>
									<option value=''>-- Pilih Tahun --</option>
									<?php foreach ($arr_years as $year) { ?>
									<option value='<?php echo $year['tahun']; ?>'><?php echo $year['tahun']; ?></option>
									<?php } ?>
								</select>									
							</td>
						</tr>	
						<tr>
							<td class='label'>Kode Perkiraan</td>
							<td class='input'>
								<input type='text' name='coa'/>
								&nbsp;
								<input type='button' name='cari' value='Cari...' class='submit01' onclick='javascript: searchCOA(this);'/>
							</td>
						</tr>	
						<tr>
							<td class='label'>&nbsp;</td>
							<td class='input'>
								<select name='id_akdd_detail_coa' class='required'>
									<option value=''>-- Pilih COA --</option>
								</select>
							</td>
						</tr>		
						<tr>
							<td class='label'>Format</td>
							<td class='input'>
								<select name='kode_format' class='required'>
									<option value='1'>PDF</option>
									<option value='2'>Excel</option>
								</select>
							</td>
						</tr>																												
						<tr>
							<td colspan='2' align='center' class='button-space'>
								<input type='submit' name='submit' value='Submit' onclick="javascript: if (!validateReqForm(this.form)) { return false;} else { openPop('about:blank', 'laporan_buku');}"/>
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
				if (oForm.coa.value == '') {
					alert('Kode perkiraan harus diisi !');
					return;
				} else {
					$('option[value!=\'\']', $("div#report select[name='id_akdd_detail_coa']")).attr('disabled', 'disabled');
					$('option[value!=\'\']', $("div#report select[name='id_akdd_detail_coa']")).remove();
					$.post('sie/service/getCOA', {coa : oForm.coa.value}, function(data) {
						$(data).each(function() {
							$("div#report select[name='id_akdd_detail_coa']").append('<option value=\'' + this.id_akdd_detail_coa + '\'>' + this.uraian + '</option>');
						});
						$('option[value!=\'\']', $("div#report select[name='id_akdd_detail_coa']")).removeAttr('disabled');
					}, 'json');				
				}
			}
			//-->
		</script>
  		<!-- END : Content -->
