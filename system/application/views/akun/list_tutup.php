  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='non-print-act'>
				<?php if (($s4b_password->getAccess('proses')) && ($prev_month == $filter)) { ?>
				<a class='act-button' href="javascript: proses('<?php echo $filter; ?>');">
					<img src='<?php echo $img_folder; ?>/reload.gif' border='0' alt='Proses' align='absmiddle'/>Proses
				</a>
				<?php } ?>
  			</div>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a class='act-button' href="javascript: openPop('akun/tutupBuku/report/<?php echo $filter; ?>', 'report');">
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
						<td>Bulan :</td>
						<td>
							<?php if (count($arr_month) > 0) { ?>
							<select name='filter' onchange='javascript: changeMonth(this);'>
								<?php foreach ($arr_month as $month) { ?>
								<option value='<?php echo $month['tahun'] . str_pad($month['bulan'], 2, '0', STR_PAD_LEFT); ?>' <?php if ($filter == $month['tahun'] . str_pad($month['bulan'], 2, '0', STR_PAD_LEFT)) { ?>selected<?php } ?>><?php echo getMonthString($month['bulan']) . ', ' . $month['tahun']; ?></option>
								<?php } ?>
							</select>
							<?php } else { ?>
							N/A
							<?php } ?>
						</td>
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
  							<th class='th-no'>No.</th>
							<th width='50'>Status</th>
  							<th width='100'>Tanggal</th>
							<th width='100'>No. Bukti</th>
  							<th>Keterangan</th>
							<th width='150'>Nominal</th>
						</tr>		
  					</thead>
  					<tbody>
  						<?php
  							$i = $s4b_paging['start'];
  							foreach ($arr_jurnal as $jurnal) {
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
							<td align='center'>
								<?php if ($jurnal['flag_temp'] == 1) { ?>
								<img src='<?php echo $img_folder; ?>/alert.gif' border='0' title='Belum mendapat persetujuan'/>
								<?php } else { ?>
								<img src='<?php echo $img_folder; ?>/add.gif' border='0' title='Sudah mendapat persetujuan'/>
								<?php } ?>
							</td>
  							<td align='center'><?php echo getLocalDate($jurnal['tanggal']); ?>&nbsp;</td>
							<td align='center'><?php echo $jurnal['no_bukti']; ?>&nbsp;</td>
							<td><?php echo $jurnal['keterangan']; ?>&nbsp;</td>
							<td align='right'><?php echo numFormat($jurnal['jumlah']); ?>&nbsp;</td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
			</form>
  		</div>
		<script language='javascript' type='text/javascript'>
			<!--
			function changeMonth(elm) {
				var oForm;
				
				oForm = elm.form;
				oForm.submit();
			}
			
			function proses(filter) {
				if (confirm('Anda yakin untuk menutup buku ?')) {
					$.post('akun/tutupBuku/proses', {periode : filter}, function(data) {
						var flag, message;
						$(data).each(function() {
							flag 	= this.flag;
							message = this.message;
						});
						alert(message);
						if (flag == 1)
							location.replace(location.href);
					}, 'json');					
				}
			}
			//-->
		</script>
  		<!-- END : Content -->
