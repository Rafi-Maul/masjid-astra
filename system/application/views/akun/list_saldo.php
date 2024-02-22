  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
			<?php if (count($rows) > 0) { ?>
			<?php if ($flag_posted == 0) { ?>
  			<div class='non-print-act'>
				<?php if ($s4b_password->getAccess('proses')) { ?>								
				<a class='act-button' href='javascript: process();'>
					<img src='<?php echo $img_folder; ?>/reload.gif' border='0' alt='Proses' align='absmiddle'/>Proses
				</a>
				<?php } ?>								
  			</div>
			<?php } ?>
  			<div class='print-act'>
  				<?php if ($s4b_password->getAccess('cetak')) { ?>
				<a class='act-button' href="javascript: openPop('akun/saldo/report', 'report');">
					<img src='<?php echo $img_folder; ?>/print.gif' border='0' alt='Laporan' align='absmiddle'/>Laporan
				</a>
				<?php if (is_numeric($id_akmt_periode)) { ?>
				<a class='act-button' href="javascript: openPop('akun/saldo/posisiSaldo/<?php echo $tahun_sa; ?>/0', 'report');">
					<img src='<?php echo $img_folder; ?>/print.gif' border='0' alt='Laporan' align='absmiddle'/>Posisi Saldo
				</a>			
				<?php } ?>
				<?php } ?>
  			</div>
			<?php } ?>
  		</div>
  		<!-- END : Act Bar -->
  		<!-- BEGIN : Top Form -->
  		<div id='top-form'>
			<form name='search-form' action='<?php echo site_url($this->uri->uri_string()); ?>' method='post'>
				<table border='0' cellspacing='0' cellpadding='2'>
					<tr>
						<td>Tahun</td>
						<td>:</td>
						<td>
							<select name='filter' onchange='javascript: rubahTahun(this);' class='required'>
							  <option value=''>-- Pilih Tahun --</option>
							  <?php foreach ($arr_tahun as $tahun) { ?>
							  <option value='<?php echo $tahun; ?>' <?php if ($tahun == $tahun_sa) { ?>selected<?php } ?>><?php echo $tahun; ?></option>
							  <?php } ?>							   
							</select>
						</td>
					</tr>
					<tr>
						<td>Balans</td>
						<td>:</td>
						<td id='balans'></td>
					</tr>					
				</table>
			</form>  		
  		</div>
  		<!-- END : Top Form -->
  		<!-- BEGIN : Content -->
  		<div id='content' class='loading'>
  			<form id='main-form' method='post' action='akun/saldo/process'>
  				<table id='tbl' width='100%' border='0' cellpadding='3' cellspacing='0'>
  					<thead>
  						<tr>
  							<th class='th-no'>No.</th>
  							<th>Kode Perkiraan</th>
							<th width='150'>Nominal</th>  							
						</tr>		
  					</thead>
  					<tbody>
  						<?php
							$nominal_json = '{';
							$balans = 0;							
  							$i = 0;
  							foreach ($rows as $index => $row) {
								$row['akhir'] = is_numeric($row['akhir']) ? $row['akhir'] : 0;
								$balans += $row['akhir'];
								if ($nominal_json != '{') $nominal_json .= ',';
								$nominal_json .= "'{$index}' : [{'nominal' : {$row['akhir']}, 'tipe' : '{$row['acc_type']}'}]";
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
							<td><?php echo $row['coa_number'] . ' - ' . $row['coa_uraian']; ?></td>
  							<td align='center'>
								<input type='hidden' name='id_akdd_detail_coa[]' value='<?php echo $row['id_akdd_detail_coa']; ?>'/>
								<input type='hidden' name='acc_type[]' value='<?php echo $row['acc_type']; ?>'/>
								<input id='nominal_<?php echo $index; ?>' type='text' name='nominal[]' value='<?php echo numFormat($row['akhir'] * ($row['acc_type'] == 'd' ? 1 : -1)); ?>' class='required number'/>
							</td>
  						</tr>  						
  						<?php								
  							}

							$balans = round($balans, 2);
							$nominal_json .= '}';
  						?>
  					</tbody>
				</table>
				<input type='hidden' id='tahun' name='tahun' value='<?php echo $tahun_sa; ?>'/>
				<input type='hidden' name='id_akmt_periode' value='<?php echo $id_akmt_periode; ?>'/>
				<input type='submit' id='submit_button' name='submit' value='submit' style='display: none;' onclick='javascript: return submitReqForm(this);'/>
			</form>
  		</div>
		<script language='javascript' type='text/javascript'>
			<!--
			var nominal_json = <?php echo $nominal_json; ?>;
			var total_json = <?php echo $i; ?>;
			
			function process() {
				if ((parseInt($('td#balans').html().toString().replace(',', '.')) == 0) && ($('input#tahun').val() != '')) {
					//$('input#submit_button').click();
					document.getElementById('submit_button').click();
				} else
					alert("Nilai saldo awal harus balans sebelum diproses!\ndan tahun saldo awal sudah berisi data yang benar!");
			}
			
			function rubahTahun(elm) {
				$("form#main-form input[name='tahun']").val(elm.value);
			}
			
			function afterInit() {						
				$('td#balans').html('<?php echo numFormat($balans); ?>');
				
				// Masih masalah untuk rounded.
				$("form#main-form input[name='nominal[]']").keyup(function() {
					var id, index, nominal, rgxDot;
					
					rgxDot = /\./g
										
					id = $(this).attr('id');
					index = id.substring(8);
					nominal = $(this).val();
					
					nominal_json[index][0].nominal = nominal.replace(rgxDot, '').replace(',', '.');
					
					nominal = 0;
					for (var i = 0; i < total_json; i++) {
						nominal += (nominal_json[i][0].nominal * (nominal_json[i][0].tipe == 'd' ? 1 : -1));
					}
					$('td#balans').html(getFormatNum(roundNumber(nominal, 2)));
				});
				
			}
			//-->
		</script>
  		<!-- END : Content -->
