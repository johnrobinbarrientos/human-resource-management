$(document).ready(function(){
    $(document).on('click','.nk-menu-toggle',function(){
        var link = $(this)
        if (!link.closest('.has-sub').hasClass('active')) {

            link.closest('.has-sub').addClass('active')
            link.closest('.has-sub').find('> .nk-menu-sub').css({ 'display' : 'block' });

        } else {
            link.closest('.has-sub').removeClass('active')
            link.closest('.has-sub').find('> .nk-menu-sub').css({ 'display' : 'none' });
        }
    });

});