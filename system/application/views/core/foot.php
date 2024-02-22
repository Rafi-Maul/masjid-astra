  		<?php
  			if (!empty($arr_paging)) {
  		?>
		<!-- BEGIN : Foot Content -->
  		<div id='foot-content'>
  			<div id='left-side'>
  				<table border='0' cellpadding='0' cellspacing='0'>
  					<tr>
  						<td>
							<button class='submit02' <?php if ($arr_paging['page'] == 1) { ?>disabled<?php } ?> onclick='javascript: paging(1);'>
								<img src='<?php echo $img_folder; ?>/first.gif'/>
							</button>  						
						</td>
  						<td>
							<button class='submit02' <?php if ($arr_paging['page'] == 1) { ?>disabled<?php } ?> onclick='javascript: paging(<?php echo max(1, ($arr_paging['page'] - 1));?>);'>
								<img src='<?php echo $img_folder; ?>/prev.gif'/>
							</button>  						
						</td>
						<td><div class='page-info'>Halaman <?php echo $arr_paging['page']; ?> dari <?php echo $arr_paging['total_pages']; ?></div></td>
  						<td>
							<button class='submit02' <?php if ($arr_paging['page'] == $arr_paging['total_pages']) { ?>disabled<?php } ?> onclick='javascript: paging(<?php echo min($arr_paging['total_pages'], ($arr_paging['page'] + 1)); ?>);'>
								<img src='<?php echo $img_folder; ?>/next.gif'/>
							</button>  						
						</td>
  						<td>
							<button class='submit02' <?php if ($arr_paging['page'] == $arr_paging['total_pages']) { ?>disabled<?php } ?> onclick='javascript: paging(<?php echo $arr_paging['total_pages']; ?>);'>
								<img src='<?php echo $img_folder; ?>/last.gif'/>
							</button>  						
						</td>
						<td id='records-count'>
							Terdapat <span><?php echo $arr_paging['total_rows']; ?></span> Data
						</td>						
  					</tr>
  				</table>
  			</div>
  			<div id='right-side'>
				<form id='paging-form' action='<?php echo site_url($this->uri->uri_string()); ?>' method='post'>
					<table border='0' cellpadding='0' cellspacing='0'>
						<tr>
							<td class='go-info'>Ke Halaman</td>
                            <td class='go-page'>
								<select name='page' id='s4b-page'>
									<?php for ($i = 1; $i <= $arr_paging['total_pages']; $i++) { ?>
									<option value='<?php echo $i; ?>' <?php echo (($i == $arr_paging['page']) ? 'selected' : ''); ?>><?php echo $i; ?></option>
									<?php } ?>
								</select>
							</td>
							<td>
								<button class='submit02' onclick='this.form.submit()'><img src='<?php echo $img_folder; ?>/last.gif'></button>					
							</td>
						</tr>
					</table>
					<?php
						if (count($hidden_vars) > 0) {
							reset($hidden_vars);
							foreach ($hidden_vars as $key => $value) {
					?>
					<input type='hidden' name='<?php echo $key; ?>' value='<?php echo $value; ?>'/>
					<?php
							}
						}
					?>
				</form>			
  			</div>
  		</div>
  		<!-- END : Foot Content -->	
		<?php
			}
		?>	 
		<!-- BEGIN : Script -->
		<script language='javascript' type='text/javascript' src='<?php echo $js_folder; ?>/jquery-1.4.4.min.js'></script>
  		<script language='javascript' type='text/javascript' src='<?php echo $js_folder; ?>/main.js'></script>
		<script language='javascript' type='text/javascript' src='<?php echo $js_folder; ?>/chosen.js'></script>
		<script language='javascript' type='text/javascript'>
			<!--
			<?php 
				if ($s4b_error != false) {
					$s4b_error = explode("\n", $s4b_error);
					foreach ($s4b_error as $error) {
			?>
			s4b_error += "<?php echo str_replace("\"", "\'", $error); ?>\n";
			<?php
					}
				}
			?>
			$(document).ready(function() {
				init();
				$(".chosen-select").chosen();
			});			
			//-->
		</script>		
		<!-- END : Script -->
  	</body>
</html>