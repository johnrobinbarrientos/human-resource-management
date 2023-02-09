$(document).ready(function(){

    $(document).on('click','#vertical-menu-btn',function() {
        // sidebar-enable vertical-collpsed
        var BODY = $(document).find('body');

        if (!BODY.hasClass('sidebar-enable')) {
            BODY.addClass('sidebar-enable');
            BODY.addClass('vertical-collpsed');
        } else {
            BODY.removeClass('sidebar-enable');
            BODY.removeClass('vertical-collpsed');
        }
        
    });

    $(document).on('click','#page-header-user-dropdown',function() {
        var BUTTON = $(this)
        var DROPDOWN = BUTTON.closest('.dropdown');
 
        if (!DROPDOWN.hasClass('show')) {
            DROPDOWN.addClass('show')
            DROPDOWN.find('.dropdown-menu').addClass('show')
        } else {
            DROPDOWN.removeClass('show')
            DROPDOWN.find('.dropdown-menu').removeClass('show')
        }
    }); 

    $(document).on('click','#sidebar-menu  ul  li  .is-page',function() {
        var BUTTON = $(this);

        $(document).find('.link-active').removeClass('link-active');
        BUTTON.closest('li').addClass('link-active');
    });

    $(document).on('click','#sidebar-menu  ul  li  .has-arrow',function() {
        var BUTTON = $(this);

        if (!BUTTON.closest('li').hasClass('mm-active')) {
            BUTTON.closest('li').addClass('mm-active');
            BUTTON.closest('li').find('> .sub-menu').addClass('mm-show');
        } else {
            BUTTON.closest('li').removeClass('mm-active');
            BUTTON.closest('li').find('> .sub-menu').removeClass('mm-show');
        }
    });

    $(document).on('click','.nav-tabs > .nav-item',function() {
        var BUTTON = $(this)
        var index = BUTTON.index()

        var NAVS =  BUTTON.closest('.nav-tabs');
        var TAB_CONTENT = NAVS.next(".tab-content");
        
        NAVS.find('.active').removeClass('active');
        TAB_CONTENT.find('.active').removeClass('active');

        BUTTON.find('.nav-link').addClass('active')
       $(".tab-pane:nth-child("+ (index + 1) +")").addClass('active')

    });

    $(document).on('click','.nav-item',function(e){
        e.preventDefault();
        e.stopPropagation();
    });

    $(document).on('click','.editable',function(){
        var THIS = $(this);
        $(document).find('.editable').removeClass('focused');

        var CONTROL = THIS.find('.editable-control')
        CONTROL.focus();

        // make sure to place caret at the end
        var tmpStr = CONTROL.val();
        CONTROL.val('');
        CONTROL.val(tmpStr);
    });

    $(document).on('focusin','.editable-control',function(){
        var THIS = $(this);
        $(document).find('.editable').removeClass('focused');

        THIS.closest('.editable').addClass('focused');

        // make sure to place caret at the end
        var tmpStr = THIS.val();
        THIS.val('');
        THIS.val(tmpStr);
    });

    $(document).on('blur','.editable-control',function(){
        $(document).find('.editable').removeClass('focused');
    });

    $(document).on('click','.modal.show',function(event) 
    {
        var EL = $(this);

        if(!$(event.target).closest('.modal-dialog').length && !$(event.target).is('.modal-dialog')) {
            EL.removeClass('show');
            EL.css({display: 'none'});
            $('body').removeClass('modal-open');
            $('.modal-backdrop').hide();
            $('.modal-backdrop').removeClass('show');
        } 
    
    });
});