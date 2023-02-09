<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta name="theme-color" content="#000000">
        <meta name="description" content="Web site created using create-react-app">
        <title>PRIMUS WORKFORCE</title>
        
        <!-- <link href="/app/vendors/select2/css/select2.min.css?ver=1.6.0" rel="stylesheet" /> -->

        <link href="/themes/libs/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
        <link href="/themes/libs/summernote/summernote.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css">
        <link href="assets/libs/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css" rel="stylesheet" type="text/css">
        <link href="assets/libs/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet" type="text/css">
        <link href="assets/libs/bootstrap-touchspin/jquery.bootstrap-touchspin.min.css" rel="stylesheet" type="text/css" />
        <link href="/vendors/line-awesome-1.3.0/css/line-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="/vendors/fontawesome/css/all.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="assets/libs/@chenfengyuan/datepicker/datepicker.min.css">
        <link rel="stylesheet" type="text/css" href="/themes/libs/toastr/build/toastr.min.css">

		<!-- Bootstrap Css -->
        <link href="/themes/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="/themes/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="/themes/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
        
   
        <link href="/app/css/fonts.css" rel="stylesheet" />
        <link href="/app/css/customs.css?v={{ time() }}" rel="stylesheet" />
        <link href="/app/css/resets.css?v={{ time() }}" rel="stylesheet" />

        <link rel="icon" href="/images/favicon.png" sizes="32x32" />
        <!--
        <link href="https://assets.calendly.com/assets/external/widget.css" rel="stylesheet">
        <script src="https://assets.calendly.com/assets/external/widget.js" type="text/javascript"></script>
        -->
    </head>
    <body data-sidebar="dark" data-sidebar-size="" data-topbar="light" data-layout-size="fluid" class="">
        <noscript>You need to enable JavaScript to run this app.</noscript>
        <div id="root">
            <div id="preloader" style="display: none;">
                <div id="status" style="display: none;">
                    <div class="spinner-chase">
                        <div class="chase-dot"></div>
                        <div class="chase-dot"></div>
                        <div class="chase-dot"></div>
                        <div class="chase-dot"></div>
                        <div class="chase-dot"></div>
                        <div class="chase-dot"></div>
                    </div>
                </div>
            </div>
            
            <div id="app">
                <app></app>
            </div>
        </div>

        <div id="modal-overlay"></div>
        <!-- JAVASCRIPT -->
        <script src="/themes/libs/jquery/jquery.min.js"></script>
		<!-- <script src="/app/vendors/select2/js/select2.full.min.js?ver=1.6.0'"></script> -->
		 
        <script src="/themes/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="/themes/libs/metismenu/metisMenu.min.js"></script>
        <script src="/themes/libs/simplebar/simplebar.min.js"></script>
        <script src="/themes/libs/node-waves/waves.min.js"></script>


        <script src="/themes/libs/select2/js/select2.min.js"></script>
        <script src="/themes/libs/summernote/summernote.min.js"></script>
        <script src="/themes/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
        <script src="/themes/libs/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
        <script src="/themes/libs/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
        <script src="/themes/libs/bootstrap-touchspin/jquery.bootstrap-touchspin.min.js"></script>
        <script src="/themes/libs/bootstrap-maxlength/bootstrap-maxlength.min.js"></script>
        <script src="/themes/libs/@chenfengyuan/datepicker/datepicker.min.js"></script>


        <!-- toastr plugin -->
        <script src="/themes/libs/toastr/build/toastr.min.js"></script>

        <!-- form advanced init -->
        <script src="/themes/js/pages/form-advanced.init.js"></script>
        <script src="/themes/js/app.js"></script>
       
		
        <script src="{{ mix('js/app.js') }}?v={{ time() }}"></script>
        <script src="/app/js/customs.js?v={{ time() }}"></script>
    </body>
</html>