  		<!-- BEGIN : Report -->
  		<div id='report'>
			<form class='report' action='<?php echo site_url($this->uri->uri_string()); ?>/level' method='post' target='laporan_posisi_level'>
				<table class='report' border='0' cellspacing='0' cellpadding='2' align='center'>
					<tbody>
						<tr>
							<td class='title' colspan='2'>PK-01. LAPORAN POSISI KEUANGAN PER LEVEL</td>
						</tr>																									
						<tr>
							<td class='label'>Level</td>
							<td class='input'>
								<select name='level_coa' class='required'>
									<option value=''>-- Pilih Level --</option>
									<?php foreach ($arr_level as $level) { ?>
									<option value='<?php echo $level['level_number']; ?>'><?php echo $level['level_number']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>										
						<tr>
							<td class='label'>Posisi</td>
							<td class='input'>
								<select name='month' class='required'>
									<option value=''>-- Pilih Bulan --</option>
									<?php for ($i = 1; $i <= 12; $i++) { ?>
									<option value='<?php echo $i; ?>'><?php echo getMonthString($i); ?></option>
									<?php } ?>
								</select>
								&nbsp;
								<select name='year' class='required'>
									<option value=''>-- Pilih Tahun --</option>
									<?php foreach ($arr_years as $year) { ?>
									<option value='<?php echo $year['tahun']; ?>'><?php echo $year['tahun']; ?></option>
									<?php } ?>
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
								<input type='submit' name='submit' value='Submit' onclick="javascript: if (!validateReqForm(this.form)) { return false;} else { openPop('about:blank', 'laporan_posisi_level');}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form> 
			<form class='report' action='<?php echo site_url($this->uri->uri_string()); ?>/template' method='post' target='laporan_posisi'>
				<table class='report' border='0' cellspacing='0' cellpadding='2' align='center'>
					<tbody>
						<tr>
							<td class='title' colspan='2'>PK-02. LAPORAN POSISI KEUANGAN</td>
						</tr>																														
						<tr>
							<td class='label'>Bulan</td>
							<td class='input'>
								<select name='month' class='required'>
									<option value=''>-- Pilih Bulan --</option>
									<?php for ($i = 1; $i <= 12; $i++) { ?>
									<option value='<?php echo $i; ?>'><?php echo getMonthString($i); ?></option>
									<?php } ?>									
								</select>
							</td>
						</tr>					
						<tr>
							<td class='label'>Tahun</td>
							<td class='input'>
								<select name='year' class='required'>
									<option value=''>-- Pilih Tahun --</option>
									<?php foreach ($arr_years as $year) { ?>
									<option value='<?php echo $year['tahun']; ?>'><?php echo $year['tahun']; ?></option>
									<?php } ?>									
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
								<input type='submit' name='submit' value='Submit' onclick="javascript: if (!validateReqForm(this.form)) { return false;} else { openPop('about:blank', 'laporan_posisi');}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form> 				
		</div>
  		<!-- END : Content -->
