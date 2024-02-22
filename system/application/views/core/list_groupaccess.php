  		<!-- BEGIN : Act Bar -->
  		<div id='act-bar'>
  			<div class='non-print-act'>
				<?php if ($s4b_password->getAccess('proses')) { ?>								
				<a class='act-button' href='javascript: processAccess();'>
					<img src='<?php echo $img_folder; ?>/reload.gif' border='0' alt='Proses' align='absmiddle'/>Proses
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
							  <option value='1' <?php if ($filter == 1) { ?>selected<?php } ?>>Group</option>							
							</select>
						</td>
						<td>
							<select name='keyword'>
								<option value=''>-- Pilih Group --</option>
								<?php foreach ($arr_groups as $group) { ?>
								<option value='<?php echo $group['id_dd_groups']; ?>' <?php if ($group['id_dd_groups'] == $keyword) { ?>selected<?php } ?>><?php echo $group['group_name']; ?></option>
								<?php } ?>
							</select>				
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
  		<div id='content'  class='loading'>
  			<form id='main-form' method='post' action='core/groupAccess/process'>
  				<table id='tbl' width='110%' border='0' cellpadding='3' cellspacing='0'>
  					<thead>
  						<tr>
  							<th class='th-no'>No.</th>
  							<th width='100'>Modul</th>
  							<th width='100'>Menu</th>
  							<th width='150'>Sub Menu</th>
  							<th width='150'>Tab</th>
							<th>Hak Akses</th>
						</tr>		
  					</thead>
  					<tbody>
  						<?php
  							$i = 0;
  							foreach ($arr_moduls as $modul) {
  						?>
  						<tr>
  							<td class='td-no'><?php echo ++$i; ?>.</td>
  							<td><?php echo $modul['modul']; ?>&nbsp;</td>
  							<td><?php echo $modul['menu']; ?>&nbsp;</td>
  							<td><?php echo $modul['sub_menu']; ?>&nbsp;</td>
  							<td><?php echo $modul['tab']; ?>&nbsp;</td>
							<td align='left'>
								<?php 
									foreach ($arr_access as $access) {
										$flag_active = (($access['access_code'] & $modul['access_code']) == $access['access_code']); 
								?>
								<input style='cursor: pointer;' <?php if ($flag_active) { ?>checked<?php } ?> onclick='javascript: setCode(this, <?php echo $access['access_code']; ?>, <?php echo $i; ?>);'  type='checkbox'/>&nbsp;<?php echo ucfirst($access['access_name']); ?>
								&nbsp;&nbsp;&nbsp;
								<?php 
									} 
								?>
								<input type='hidden' name='id_dd_tabs[]' value='<?php echo $modul['id_dd_tabs'];?>'/>
								<input id='code_<?php echo $i; ?>' type='hidden' name='access_code[]' value='<?php echo $modul['access_code']; ?>'/>
							</td>
  						</tr>  						
  						<?php
  							}  						
  						?>
  					</tbody>
				</table>
				<input type='hidden' name='id_dd_groups' value='<?php echo $keyword; ?>'/>
				<input type='hidden' name='filter' value='<?php echo $filter; ?>'/>
				<input id='submit-form' type='submit' name='submit' value='Submit' onclick="javascript: return submitReqForm(this);" style='display: none;'/>
			</form>
  		</div>
  		<script language='javascript' type='text/javascript'>
  			<!--
  			function processAccess() {
  				/*
  				if (confirm('Anda yakin untuk memproses data-data ini ?')) {
  					$('form#main-form').submit();	
  				} else
  					return false;
  				*/
  				$('#submit-form').click();
  			}
  			
  			function setCode(elm, code, no) {
				var access_code;
				
				access_code = $('#code_' + no).val();
				if (elm.checked)
					access_code = access_code | code;
				else
					access_code = access_code ^ code;
				$('#code_' + no).val(access_code);
  			}
  			//-->
  		</script>
  		<!-- END : Content -->
