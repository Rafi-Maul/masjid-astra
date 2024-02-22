  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='non-print-act'>
  				<?php if ($s4b_password->getAccess('tambah')) { ?>
				<a class='act-button' href="javascript: openPop('akun/transaksiPengeluaran/add', 'tambah', 575, 425);">
					<img src='<?php echo $img_folder; ?>/add.gif' border='0' alt='Tambah' align='absmiddle'/>Tambah
				</a>
				<?php } ?>
				<?php if ($s4b_password->getAccess('hapus')) { ?>
				<a class='act-button' href="javascript: delForm('main-form', 'akun/transaksiPengeluaran/del');">
					<img src='<?php echo $img_folder; ?>/del.gif' border='0' alt='Hapus' align='absmiddle'/>Hapus
				</a>
				<?php } ?>
  			</div>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a class='act-button' href="javascript: openPop('akun/transaksiPengeluaran/report/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'report');">
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
						<td>Cari :</td>
						<td>
							<select name='filter'>
							  <option value='1' <?php if ($filter == 1) { ?>selected<?php } ?>>No. Bukti</option>
							</select>
						</td>
						<td>
							<input type='text' name='keyword' value='<?php echo $keyword; ?>'/>						
						</td>
						<td>
							<input type='submit' name='submit-filter' value='Cari !' class='submit01'/>						
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
  							<th class='th-check'><input type='checkbox' onclick='javascript:checkItAll(this)'/></th>
  							<th class='th-edit'>Edit</th>
  							<th width='50'>Cetak</th>
  							<th width='100'>Tanggal</th>
  							<th width='150'>No. Bukti</th>
							<th width='150'>Nominal</th>
							<th width='200'>Penerima</th>  							
  							<th>Keterangan</th>
						</tr>		
  					</thead>
  					<tbody>
  						<?php
  							$i = $s4b_paging['start'];
  							foreach ($arr_transaksi as $transaksi) {
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
  							<td class='td-check'>
  								<?php if ($transaksi['flag_temp'] != 2) { ?>
  								<input type='checkbox' name='id_list[]' value='<?php echo $transaksi['id_transaksi']; ?>'/>
  								<?php } else { ?>
  								&nbsp;
  								<?php } ?>
  							</td>
  							<td class='td-edit'>
  								<?php if ($s4b_password->getAccess('edit') && $transaksi['flag_temp'] != 2) { ?>
							  	<a href="javascript: openPop('akun/transaksiPengeluaran/edit/<?php echo $transaksi['id_transaksi']; ?>/<?php echo $page; ?>/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'edit', 575, 425);"><img src='<?php echo $img_folder; ?>/edit.gif' border='0' alt='Edit'/></a>
							  	<?php } else { ?>
							  	&nbsp;
							  	<?php } ?>
							</td>
							<td align='center'>
								<?php if ($s4b_password->getAccess('cetak') && $transaksi['flag_temp'] == 2) { ?>
								<a title='Tampilkan bukti pembukuan' href="javascript: openPop('akun/persetujuan/voucher/<?php echo $transaksi['id_akmt_jurnal']; ?>', 'report');">
									<img src='<?php echo $img_folder; ?>/print.gif' border='0' alt='Bukti Pembukuan' align='absmiddle'/>
								</a>
								<?php } else { ?>
								&nbsp;
								<?php } ?>
							</td>							
							<td align='center'><?php echo getLocalDate($transaksi['tanggal']); ?></td>
  							<td align='center'><?php echo $transaksi['no_bukti']; ?>&nbsp;</td>
  							<td align='right'><?php echo numFormat($transaksi['nominal']); ?>&nbsp;</td>
  							<td ><?php echo $transaksi['penerima']; ?>&nbsp;</td>  							
  							<td ><?php echo $transaksi['keterangan']; ?>&nbsp;</td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
			</form>
  		</div>
  		<!-- END : Content -->
