  		<!-- BEGIN : Report -->
  		<div id='report'>
			<form class='report' action='<?php echo site_url($this->uri->uri_string()) . '/kas'; ?>' method='post' target='laporan_kas'>
				<table class='report' border='0' cellspacing='0' cellpadding='2' align='center'>
					<tbody>
						<tr>
							<td class='title' colspan='2'>KE-01. LAPORAN BULANAN</td>
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
								<input type='submit' name='submit' value='Submit' onclick="javascript: if (!validateReqForm(this.form)) { return false;} else { openPop('about:blank', 'laporan_kas');}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form> 				
			
			<form class='report' action='<?php echo site_url($this->uri->uri_string()) . '/penerimaanInfaq'; ?>' method='post' target='laporan_penerimaan_infaq'>
				<table class='report' border='0' cellspacing='0' cellpadding='2' align='center'>
					<tbody>
						<tr>
							<td class='title' colspan='2'>KE-02. LAPORAN PENERIMAAN INFAQ</td>
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
							<td class='label'>Penerimaan</td>
							<td class='input'>
								<select name='id_sub_kode_kas'>
									<option value=''>-- Semua --</option>
									<?php foreach ($arr_penerimaan as $penerimaan) { ?>
									<option value='<?php echo $penerimaan['id_sub_kode_kas']; ?>'><?php echo $penerimaan['sub_kas']; ?></option>
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
								<input type='submit' name='submit' value='Submit' onclick="javascript: if (!validateReqForm(this.form)) { return false;} else { openPop('about:blank', 'laporan_penerimaan_infaq');}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form> 	

			<form class='report' action='<?php echo site_url($this->uri->uri_string()) . '/pengeluaranKajian'; ?>' method='post' target='laporan_pengeluaran_kajian'>
				<table class='report' border='0' cellspacing='0' cellpadding='2' align='center'>
					<tbody>
						<tr>
							<td class='title' colspan='2'>KE-03. LAPORAN PENGELUARAN KAJIAN RUTIN</td>
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
							<td class='label'>Pengeluaran</td>
							<td class='input'>
								<select name='id_sub_kode_kas'>
									<option value=''>-- Semua --</option>
									<?php foreach ($arr_pengeluaran as $pengeluaran) { ?>
									<option value='<?php echo $pengeluaran['id_sub_kode_kas']; ?>'><?php echo $pengeluaran['sub_kas']; ?></option>
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
								<input type='submit' name='submit' value='Submit' onclick="javascript: if (!validateReqForm(this.form)) { return false;} else { openPop('about:blank', 'laporan_pengeluaran_kajian');}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form> 	

			<form class='report' action='<?php echo site_url($this->uri->uri_string()) . '/pengeluaranRamadhan'; ?>' method='post' target='laporan_pengeluaran_ramadhan'>
				<table class='report' border='0' cellspacing='0' cellpadding='2' align='center'>
					<tbody>
						<tr>
							<td class='title' colspan='2'>KE-04. LAPORAN PENGELUARAN RAMADHAN</td>
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
							<td class='label'>Pengeluaran</td>
							<td class='input'>
								<select name='id_sub_kode_kas'>
									<option value=''>-- Semua --</option>
									<?php foreach ($arr_pengeluaran as $pengeluaran) { ?>
									<option value='<?php echo $pengeluaran['id_sub_kode_kas']; ?>'><?php echo $pengeluaran['sub_kas']; ?></option>
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
								<input type='submit' name='submit' value='Submit' onclick="javascript: if (!validateReqForm(this.form)) { return false;} else { openPop('about:blank', 'laporan_pengeluaran_ramadhan');}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form> 	
			
		</div>
  		<!-- END : Content -->
