  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a class='act-button' href="javascript: openPop('akun/group/report/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'report');">
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
  							<th width='100'>Tipe Akun</th>
  							<th>Uraian</th>
						</tr>		
  					</thead>
  					<tbody>
  						<?php
  							$i = $s4b_paging['start'];
  							foreach ($arr_main as $main) {
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
  							<td align='center'><?php echo ($main['acc_type'] == 'd' ? 'Debet' : 'Kredit'); ?>&nbsp;</td>
  							<td><?php echo $main['uraian']; ?>&nbsp;</td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
			</form>
  		</div>
  		<!-- END : Content -->
