		<!-- BEGIN : Tab Container -->
		<div id="tab-container">
			<div class='active'>
				<a href='javascript:dummy();'><?php echo $title; ?></a>
			</div>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Process Form -->
		<div id='process-form'>
			<form id='main-form' name='main-form' method='post' action='/akun/level/addAct'>
				<table id='tbl-top' border='0' cellpadding='0' cellspacing='0'>
					<tbody>
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>						
						<tr>
							<td class='label'>Level</td>
							<td class='input'><input type='text' name='level_number' class='required number'/></td>
						</tr>							
						<tr>
							<td class='label'>Besar</td>
							<td class='input'><input type='text' name='level_length' class='required number'/></td>
						</tr>							
						<tr>
							<td class='label'>Uraian</td>
							<td class='input'><input type='text' name='uraian' class='required' size='45'/></td>
						</tr>							
						<tr>
							<td class='label' colspan='2'>&nbsp;</td>
						</tr>	
						<tr>
							<td class='button-space' colspan='2'>
								<input type='submit' name='submit' onclick="javascript: return submitReqForm(this);" value='Submit'/>
								&nbsp;&nbsp;&nbsp;
								<input type='reset' name='reset' value='Reset' onclick='javascript: refreshPage();'/>
							</td>
						</tr>																							
					</tbody>
				</table>
			</form>
		</div>
		<!-- END : Process Form -->