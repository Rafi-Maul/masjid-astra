
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            display: flex;
            justify-content: left;
            align-items: center;
            min-height: 100vh;
            background: url(https://rare-gallery.com/uploads/posts/103520-sultan-ahmed-mosque-turkey-istanbul-sunrise-4k.jpg);
            background-size: cover;
        }

        #login-form{
            padding: 1rem;
            margin-left: 3rem;
            box-shadow: -1px 4px 22px -3px rgba(0,0,0,0.75);
        }

        .form-label, .form-text, .form-check-label, .btn {
            font-size: medium;
        }
        .form-control{
            width: 400px;
        }

        #app-head {
            position: fixed;
            top: 0;
            width: 100%;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        main {
            padding: 20px;
            margin-top: 80px; /* This should be equal to the height of the header plus any padding */
        }
    </style>

<!-- content -->

    <div id="app-head">
        <div id="left-side"> 
            <!-- <div id="h-logo"><img src="<?php echo $img_folder; ?>/logo.gif"/></div> -->
            <div id="h-title"><?php echo $app_name; ?></div>
        </div>		
        <div id="right-side">
            <div id="h-title"><?php echo strtoupper($company_name); ?></div>
        </div>			
    </div>
      <!-- END : Head -->
    <!-- BEGIN : Top Separator -->		 	
    <!-- <div id="modul">&nbsp;</div>	 -->
<!-- Section: Design Block -->
<container>
    <div class="card" id="login-form" >
        <form class="mx-1" method="post" action="<?php echo base_url()."core/main/loginAct";?>">
            <img src="<?php echo $img_folder; ?>/logo.gif" border="0" class="mb-2" alt="" id="logo">
            <div class="mb-1">
              <label for="exampleInputEmail1" class="form-label">Identitas Pengguna</label>
              <?php
					$class_style = "";
					$title = "Masukan data Identitas Pengguna anda";
					$str_error = str_replace(array("<p>", "</p>", "\n"), "", form_error("id"));
					if (!empty($str_error)) {
						$title = $str_error;
						$class_style = " red";
					}
				?>
              <input type="text" name="id" id='username' class="form-control<?php echo $class_style; ?>" value="<?php echo set_value("id"); ?>" title="<?php echo $title; ?>" />
            </div>
            <div class="mb-1">
              <label for="exampleInputPassword1" class="form-label">Kata Kunci</label>
              <?php
				$class_style = "";
				$title = "Masukan data Kata Kunci anda";
				$str_error = str_replace(array("<p>", "</p>", "\n"), "", form_error("pass"));
				if (!empty($str_error)) {
					$title = $str_error;
					$class_style = " red";
				    }
			    ?>		
              <input type="password" name="pass" class="form-control<?php echo $class_style; ?>" value="<?php echo set_value("pass"); ?>" title="<?php echo $title; ?>" />
            </div>
            <!-- <div class="mb-1 form-check">
              <input type="checkbox" class="form-check-input" id="exampleCheck1" checked />
              <label class="form-check-label" for="exampleCheck1">Always sign in on this device</label>
            </div> -->
            <div class="text-end">
              <button type="cancel" name="cancel" class="btn btn-subtle me-2">Cancel</button>
              <button type="submit" name="login" class="btn btn-primary" value='Login'>Submit</button>
            </div>
        </form>
    </div>
</container>
<!-- Section: Design Block -->
<script language="javascript" type="text/javascript">
	<!--
	    <?php
		if (!empty($gagal_login)) {
		?>
		alert("<?php echo $gagal_login; ?>");
		<?php
			}
		?>
			
		function afterInit() {
			$("input#username").focus();
		}
			//-->
</script>		