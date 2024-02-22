  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='non-print-act'>
				<?php if ($s4b_password->getAccess('hapus')) { ?>
				<a title='Hapus' class='act-button' href="javascript: delForm('main-form', 'basic/mappingTransaksi/del');">
					<img src='<?php echo $img_folder; ?>/del.gif' border='0' alt='Hapus' align='absmiddle'/>Hapus
				</a>
				<?php } ?>
  			</div>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a title='Laporan' class='act-button' href="javascript: openPop('basic/mappingTransaksi/report/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'report');">
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
							  <option value='1' <?php if ($filter == 1) { ?>selected<?php } ?>>Transaksi</option>
							</select>
						</td>
						<td>
							<input type='text' name='keyword' value="<?php echo $keyword; ?>"/>						
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
  							<th class='th-no' colspan='1' rowspan='2'>No.</th>
  							<th class='th-check' colspan='1' rowspan='2'><input type='checkbox' onclick='javascript:checkItAll(this)'/></th>
  							<th class='th-edit' colspan='1' rowspan='2'>Edit</th>
  							<th colspan='2' rowspan='1'>Kode</th>
  							<th colspan='1' rowspan='2'>Transaksi</th>
  							<th colspan='3' rowspan='1'>Kode Akun</th>
						</tr>		
						<tr>
							<th>Kas</th>
							<th>Sub Kas</th>
							<th>Debet</th>
							<th>Kredit</th>
							<th>Pajak</th>
						</tr>
  					</thead>
  					<tbody>
  						<?php
  							$i = $s4b_paging['start'];
  							foreach ($arr_mapping_transaksi as $mapping_transaksi) {
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
  							<td class='td-check'><input type='checkbox' name='id_list[]' value='<?php echo $mapping_transaksi['id_jenis_transaksi']; ?>'/>&nbsp;</td>
  							<td class='td-edit'>
  								<?php if ($s4b_password->getAccess('edit')) { ?>
							  	<a href="javascript: openPop('basic/mappingTransaksi/edit/<?php echo $mapping_transaksi['id_jenis_transaksi']; ?>/<?php echo $page; ?>/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'edit');"><img src='<?php echo $img_folder; ?>/edit.gif' border='0' alt='Edit'/></a>
							  	<?php } else { ?>
							  	&nbsp;
							  	<?php } ?>
							</td>
  							<td><?php echo $mapping_transaksi['kas']; ?>&nbsp;</td>
  							<td><?php echo $mapping_transaksi['sub_kas']; ?>&nbsp;</td>
  							<td><?php echo $mapping_transaksi['transaksi']; ?>&nbsp;</td>  							
  							<td><?php echo $mapping_transaksi['coa_debet']; ?>&nbsp;</td>
  							<td><?php echo $mapping_transaksi['coa_kredit']; ?>&nbsp;</td>
  							<td><?php echo $mapping_transaksi['coa_pajak']; ?>&nbsp;</td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
			</form>
  		</div>
  		<!-- END : Content -->
