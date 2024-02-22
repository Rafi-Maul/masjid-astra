		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='core/group/editAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Group</td>
							<td class='input'><input type='text' name='group_name' value='<?php echo $group['group_name']; ?>' class='required' size='45'/></td>
						</tr>							
						<tr>
							<td class='label'>Keterangan</td>
							<td class='input'>
								<textarea name='note' rows='3' cols='45'><?php echo $group['note']; ?></textarea>
							</td>
						</tr>	
						<tr>
							<td class='label' colspan='2'>
								<input type='hidden' name='id_dd_groups' value='<?php echo $group['id_dd_groups']; ?>'/>
								<input type='hidden' name='page' value='<?php echo $page; ?>'/>
								<input type='hidden' name='filter' value='<?php echo $filter; ?>'/>
								<input type='hidden' name='keyword' value='<?php echo $keyword; ?>'/>																								
							</td>
						</tr>	
						<tr>
							<td class='button-space' colspan='2'>
								<input type='submit' name='submit' onclick="javascript: return submitReqForm(this, true);" value='Submit'/>
								&nbsp;&nbsp;&nbsp;
								<input type='reset' name='reset' value='Reset' onclick='javascript: refreshPage();'/>
							</td>
						</tr>																							
					</tbody>
				</table>
			</form>
		</div>
		<!-- END : Process Form -->