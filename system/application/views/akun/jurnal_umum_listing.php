  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='non-print-act'>
  				<?php if ($s4b_password->getAccess('tambah')) { ?>
				<a class='act-button' href='<?php echo $link_tambah; ?>'>
					<img src='<?php echo $img_folder; ?>/add.gif' border='0' alt='Tambah' align='absmiddle'/>Tambah
				</a>
				<?php } ?>
				<?php if ($s4b_password->getAccess('hapus')) { ?>
				<a class='act-button' href="javascript: delForm('main-form', 'akun/jurnal/delAll');">
					<img src='<?php echo $img_folder; ?>/del.gif' border='0' alt='Hapus' align='absmiddle'/>Hapus
				</a>
				<?php } ?>
  			</div>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a class='act-button' href="javascript: openPop('akun/jurnal/report/<?php echo (empty($masuk_keluar) ? 0 : $masuk_keluar); ?>/<?php echo (empty($tgl_1) ? 0 : $tgl_1); ?>/<?php echo (empty($tgl_2) ? 0 : $tgl_2); ?>/<?php echo $keyword; ?>', 'report');">
					<img src='<?php echo $img_folder; ?>/print.gif' border='0' alt='Laporan' align='absmiddle'/>Laporan
				</a>
				<?php } ?>
  			</div>
  		</div>
  		<!-- END : Act Bar -->
  		<!-- BEGIN : Top Form -->
  		<div id='top-form'>
			<form name='search-form' action='<?php echo site_url($this->uri->uri_string()); ?>' method='post'>
				<table border='0' cellspacing='0' cellpadding='2'>
					<tr>
						<td align='right'>No Bukti / Keterangan :</td>
						<td><input type='text' name='keyword' value='<?php echo $keyword; ?>'/></td>
						<td><input type='submit' name='submit-filter' value='Cari !' class='submit01'/></td>											
					</tr>					
					<tr>
						<td align='right'><table border='0' cellpadding='0' cellspacing='0'><tr><td><input type='checkbox' id='tanggal' name='tanggal' onclick='javascript: checkThisBox(this)' value='1' <?php if ($tanggal == 1) { ?>checked<?php } else { ?>&nbsp;<?php } ?>/></td><td>&nbsp;Tanggal :</td></tr></table></td> 
						<td colspan='2'><table border='0' cellspacing='0' cellpadding='0'><tr><td><?php setInputDate('tgl_1', 2, 2, $day1, $month1, $year1); ?></td><td>&nbsp;s/d&nbsp;</td><td><?php setInputDate('tgl_2', 2, 2, $day2, $month2, $year2); ?></td></tr></table></td>
					</tr>														
				</table>
			</form>  		
  		</div>
  		<!-- END : Top Form -->
  		<!-- BEGIN : Content -->
  		<div id='content'>
  			<form id='main-form' method='post' action=''>
  				<table id='tbl' width='100%' border='0' cellpadding='3' cellspacing='0'>
  					<thead>
  						<tr>
  							<th class='th-no' rowspan='2'>No.</th>
  							<th class='th-check' rowspan='2'><input type='checkbox' onclick='javascript:checkItAll(this)'/></th>
  							<th class='th-edit' rowspan='2'>Edit</th>
							<th width='40' rowspan='2'>Cetak</td>
  							<th width='100' rowspan='2'>No. Bukti</th>
  							<th width='100' rowspan='2'>Tanggal</th>
							<th width='350' rowspan='2'>Keterangan</th>
							<th rowspan='2'>Kode Akun</th>  							
  							<th colspan='2'>Jumlah</th>
						</tr>		
						<tr>
							<th width='100'>Debet</th>
							<th width='100'>Kredit</th>
						</tr>
  					</thead>
  					<tbody>
  						<?php
  							$i 	  = $s4b_paging['start'];
							$prev = '';
  							foreach ($arr_jurnal as $jurnal) {
								$debet = $jurnal['flag_position'] == 'd' ? numFormat($jurnal['jumlah']) : '-';
								$kredit = $jurnal['flag_position'] == 'k' ? numFormat($jurnal['jumlah']) : '-';
								if ($prev != $jurnal['id_akmt_jurnal']) {
									$prev = $jurnal['id_akmt_jurnal'];		
									$icon_edit = $jurnal['flag_temp'] == 0 ? 'alert' : 'edit';									
								} else {
									$jurnal['id_akmt_jurnal'] = '';
								}
								
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
  							<td class='td-check'>
								<?php if (is_numeric($jurnal['id_akmt_jurnal']) && ($jurnal['flag_posting'] != 2) && ($jurnal['flag_temp'] != 2)) { ?>
								<input type='checkbox' name='id_list[]' value='<?php echo $jurnal['id_akmt_jurnal']; ?>'/>
								<?php } else { ?>
								&nbsp;
								<?php } ?>
							</td>
  							<td class='td-edit'>
  								<?php if (($s4b_password->getAccess('edit')) && (is_numeric($jurnal['id_akmt_jurnal'])) && ($jurnal['flag_posting'] != 2) && ($jurnal['flag_temp'] != 2)) { ?>
							  	<a title='<?php echo ($icon_edit == 'edit' ? 'Edit jurnal' : 'Edit jurnal (belum selesai)'); ?>' href='<?php echo "{$link_edit}/{$jurnal['id_akmt_jurnal']}"; ?>/1'><img src='<?php echo $img_folder; ?>/<?php echo $icon_edit; ?>.gif' border='0' alt='Edit'/></a>
							  	<?php } else { ?>
							  	&nbsp;
							  	<?php } ?>
							</td>
							<td align='center'>
								<?php if (($s4b_password->getAccess('cetak')) && (is_numeric($jurnal['id_akmt_jurnal'])) && ($jurnal['flag_temp'] == 2)) { ?>
								<a title='Tampilkan bukti pembukuan' href="javascript: openPop('akun/jurnal/voucher/<?php echo $jurnal['id_akmt_jurnal']; ?>', 'report');">
									<img src='<?php echo $img_folder; ?>/print.gif' border='0' alt='Bukti Pembukuan' align='absmiddle'/>
								</a>
								<?php } else { ?>
								&nbsp;
								<?php } ?>
							</td>
							<td align='center'>
								<?php if (is_numeric($jurnal['id_akmt_jurnal'])) { ?>
								<?php echo $jurnal['no_bukti']; ?>
								<?php } else { ?>
								&nbsp;
								<?php } ?>
							</td>
  							<td align='center'>
								<?php if (is_numeric($jurnal['id_akmt_jurnal'])) { ?>							
								<?php echo getLocalDate($jurnal['tanggal']); ?>
								<?php } else { ?>
								&nbsp;
								<?php } ?>								
							</td>
							<td align='left'>
								<?php if (is_numeric($jurnal['id_akmt_jurnal'])) { ?>							
								<?php echo $jurnal['keterangan']; ?>
								<?php } else { ?>
								&nbsp;
								<?php } ?>																
							</td>
  							<td><?php echo $jurnal['coa_number'] . ' - ' . $jurnal['uraian']; ?></td>  							
							<td align='right'><?php echo $debet; ?></td>
							<td align='right'><?php echo $kredit; ?></td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
			</form>
  		</div>
		<script type='text/javascript' language='javascript'>
			<!--
			function checkThisBox(elm) {
				if (elm.checked) {
					// Aktif
					$('#tgl_1').attr('disabled', false);
					$('#tgl_2').attr('disabled', false);
					$('#tgl_1Day').attr('disabled', false);
					$('#tgl_2Day').attr('disabled', false);
					$('#tgl_1Month').attr('disabled', false);
					$('#tgl_2Month').attr('disabled', false);
					$('#tgl_1Year').attr('disabled', false);
					$('#tgl_2Year').attr('disabled', false);					
				} else {
					// Non Aktif
					$('#tgl_1').attr('disabled', true);
					$('#tgl_2').attr('disabled', true);					
					$('#tgl_1Day').attr('disabled', true);
					$('#tgl_2Day').attr('disabled', true);					
					$('#tgl_1Month').attr('disabled', true);
					$('#tgl_2Month').attr('disabled', true);
					$('#tgl_1Year').attr('disabled', true);
					$('#tgl_2Year').attr('disabled', true);										
				}
			}
			
			function afterInit() {
				if (($('#tanggal').attr('checked')) == true) {
					// Aktif
					$('#tgl_1').attr('disabled', false);
					$('#tgl_2').attr('disabled', false);					
					$('#tgl_1Day').attr('disabled', false);
					$('#tgl_2Day').attr('disabled', false);
					$('#tgl_1Month').attr('disabled', false);
					$('#tgl_2Month').attr('disabled', false);
					$('#tgl_1Year').attr('disabled', false);
					$('#tgl_2Year').attr('disabled', false);										
				} else {
					// Non Aktif
					$('#tgl_1').attr('disabled', true);
					$('#tgl_2').attr('disabled', true);					
					$('#tgl_1Day').attr('disabled', true);
					$('#tgl_2Day').attr('disabled', true);					
					$('#tgl_1Month').attr('disabled', true);
					$('#tgl_2Month').attr('disabled', true);
					$('#tgl_1Year').attr('disabled', true);
					$('#tgl_2Year').attr('disabled', true);															
				}
			}
			//-->
		</script>
  		<!-- END : Content -->
