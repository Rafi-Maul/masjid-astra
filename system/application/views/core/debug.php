		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'>Informasi Debug</a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='core/main/debugAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>
						<tr>
							<td class='label'>&nbsp;</td>
							<td class='input'>&nbsp;</td>
						</tr>									
						<tr>
							<td class='label'>Sessi Debug</td>
							<td class='input' width='250'>
								<?php if (empty($xdebug)) { ?>
									<input type='hidden' name='XDEBUG_SESSION_START' value='open-solutions-xdebug'/>
									<input type='submit' name='submit' value='Aktifkan Sessi Debug : open-solutions-xdebug'/>
								<?php } else { ?>
									<input type='submit' name='XDEBUG_SESSION_STOP' value='Non Aktifkan Sessi Debug : <?php echo $xdebug; ?>'/>
								<?php } ?>
							</td>							
						</tr>		
						<tr>
							<td class='label'>&nbsp;</td>
							<td class='input'>&nbsp;</td>
						</tr>			
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>																			
					</tbody>
				</table>
			</form>
		</div>
		<!-- END : Process Form -->