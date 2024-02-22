  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a class='act-button' href="javascript: openPop('akun/arusKas/report/<?php echo $filter; ?>/<?php echo $keyword; ?>', 'report');">
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
							<th>Aktivitas</th>
  							<th>Uraian</th>
  							<th>Kode Akun</th>
							<th width='100'>Urutan</th>
							<th width='100'>Kalkulasi</th>
							<th width='100'>Kalibrasi</th>
						</tr>		
  					</thead>
  					<tbody>
  						<?php
							$aktivitas = '';
							
  							$i = $s4b_paging['start'];
  							foreach ($arr_kas as $kas) {
								$len = strlen(trim($kas['order_number'], '0'));
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
							<?php 
								switch ($kas['order_number']) {
									case 110 :
										$aktivitas = 'AKTIVITAS OPERASI';
										break;
									case 210 :
										$aktivitas = 'AKTIVITAS INVESTASI';
										break;
									case 310 :
										$aktivitas = 'AKTIVITAS PENDANAAN';
										break;
									case 410 :
										$aktivitas = 'KENAIKAN/PENURUNAN BERSIH';
										break;
									case 510 :
										$aktivitas = 'SALDO AWAL';
										break;
									case 610 :
										$aktivitas = 'SALDO AKHIR';
										break;
									default :
										$aktivitas = '';
								}
							?>
							<td><?php echo $aktivitas; ?>&nbsp;</td>
  							<td><?php echo str_repeat("&nbsp;", (($len - 1) * 5)) . $kas['uraian']; ?>&nbsp;</td>
  							<td><?php echo $kas['coa_range']; ?>&nbsp;</td>
							<td align='center'><?php echo $kas['order_number']; ?>&nbsp;</td>
							<td align='center'><?php echo $kas['kalkulasi']; ?>&nbsp;</td>
							<td align='right'><?php echo $kas['kalibrasi']; ?>&nbsp;</td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
			</form>
  		</div>
  		<!-- END : Content -->
