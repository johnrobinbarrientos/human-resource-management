<script src="/vendors/slick-1.8.1/vendors/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="/vendors/slick-1.8.1/slick/slick.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
  $('.main-folds').slick({
    autoplay: true,
    autoplaySpeed: 3000,
    fade: true,
    arrows: true
  });
  $('.testimonials').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    responsive: [
    {
      breakpoint: 992,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2,
        infinite: true,
        dots: true
      }
    },
    {
      breakpoint: 576,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        infinite: true,
        dots: true
      }
    }]
  });
</script>