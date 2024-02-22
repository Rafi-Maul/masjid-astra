  		<!-- BEGIN : Modul Title -->
  		<div id='mod-title'><?php echo ((count($arr_menu) > 0) ? $arr_menu[0]['modul'] : ''); ?></div>
  		<!-- END : Modul Title -->
  		<!-- BEGIN : Menu -->
  		<div id='content-menu'>
  			<?php
  				$i = 0;
  				$id_dd_menus = 0;
  				foreach ($arr_menu as $menu) {
  					if ($id_dd_menus != $menu['id_dd_menus']) {
  						$id_dd_menus = $menu['id_dd_menus'];
  						if ($i > 0) {
  			?>
  			</div>
  			<?php
  						}
  			?>
  			<a class='menu-item' title='<?php echo $menu['note']; ?>' href='javascript:dummy();'><?php echo strtoupper($menu['menu']); ?></a>
			<div class='sub-menu-items'>  			
  			<?php
  					}
  			?>
				<a title='<?php echo $menu['sub_note']; ?>' href="<?php echo site_url("core/main/tab/".$menu['id_dd_sub_menus']);?>" target='main-frame'><?php echo $menu['sub_menu']; ?></a>
  			<?php
  					$i++;
  				}
  			?>
  			</div>
  		</div>
		<!-- END : Menu -->  		
