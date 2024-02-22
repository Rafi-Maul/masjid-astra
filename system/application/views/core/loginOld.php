  		<!-- BEGIN : Head -->
		<div id='app-head'>
			<div id='left-side'> 
				<!-- <div id='h-logo'><img src='<?php echo $img_folder; ?>/logo.gif'/></div> -->
				<div id='h-title'><?php echo $app_name; ?></div>
			</div>		
			<div id='right-side'>
				<div id='h-title'><?php echo strtoupper($company_name); ?></div>
			</div>			
		</div>
  		<!-- END : Head -->
		<!-- BEGIN : Top Separator -->		 	
		<div id='modul'>&nbsp;</div>		
		<!-- END : Top Separator -->  		
		<!-- BEGIN : Form Login -->		 	
		<form id='login-form' method='post' action="<?php echo base_url().'core/main/loginAct';?>">			
			<table id='tbl-login' border='0' cellpadding='0' cellspacing='0' align='right'>
				<tbody>
					<tr>
						<td colspan='2'>&nbsp;</td>
					</tr>													
					<tr>
						<td colspan='2' align='center'><img src='<?php echo $img_folder; ?>/logo.gif' border='0'/></td>
					</tr>
					<tr>
						<td colspan='2'>&nbsp;</td>
					</tr>																							
					<tr>
						<td align='right'>Identitas Pengguna</td>
						<td>
							<?php
								$class_style = '';
								$title = 'Masukan data Identitas Pengguna anda';
								$str_error = str_replace(array('<p>', '</p>', "\n"), '', form_error('id'));
								if (!empty($str_error)) {
									$title = $str_error;
									$class_style = ' red';
								}
							?>
							<input type='text' id='username' name='id' class='text-input<?php echo $class_style; ?>' value='<?php echo set_value('id'); ?>' title='<?php echo $title; ?>'/>
						</td>
					</tr>
					<tr>
						<td align='right'>Kata Kunci</td>
						<td>
							<?php
								$class_style = '';
								$title = 'Masukan data Kata Kunci anda';
								$str_error = str_replace(array('<p>', '</p>', "\n"), '', form_error('pass'));
								if (!empty($str_error)) {
									$title = $str_error;
									$class_style = ' red';
								}
							?>												
							<input type='password' name='pass' class='text-input<?php echo $class_style; ?>' value='<?php echo set_value('pass'); ?>' title='<?php echo $title; ?>'/>
						</td>
					</tr>		
					<tr>
						<td colspan='2'>&nbsp;</td>
					</tr>
					<tr>
						<td colspan='2' align='center'>
							<input type='submit' name='login' value='Login' class='submit01'/>
							&nbsp;&nbsp;&nbsp;
							<input type='reset' name='reset' value='Reset' class='submit01'/>
						</td>
					</tr>	
					<tr>
						<td colspan='2'>&nbsp;</td>
					</tr>
					<tr>
						<td colspan='2'><hr/></td>
					</tr>
					<tr>
						<td colspan='2' align='center'>(C) 2021 Supported by Masjid Astra</td>
					</tr>			
				</tbody>
			</table>
		</form>
		<script language='javascript' type='text/javascript'>
			<!--
			<?php
				if (!empty($gagal_login)) {
			?>
			alert('<?php echo $gagal_login; ?>');
			<?php
				}
			?>
			
			function afterInit() {
				$('input#username').focus();
			}
			//-->
		</script>		
		<!-- END : Form Login -->
