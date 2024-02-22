<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>
<html>
  	<head>
  		<meta http-equiv='content-type' content='text/html; charset=windows-1250'>
  		<meta name='generator' content='PSPad editor, www.pspad.com'>
  		<title>Expired !!!</title>
		<base href='<?php echo base_url(); ?>'/>
  	</head>
  	<body>
  		<?php
  			$ci =& get_instance();
  			$s4b = $ci->config->item('s4b');
  			$login_page = site_url($s4b['login_page']);
  		?>
		<script language='javascript' type='text/javascript'>
			window.onload = function() {			
				if (opener) {
					if (opener.top.showExpired)
						opener.top.showExpired = false;
					else
						return;
				} else {
					if (top.showExpired)
						top.showExpired = false;
					else
						return;
				}
		
				alert('<?php echo $s4b['expired_msg']; ?>');
		
				if (opener) {
					opener.top.location.replace('<?php echo $login_page; ?>');
					close();
				} else {
					top.location.replace('<?php echo $login_page; ?>');
				}
			}
		</script>
  	</body>
</html>