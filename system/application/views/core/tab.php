		<!-- BEGIN : Tab Container -->
		<div id='tab-container'>
			<?php
				$url_active = 'core/main/blank';
				
				if (count($arr_tab) > 0) {
					foreach ($arr_tab as $tab) {
			?>
			<div <?php echo (($tab['flag_active'] == 't') ? "class='active'" : ''); ?>>
				<a title='<?php echo $tab['note']; ?>' href='<?php echo site_url($tab['url']); ?>' target='tab-iframe'><?php echo str_replace(' ', '&nbsp;', str_pad($tab['tab'], 10, ' ', STR_PAD_BOTH)); ?></a>
			</div>
			<?php
						if ($tab['flag_active'] == 't') {
							if ($url_active == 'core/main/blank')
								$url_active = $tab['url'];
							else
								show_error('Terdapat lebih dari 1 tab yang aktif.');
						}
					}
				} else {
			?>
			<div class='active'>
				<a title='<?php echo $tab['note']; ?>' href='core/main/blank' target='tab-iframe'><?php echo str_replace(' ', '&nbsp;', str_pad('', 10, ' ', STR_PAD_BOTH)); ?></a>
			</div>
			<?php
				}
			?>
		</div>
		<!-- END : Tab Container -->
		<!-- BEGIN : Tab Iframe -->
		<div id='list-container'>         
			<iframe id='tab-iframe' src='<?php echo site_url($url_active); ?>' frameborder='0' name='tab-iframe'></iframe>
		</div>
		<!-- END : Tab Iframe -->