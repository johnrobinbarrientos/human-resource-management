// Mixins are a flexible way to distribute reusable functionalities for Vue components.
export default {
    name: 'customs',
    data () {
      return {
        msg: ''
      }
    },
    methods: {
        OPEN_MODAL: function (selector) {
            $(selector).addClass('show');
            $(selector).css({display: 'block'});
            $('body').addClass('modal-open');
            $('.modal-backdrop').show();
            $('.modal-backdrop').addClass('show');
        },
        CLOSE_MODAL: function (selector) {
            $(selector).removeClass('show');
            $(selector).css({display: 'none'});
            $('body').removeClass('modal-open');
            $('.modal-backdrop').hide();
            $('.modal-backdrop').removeClass('show');
        }
    }
}
  