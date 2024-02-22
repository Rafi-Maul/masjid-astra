		<?php $ci =& get_instance(); ?>
		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='akun/coa/addAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Klasifikasi</td>
							<td class='input'>
								<select name='id_akdd_main_coa' class='required' onchange='javascript: rubahKlasifikasi(this);'>
									<option value=''>-- Pilih Klasifikasi --</option>
									<?php foreach ($arr_main as $main) { ?>
									<option value='<?php echo $main['id_akdd_main_coa']; ?>'><?php echo $main['uraian']; ?></option>
									<?php } ?>
								</select>
							</td>
						</tr>							
						<tr>
							<td class='label'>Level</td>
							<td class='input'>
								<select name='id_akdd_level_coa' class='required' onchange='javascript: rubahLevel(this);'>
									<option value=''>-- Pilih Level --</option>
									<?php
										$str_json = '{';
										$str_json2 = '{'; 
										$max_level = 0; 
										$max_length = 0;
										foreach ($arr_level as $level) { 
											if ($str_json != '{')
												$str_json .= ',';
											$str_json .= $level['level_number'] . ' : ' . $level['level_length'];
											if ($str_json2 != '{')
												$str_json2 .= ',';
											$str_json2 .= $level['level_number'] . ' : ' . $level['id_akdd_level_coa'];
									?>
									<option value='<?php echo $level['level_number']; ?>'><?php echo $level['level_number']; ?></option>
									<?php
											$max_level = max($max_level, $level['level_number']); 
											$max_length += $level['level_length'];
										} 
										$str_json .= '}';
										$str_json2 .= '}';
									?>
								</select>
							</td>
						</tr>							
						<tr>
							<td class='label'>Akun Induk</td>
							<td class='input'>
								<select name='id_akdd_detail_coa_ref' class='required' disabled>
									<option value=''>-- Pilih Akun Induk --</option>
								</select>
							</td>
						</tr>							
						<tr>
							<td class='label'>Kode Akun</td>
							<td class='input'><input type='text' name='coa_number' class='required coa-number' readonly/></td>
						</tr>							
						<tr>
							<td class='label'>Uraian</td>
							<td class='input'>
								<textarea name='uraian' rows='3' cols='45' class='required'></textarea>
							</td>
						</tr>							
						<tr>
							<td class='label'>Klasifikasi Aktiva Bersih</td>
							<td class='input'>
								<select name='id_akdd_klasifikasi_modal' class='required' disabled>
									<option value=''>-- Pilih Tipe Aktiva --</option>
									<?php foreach ($arr_modal as $modal) { ?>
									<option value='<?php echo $modal['id_akdd_klasifikasi_modal']; ?>'><?php echo $modal['klasifikasi']; ?></option>
									<?php } ?>									
								</select>
							</td>
						</tr>	
						<tr>
							<td class='label'>Sub COA</td>
							<td class='input'>
								<textarea name='sub_coa' rows='3' cols='45' class='required' disabled></textarea>
							</td>
						</tr>													
						<tr>
							<td class='label'>Muncul di Jurnal</td>
							<td class='input'>
								<select name='flag_mapping' class='required' disabled>
									<option value='0'>Jurnal Umum</option>
									<option value='1'>Jurnal Umum + Jurnal Penerimaan</option>
									<option value='2'>Jurnal Umum + Jurnal Penyaluran</option>
									<option value='3'>Semua Jurnal</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='max_level' value='<?php echo $max_level; ?>'/>
								<input type='hidden' name='total_length' value='<?php echo $max_length; ?>'/>
								<input type='hidden' name='level_length'/>
								<input type='hidden' name='id_akdd_level_coa2'/>
							</td>
						</tr>	
						<tr>
							<td class='button-space' colspan='2'>
								<input type='submit' name='submit' onclick='javascript: return submitReqForm(this);' value='Submit'/>
								&nbsp;&nbsp;&nbsp;
								<input type='reset' name='reset' value='Reset' onclick='javascript: refreshPage();'/>
							</td>
						</tr>																							
					</tbody>
				</table>
			</form>
		</div>
		<script language='javascript' type='text/javascript'>
			<!--
			var str_json = <?php echo $str_json; ?>;
			var str_json2 = <?php echo $str_json2; ?>;
			var max_level = <?php echo $max_level; ?>;
					
			function rubahKlasifikasi(elm) {
				var level;
				
				resetAkunInduk();
				
				level = $("form#main-form select[name='id_akdd_level_coa']").val();
				
				setAkunInduk(elm.value, level);				
			}
			
			function rubahLevel(elm) {
				var level, id_akdd_main_coa;
				
				resetAkunInduk();
				$("form#main-form input[name='coa_number']").val('');
				$("form#main-form input[name='coa_number']").attr('readonly', 'readonly');
				
				level 			 = elm.value;
				id_akdd_main_coa = $("form#main-form select[name='id_akdd_main_coa']").val();
				
				if (level != '') {
					$("form#main-form input[name='coa_number']").attr('maxlength', str_json[level]);
					$("form#main-form input[name='coa_number']").removeAttr('readonly');
					$("form#main-form input[name='level_length']").val(str_json[level]);
					$("form#main-form input[name='id_akdd_level_coa2']").val(str_json2[level]);
				} else {
					$("form#main-form input[name='level_length']").val('');
					$("form#main-form input[name='id_akdd_level_coa2']").val('');
				}
						
				setAkunInduk(id_akdd_main_coa, level);
				
				// Bayu 2010-10-18 22:17
				if (level == max_level)
					$("form#main-form select[name='flag_mapping']").attr('disabled', false);
			}
			
			function resetAkunInduk() {
				$('option[value!=\'\']', $("form#main-form select[name='id_akdd_detail_coa_ref']")).remove();				
				$("form#main-form select[name='id_akdd_detail_coa_ref']").attr('disabled', 'disabled');
				$("form#main-form select[name='id_akdd_klasifikasi_modal']").attr('disabled', 'disabled');
				$("form#main-form textarea[name='sub_coa']").attr('disabled', 'disabled');
				$("form#main-form select[name='flag_mapping']").attr('disabled', true);
			}
			
			function setAkunInduk(id_akdd_main_coa, level) {
				if ((id_akdd_main_coa != '') && (level != '')) {
					if (level > 1) {
						$.post('akun/coa/getInduk', {id_akdd_main_coa : id_akdd_main_coa, level_number : level}, function(data) {
							$(data).each(function() {
								$("form#main-form select[name='id_akdd_detail_coa_ref']").append('<option value=\'' + this.id_akdd_detail_coa + '\'>' + this.uraian + '</option>');
							});
							$("form#main-form select[name='id_akdd_detail_coa_ref']").removeAttr('disabled');
						}, 'json');
						
						if ((level == max_level) && (id_akdd_main_coa == <?php echo $ci->getIDModal(); ?>)) {
							$("form#main-form select[name='id_akdd_klasifikasi_modal']").removeAttr('disabled');
							$("form#main-form textarea[name='sub_coa']").removeAttr('disabled');	
						}
					}				
				} else 
					$("form#main-form input[name='coa_number']").attr('maxlength', 0);
			}
			
			
			//-->
		</script>
		<!-- END : Process Form -->