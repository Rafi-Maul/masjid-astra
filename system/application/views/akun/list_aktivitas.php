  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a class='act-button' href="javascript: openPop('akun/aktivitas/report/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'report');">
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
							  <option value='1' <?php if ($filter == 1) { ?>selected<?php } ?>>Klasifikasi</option>
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
  							<th width='25'>ID</th>
  							<th>Klasifikasi</th>
						</tr>		
  					</thead>
  					<tbody>
  						<?php
  							$i = $s4b_paging['start'];
  							foreach ($arr_klasifikasi as $klasifikasi) {
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
  							<td align='center'><?php echo $klasifikasi['id_akdd_klasifikasi_modal']; ?>&nbsp;</td>
  							<td><?php echo $klasifikasi['klasifikasi']; ?>&nbsp;</td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
			</form>
  		</div>
  		<!-- END : Content -->
