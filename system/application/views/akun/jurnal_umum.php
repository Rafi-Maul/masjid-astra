  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='non-print-act'>
  				<?php if ($s4b_password->getAccess('tambah')) { ?>
				<a class='act-button' href='javascript: jurnalBaru();'>
					<img src='<?php echo $img_folder; ?>/add.gif' border='0' alt='Tambah' align='absmiddle'/>Baru
				</a>
				<?php if (is_numeric($id_akmt_periode) && false) { ?>
				<a class='act-button' href='javascript: simpanJurnal();'>
					<img src='<?php echo $img_folder; ?>/save.gif' border='0' alt='Simpan' align='absmiddle'/>Simpan
				</a>
				<?php } ?>
				<?php } ?>				
				<?php if (($s4b_password->getAccess('hapus')) && (is_numeric($id_akmt_jurnal)) && ($flag_temp != 2)) { ?>
				<a class='act-button' href='javascript: hapusJurnal();'>
					<img src='<?php echo $img_folder; ?>/del.gif' border='0' alt='Hapus' align='absmiddle'/>Hapus Jurnal
				</a>
				<?php } ?>
  				<?php if (($s4b_password->getAccess('tambah')) && (is_numeric($id_akmt_jurnal)) && ($flag_temp != 2) && false) { ?>
				<a class='act-button' href="javascript: openPop('akun/jurnal/add/<?php echo $id_akmt_jurnal; ?>', 'tambah');">
					<img src='<?php echo $img_folder; ?>/add.gif' border='0' alt='Tambah' align='absmiddle'/>Tambah Akun
				</a>
				<?php } ?>
				<?php if (($s4b_password->getAccess('hapus')) && (!empty($arr_detail)) && ($flag_temp != 2)) { ?>
				<a class='act-button' href='javascript: hapusJurnalDetail();'>
					<img src='<?php echo $img_folder; ?>/del.gif' border='0' alt='Hapus' align='absmiddle'/>Hapus Akun
				</a>
				<?php } ?>				
  			</div>
  			<div class='print-act'>
  				<?php if (($s4b_password->getAccess('cetak')) && ($flag_temp == 2)) { ?>
				<a class='act-button' href="javascript: openPop('akun/jurnal/voucher/<?php echo $id_akmt_jurnal; ?>', 'report');">
					<img src='<?php echo $img_folder; ?>/print.gif' border='0' alt='Laporan' align='absmiddle'/>Bukti Pembukuan
				</a>
				<?php } ?>
  			</div>
  		</div>
  		<!-- END : Act Bar -->
  		<!-- BEGIN : Top Form -->
  		<div id='top-form'>
			<form id='search-form' name='search-form' action='<?php echo site_url($this->uri->uri_string()); ?>' method='post'>
				<table border='0' cellspacing='0' cellpadding='2' style='margin: 5px;'>
					<tbody>
						<tr>
							<td class='label'>Cari No. Bukti</td>
							<td class='input'><input type='text' name='search_bukti'/></td>
							<td class='input' colspan='2'><input type='button' name='search' value='Cari !' class='submit01' onclick='javascript: cariJurnal(this);'/></td>
						</tr>
						<tr>
							<td class='label'>&nbsp;</td>
							<td class='input' colspan='3'>
								<select id='pilih_bukti' name='pilih_bukti' onchange='javascript: pilihBukti(this);'>
									<option value=''>-- Pilih No. Bukti --</option>
								</select>
							</td>
						</tr>
					</tbody>
					<tbody style='background: #E2E8EE;'>
						<tr>
							<td class='label' colspan='4'>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>Kodifikasi</td>
							<td class='input'>
								<select name='kodifikasi' class='required'>
									<option value=''>-- Pilih Kodifikasi --</option>
									<?php foreach ($arr_kodifikasi as $kode) { ?>
									<option value='<?php echo $kode['kode']; ?>' <?php if (!empty($no_bukti)) { if (substr($no_bukti, 0, 2) == $kode['kode']) { ?>selected<?php } }; ?>><?php echo $kode['kode'] . ' - ' . $kode['notes']; ?></option>
									<?php } ?>
								</select>
							</td>
							<td class='label'>Keterangan</td>
							<td class='input' rowspan='4'>
								<textarea name='uraian' rows='3' cols='45' class='required'><?php echo $uraian; ?></textarea>
							</td>														
						</tr>	
						<tr>
							<td class='label'>Nomor Bukti</td>
							<td class='input' colspan='2'><input type='text' name='no_bukti' style='background: none; border: none;' value='<?php echo $no_bukti; ?>' readonly /></td>
						</tr>
						<tr>
							<td class='label'>Tanggal Transaksi</td>
							<td class='input' colspan='2'>
								<?php 
									if (empty($tgl_transaksi)) {
										$day   = '';
										$month = '';
										$year  = '';
									} else {
										$day   = substr($tgl_transaksi, -2);
										$month = substr($tgl_transaksi, 5, 2);
										$year  = substr($tgl_transaksi, 0, 4);
									}
									setInputDate('tgl_transaksi', 1, 1, $day, $month, $year); 
								?>
							</td>
						</tr>
						<tr>
							<td class='label'>Selisih</td>
							<td class='input' colspan='2'><input type='text' id='selisih' name='selisih' readonly style='background: none; border: none;' value='N/A'/></td>
						</tr>	
						<tr>
							<td class='label' colspan='4'>&nbsp;</td>
						</tr>							
					</tbody>
				</table>
				<input type='hidden' name='id_akmt_jurnal' value='<?php echo $id_akmt_jurnal; ?>'/>
				<input type='hidden' name='metodenya' value='<?php echo $metodenya; ?>'/><!--  -->
				<input type='hidden' name='prev_transaksi' value='<?php echo $tgl_transaksi; ?>'/>				
			</form>  		
  		</div>
  		<!-- END : Top Form -->
		<div id='' class='' style="">
			<form id='formdet' method='post' action='akun/jurnal/addGabung'>
				<table border='0' cellspacing='0' cellpadding='2' style='margin: 5px;'>
					<tbody>
						<tr>
							<td class='label'>Cari Kode Akun</td>
							<td class='input'><input type='text' name='cari_kode'/>&nbsp;<input type='button' name='button_cari_code' value='Cari' class='submit01' onclick='javascript: searchCOA(this);'/></td>
							<td style="width:20px;">&nbsp;</td>
							<td class='label'>Nominal</td>
							<td class='input'><input type='text' name='jumlah' class='<?php echo $required; ?> number'/></td>
						</tr>
						<tr>
							<td class='label'>&nbsp;</td>
							<td class='input'>
								<select id='id_akdd_detail_coa' name='id_akdd_detail_coa' class='<?php echo $required; ?>'>
									<option value=''>-- Pilih Kode Akun --</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td class='label'>Posisi</td>
							<td class='input'>
								<select name='flag_position' class='<?php echo $required; ?>'>
									<option value=''>-- Pilih Posisi --</option>
									<option value='d'>Debet</option>
									<option value='k'>Kredit</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class='label' colspan='5'>
							</td>
						</tr>	
						<tr>
							<td class='button-space' colspan='5' style="text-align:center;">
								<input type='submit' name='submit' onclick="javascript: return simpanJurnal(this);" value='Submit' style="font-weight:bold;" <?php echo (!is_numeric($id_akmt_periode) || $flag_temp == 2)?'disabled':''; ?> />
							</td>
						</tr>
					</tbody>
				</table>
				<input type='hidden' name='id_akmt_jurnal' value='<?php echo $id_akmt_jurnal; ?>'/>
				<input type='hidden' name='metodenya' value='<?php echo $metodenya; ?>'/>
				<div id="hiddendiv" style="display:none;" />
			</form>
   		</div>
 		<!-- BEGIN : Content -->
  		<div id='content' class='loading'>
  			<form id='main-form' method='post' action=''>
  				<table id='tbl' width='100%' border='0' cellpadding='3' cellspacing='0'>
  					<thead>
  						<tr>
  							<th class='th-no'>No.</th>
  							<th class='th-check'><input type='checkbox' onclick='javascript:checkItAll(this)'/></th>
  							<th class='th-edit'>Edit</th>
  							<th>Kode Perkiraan</th>
  							<th width='150'>Debet</th>
							<th width='150'>Kredit</th>
						</tr>		
  					</thead>
  					<tbody>
  						<?php
							$balans = 0;
  							$i = 0;
  							foreach ($arr_detail as $detail) {
								$jumlah_debet  = ($detail['flag_position'] == 'd' ? numFormat($detail['jumlah']) : '-');
								$jumlah_kredit = ($detail['flag_position'] == 'k' ? numFormat($detail['jumlah']) : '-');
								$balans += ($detail['jumlah'] * ($detail['flag_position'] == 'd' ? 1 : -1));
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
  							<td class='td-check'><input type='checkbox' name='id_list[]' value='<?php echo $detail['id_akmt_jurnal_det']; ?>'/></td>
  							<td class='td-edit'>
  								<?php if (($s4b_password->getAccess('edit')) && ($flag_temp != 2)) { ?>
							  	<a href="javascript: openPop('akun/jurnal/edit/<?php echo $metodenya; ?>/<?php echo $detail['id_akmt_jurnal_det']; ?>/<?php echo $id_akmt_jurnal; ?>', 'edit');"><img src='<?php echo $img_folder; ?>/edit.gif' border='0' alt='Edit'/></a>
							  	<?php } else { ?>
							  	&nbsp;
							  	<?php } ?>
							</td>
							<td><?php echo $detail['coa_number'] . ' - ' . $detail['uraian']; ?></td>
  							<td align='right'><?php echo $jumlah_debet; ?>&nbsp;</td>
  							<td align='right'><?php echo $jumlah_kredit; ?>&nbsp;</td>
  						</tr>
  						<?php
  							}
  						?>
  					</tbody>
				</table>
				<input type='hidden' name='id_akmt_jurnal' value='<?php echo $id_akmt_jurnal; ?>'/>
				<input type='hidden' name='metodenya' value='<?php echo $metodenya; ?>'/>
			</form>
  		</div>
		<script language='javascript' type='text/javascript'>
			<!--
			function afterInit() {
				$('input#selisih').val('<?php echo ($balans < 0 ? '-' : '') . numFormat(abs($balans)); ?>');
				
				<?php if ($redirect == 1) { ?>
				var tabContentElm = parent.tabContentElm;
				
				$('div', tabContentElm).removeClass('active');
				$('div:first', tabContentElm).addClass('active');
				<?php } ?>
			}
			
			function jurnalBaru() {
				if (confirm('Anda yakin untuk membuat jurnal baru ?')) { 
					var x = $('#main-form input[name=metodenya]').val();
					switch(x) {
						case 'terima':
						case 'keluar':
							location.replace('akun/jurnal/' + x);
							break;
						default:
							location.replace('akun/jurnal');
						
					}
				}						
			}
			
			function simpanJurnal(elm) {
				var oForm, eForm, c, d;
				<?php echo !is_numeric($id_akmt_periode)?'alert("Periode tidak valid!");return false;':''; ?>
				
				eForm = document.getElementById('formdet');
				oForm = document.getElementById('search-form');
				d = document.getElementById('hiddendiv');
				
				// Cek tanggal tidak boleh melebihi tanggal hari ini
				var tglini = '<?php echo date('Ymd'); ?>';
				var tgl = document.getElementById('tgl_transaksi').value.replace(/-/g, '');
				if (tgl > tglini) {
					alert('Tanggal tidak boleh melebihi tanggal hari ini');
					return false;
				}
				
				// Cek! Kalo kode akun, nominal, atau posisi salah satunya diisi maka harus diisi semua. Kalo dikosongin semua juga gpp.
				if ($('[name=id_akmt_jurnal]').val()!='') {
					if ($('[name=jumlah]').val()!='' || $('[name=id_akdd_detail_coa]').val()!='' || $('[name=flag_position]').val()!='') {
						$('[name=jumlah]').addClass('required');
						$('[name=id_akdd_detail_coa]').addClass('required');
						$('[name=flag_position]').addClass('required');
					}
				}
				
				if (!validateReqForm(oForm)) return false;
				if (!validateReqForm(eForm)) return false;
				
				if (confirm('Apakah anda yakin menyimpan jurnal ini ?')) {
					$('form#search-form input, form#search-form select, form#search-form textarea').each(function(i, j) {
						c = j.cloneNode(true);
						if (j.tagName == 'SELECT') c.selectedIndex = j.selectedIndex;
						else if (j.tagName == 'TEXTAREA') c.value = j.value;
						d.appendChild(c);
					});
					return true;
				} else {
					return false;
				}
			}
			
			function hapusJurnal() {
				var oForm;
				
				if (confirm('Anda yakin untuk menghapus jurnal ini ?')) {
					$('form#search-form').attr('action', 'akun/jurnal/del').submit();
				}
			}
			
			function hapusJurnalDetail() {
				if (confirm('Anda yakin untuk menghapus kode-kode perkiraan ini ?')) {
					$('form#main-form').attr('action', 'akun/jurnal/delSub').submit();
				}
			}
			
			function cariJurnal(elm) {
				var oForm;
								
				oForm = elm.form;
				$('option[value!=\'\']', $('select#pilih_bukti')).remove();
				if (oForm.search_bukti.value != '') {
					var url = "<?php echo site_url('akun/service/getJurnal');?>";
					$.post(url, {no_bukti : oForm.search_bukti.value, metodenya: oForm.metodenya.value}, function(data) {
						$(data).each(function() {
							$('select#pilih_bukti').append('<option value=\'' + this.id_akmt_jurnal + '\'>' + this.no_bukti + '</option>');
						});
					}, 'json');
				}
			}
			
			function pilihBukti(elm) {
				var oForm;
				
				oForm = elm.form;
				if (elm.value != '') {
					oForm.action = '<?php echo site_url($this->uri->uri_string()); ?>';
					oForm.id_akmt_jurnal.value = elm.value;
					oForm.submit();
				}
			}
			
			function searchCOA(elm) {
				var oForm;
				
				oForm = elm.form;
				//$('form#main-form').css('visibility', 'hidden');
				$('option[value!=\'\']', $('select#id_akdd_detail_coa')).remove();
				$.post('akun/service/getCOA', {coa_uraian : oForm.cari_kode.value, metodenya: oForm.metodenya.value}, function(data) {
					$(data).each(function() {
						$('select#id_akdd_detail_coa').append('<option value=\'' + this.id_akdd_detail_coa + '\'>' + this.coa_uraian + '</option>');
						//alert(this.id_akdd_detail_coa + "\n" + this.coa_uraian);
					});
										
					//$('form#main-form').css('visibility', 'visible');
				}, 'json');				
			}
			//-->
		</script>
  		<!-- END : Content -->
