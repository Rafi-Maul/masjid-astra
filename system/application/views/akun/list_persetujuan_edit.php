		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='akun/persetujuan/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>No. Bukti</td>
							<td class='input'>
								<input type='text' name='no_bukti' value='<?php echo $jurnal['no_bukti']; ?>' readonly style='border: none; background: none;'/>
							</td>
						</tr>		
						<tr>
							<td class='label'>Tanggal</td>
							<td class='input'>
								<input type='text' name='tanggal' value='<?php echo getLocalDate($jurnal['tanggal']); ?>' readonly style='border: none; background: none;'/>
							</td>
						</tr>		
						<tr>
							<td class='label'>Nominal</td>
							<td class='input'>
								<input type='text' name='nominal' value='<?php echo 'Rp. ' . numFormat($jurnal['nominal']); ?>' readonly style='border: none; background: none;'/>
							</td>
						</tr>								
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='keterangan' rows='3' cols='45' readonly style='border: none; background: none;'><?php echo $jurnal['keterangan']; ?></textarea>
							</td>
						</tr>							
						<tr>
							<td class='label'>Persetujuan</td>
							<td class='input'>
								<select name='persetujuan' class='required'>
									<option value='1' <?php if ($jurnal['flag_temp'] == 1) { ?>selected<?php } ?>>Belum</option>
									<option value='2' <?php if ($jurnal['flag_temp'] == 2) { ?>selected<?php } ?>>Sudah</option>
								</select>
							</td>
						</tr>													
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>	
						<tr>
							<td class='button-space' colspan='2'>
								<input type='submit' name='submit' onclick="javascript: return submitReqForm(this, true);" value='Submit'/>
								&nbsp;&nbsp;&nbsp;
								<input type='reset' name='reset' value='Reset' onclick='javascript: refreshPage();'/>
								<input type='hidden' name='id_akmt_jurnal' value='<?php echo $jurnal['id_akmt_jurnal']; ?>'/>
								<input type='hidden' name='tanggal' value='<?php echo $jurnal['tanggal']; ?>'/>
								<input type='hidden' name='page' value='<?php echo $page; ?>'/>
								<input type='hidden' name='filter' value='<?php echo $filter; ?>'/>
								<input type='hidden' name='keyword' value='<?php echo $keyword; ?>'/>
							</td>
						</tr>																							
					</tbody>
				</table>
			</form>
		</div>
		<!-- END : Process Form -->
  		<!-- BEGIN : Content -->
  		<div id='content'>
  			<form id='main-form' method='post' action=''>
  				<table id='tbl' border='0' cellpadding='3' cellspacing='0' width='100%'>
  					<thead>
  						<tr>
  							<th class='th-no' rowspan='2'>No.</th>
							<th rowspan='2'>Kode Akun</th>  							
  							<th colspan='2'>Jumlah</th>
						</tr>		
						<tr>
							<th width='150'>Debet</th>
							<th width='150'>Kredit</th>
						</tr>
  					</thead>
					<tbody>
						<?php
							$i = 0;
							foreach ($arr_persetujuan as $persetujuan) {
						?>
						<tr>
							<td class='td-no'><?php echo ++$i; ?>.</td>
							<td><?php echo $persetujuan['coa_number'] . ' - ' . $persetujuan['uraian']; ?>.</td>
							<td class='td-no'><?php echo ($persetujuan['flag_position'] == 'd' ? numFormat($persetujuan['jumlah']) : '-'); ?></td>
							<td class='td-no'><?php echo ($persetujuan['flag_position'] == 'k' ? numFormat($persetujuan['jumlah']) : '-'); ?></td>
						</tr>
						<?php
							}
						?>
					</tbody>
				</table>
			</form>
		</div>
		<!-- END : Content -->