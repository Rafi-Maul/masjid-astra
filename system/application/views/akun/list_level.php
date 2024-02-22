  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='non-print-act'>
  				<?php if (($s4b_password->getAccess('tambah')) && (!is_numeric($id_akmt_periode))) { ?>
				<a class='act-button' href="javascript: openPop('akun/level/add', 'tambah');">
					<img src='<?php echo $img_folder; ?>/add.gif' border='0' alt='Tambah' align='absmiddle'/>Tambah
				</a>
				<?php } ?>
				<?php if (($s4b_password->getAccess('hapus')) && (!is_numeric($id_akmt_periode))) { ?>
				<a class='act-button' href="javascript: delForm('main-form', 'akun/level/del');">
					<img src='<?php echo $img_folder; ?>/del.gif' border='0' alt='Hapus' align='absmiddle'/>Hapus
				</a>
				<?php } ?>
  			</div>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a class='act-button' href="javascript: openPop('akun/level/report/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'report');">
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
							  <option value='1' <?php if ($filter == 1) { ?>selected<?php } ?>>Uraian</option>
							  <option value='2' <?php if ($filter == 2) { ?>selected<?php } ?>>Level</option>
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
  							<th width='100'>Level Number</th>
  							<th width='100'>Besar Level</th>  							
  							<th>Uraian</th>
						</tr>		
  					</thead>
  					<tbody>
  						<?php
  							$i = $s4b_paging['start'];
  							foreach ($arr_level as $level) {
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
  							<td class='td-check'><input type='checkbox' name='id_list[]' value='<?php echo $level['id_akdd_level_coa']; ?>'/></td>
  							<td class='td-edit'>
  								<?php if (($s4b_password->getAccess('edit')) && (!is_numeric($id_akmt_periode))) { ?>
							  	<a href="javascript: openPop('akun/level/edit/<?php echo $level['id_akdd_level_coa']; ?>/<?php echo $page; ?>/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'edit');"><img src='<?php echo $img_folder; ?>/edit.gif' border='0' alt='Edit'/></a>
							  	<?php } else { ?>
							  	&nbsp;
							  	<?php } ?>
							</td>
  							<td align='center'><?php echo $level['level_number']; ?>&nbsp;</td>
  							<td align='right'><?php echo $level['level_length']; ?>&nbsp;</td>  							
  							<td><?php echo $level['uraian']; ?>&nbsp;</td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
			</form>
  		</div>
  		<!-- END : Content -->
