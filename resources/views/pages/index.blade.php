@extends('app')

@section('title', '| Home')

@section('content')
<!-- section 1 -->
<div class="main-folds">
  <div class="main-fold" style="background-image: url(/images/men-field-working.jpeg);">
    <div class="container lg-max-width h-100">
      <div class="main-fold-inner">
        <div class="w-100">
          <h1 class="main-title">Find Work Today</h1>
          <h2 class="main-sub-title">We're working hard to help you build your career</h2>
          <a href="#" class="pr-btn-fold">Get Started</a>
        </div>
      </div>
    </div>
  </div>

  <div class="main-fold fold-slide-2" style="background-image: url(/images/Empoyee-Talking-Office.jpg);">
    <div class="container lg-max-width h-100">
      <div class="main-fold-inner">
        <div class="w-100">
          <h1 class="main-title c-fff">Find Qualified Workers Today</h1>
          <h2 class="main-sub-title c-fff">Get peace of mind with PRIMUS WORKFORCE and find out how we can help you achieve your staffing goals today</h2>
          <a href="#" class="pr-btn-fold pr-btn-white">Get Started</a>
        </div>
      </div>
    </div>
  </div>
</div>


<!-- section 2 -->
<div class="container lg-max-width">
  <div class="about-primus-workforce bg-grey">
    <div class="row">
      <div class="col-lg-4 col-md-6 col-sm-12">
        <h3 class="pr-title">ABOUT PRIMUS WORKFORCE</h3>
        <hr class="pr-divider">
        <p class="pr-desc">Connecting people to careers the in oil & gas, construction, renewable energy and trades sectors throughout Canada</p>
        <div class="grouped-btns">
          <a href="#" class="pr-btn mr-3">About Us</a>
          <a href="#" class="pr-btn">Contact Us</a>
        </div>
      </div>
      <div class="col-lg-8 col-md-6 col-sm-12 border-left border-white">
        <div class="d-flex align-items-center h-100">
          <div>
            <p class="pr-paragraph">
              We dont just help people find jobs, we help build careers. It’s really about getting to know the people we employ and helping them reach their potential. Our goal is to provide meaningful and steady work for all. We believe in nurturing our economy by connecting skilled people with leading companies in today’s fastest growing industries.
            </p>
            <p class="pr-paragraph">
              We strive to be our clients’ first call when they need a job done on time, safely and professionally. Whether they are seeking a long term or short term professional or temporary worker we have the resource pool to cater to their specific needs. Our extensive and loyal pool of candidates have earned us a reputation of being quick, reliable and a dependable.
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- section 3 -->
<div class="container lg-max-width">
  <div class="pr-container-inner">
    <h4 class="pr-title smaller-light">Job Categories</h4>
    <div class="pr-counter-wrapper pr-flex-row">
      <div class="pr-counter pr-flex-col-3">
        <h5>Oil & Gas</h5>
        <span>1</span>
      </div>
      <div class="pr-counter pr-flex-col-3">
        <h5>Construction</h5>
        <span>0</span>
      </div>
      <div class="pr-counter pr-flex-col-3">
        <h5>Warehousing</h5>
        <span>0</span>
      </div>
      <div class="pr-counter pr-flex-col-3">
        <h5>Administrative</h5>
        <span>0</span>
      </div>
      <div class="pr-counter pr-flex-col-3">
        <h5>Administrative</h5>
        <span>0</span>
      </div>
    </div>  
    <div class="d-flex justify-content-center">
      <a href="#" class="pr-btn">Browse All Categories</a>
    </div>
  </div>
</div>

<hr class="pr-line">

<!-- section 4 -->
<div class="container lg-max-width">
  <div class="pr-container-inner">
    <h4 class="pr-title smaller-light">Recent Jobs</h4>
    <ul class="pr-job-listings">

      <li class="job">
        <a href="#">
          <div class="job-left">
            <img src="/images/favicon.png">            
          </div>
          <div class="job-right">
            <div class="description">
              <h4>Skilled Laborer (Construction)</h4>
              <div class="more-details">
                <span><i class="las la-briefcase"></i> Primus Workforce</span>
                <span><i class="las la-map-marked-alt"></i> Alberta</span>
                <span><i class="las la-money-bill"></i> $19 - $22 / hour</span>
              </div>
            </div>
            <div class="other">
            </div>
          </div>
        </a>
      </li>

      <li class="job">
        <a href="#">
          <div class="job-left">
            <img src="/images/favicon.png">            
          </div>
          <div class="job-right">
            <div class="description">
              <h4>Class 1 or 3 Vac Truck Operators</h4>
              <div class="more-details">
                <span><i class="las la-briefcase"></i> Primus Workforce</span>
                <span><i class="las la-map-marked-alt"></i> Edmonton, AB</span>
                <span><i class="las la-money-bill"></i> $28 - $32 / hour</span>
              </div>
            </div>
            <div class="other">
              <span>Other</span>
            </div>
          </div>
        </a>
      </li>

      <li class="job">
        <a href="#">
          <div class="job-left">
            <img src="/images/favicon.png">            
          </div>
          <div class="job-right">
            <div class="description">
              <h4>Skilled Laborer (Construction)</h4>
              <div class="more-details">
                <span><i class="las la-briefcase"></i> Primus Workforce</span>
                <span><i class="las la-map-marked-alt"></i> Alberta</span>
                <span><i class="las la-money-bill"></i> $19 - $22 / hour</span>
              </div>
            </div>
            <div class="other">
            </div>
          </div>
        </a>
      </li>

    </ul>
  </div>

<!-- section 5 -->
<div class="container lg-max-width">
  <div class="pr-container-inner">
    <h4 class="pr-title smaller-light">Job Spotlight</h4>

    <div class="pr-job-spotlight">
        <div class="header">
          <h4>Class 1 or 3 Vac Truck Operators</h4>
          <div class="other"> <span>Other</span> </div>            
        </div>
        <div class="more-details">
          <span><i class="las la-briefcase"></i> Primus Work Force</span>
          <span><i class="las la-map-marked-alt"></i> Edmonton, AB</span>
          <span><i class="las la-money-bill"></i> $28 - $32 / hour</span>
        </div>
        <p class="pr-paragraph">We are currently seeking: Class 1 or 3 Vac Truck Operators Ensure that Health and Safety is the number one test ellipses css hack hack asdfghjk Leverage agile frameworks to provide a robust synopsis for high level overviews.</p>

      <a href="#" class="pr-btn d-block text-center">Apply For This Job</a>
    </div>
  </div>
</div>

<!-- section 6 -->
<div class="container-fluid bg-greylight p-5">
  <div class="row">
    <div class="col-lg-3 col-md-1 col-sm-12"></div>
    <div class="col-lg-6 col-md-10 col-sm-12">
      <h4 class="pr-title small-light text-center">What They Say</h4>
      <p class="pr-desc small-light text-center">Knowing how we’re doing is important to us! Check out recent reviews from people that have benefited from our services.</p>
    </div>
    <div class="col-lg-3 col-md-1 col-sm-12"></div>
  </div>

  <div class="testimonials">

      <div class="pr-testimonial">
        <img src="/images/favicon.png">
        <h4>Never a dull moment</h4>
        <span>Office Operations Specialist</span>
        <p class="pr-paragraph">Good management team who is very thorough and demonstrative of the dedication that they have for the clients that they work for as well as the personnel that they acquire . I have worked both field and office positions for this company, and both have been enjoyable.</p>
      </div>

      <div class="pr-testimonial">
        <img src="/images/favicon.png">
        <h4>Never a dull moment</h4>
        <span>Office Operations Specialist</span>
        <p class="pr-paragraph">Good management team who is very thorough and demonstrative of the dedication that they have for the clients that they work for as well as the personnel that they acquire . I have worked both field and office positions for this company, and both have been enjoyable.</p>
      </div>

      <div class="pr-testimonial">
        <img src="/images/favicon.png">
        <h4>Never a dull moment</h4>
        <span>Office Operations Specialist</span>
        <p class="pr-paragraph">Good management team who is very thorough and demonstrative of the dedication that they have for the clients that they work for as well as the personnel that they acquire . I have worked both field and office positions for this company, and both have been enjoyable.</p>
      </div>

      <div class="pr-testimonial"> <img src="/images/favicon.png"><h4>Never a dull moment</h4> <span>Office Operations Specialist</span><p class="pr-paragraph">Good management team who is very thorough and demonstrative of the dedication that they have for the clients that they work for as well as the personnel that they acquire . I have worked both field and office positions for this company, and both have been enjoyable.</p></div><div class="pr-testimonial"> <img src="/images/favicon.png"><h4>Never a dull moment</h4> <span>Office Operations Specialist</span><p class="pr-paragraph">Good management team who is very thorough and demonstrative of the dedication that they have for the clients that they work for as well as the personnel that they acquire . I have worked both field and office positions for this company, and both have been enjoyable.</p></div><div class="pr-testimonial"> <img src="/images/favicon.png"><h4>Never a dull moment</h4> <span>Office Operations Specialist</span><p class="pr-paragraph">Good management team who is very thorough and demonstrative of the dedication that they have for the clients that they work for as well as the personnel that they acquire . I have worked both field and office positions for this company, and both have been enjoyable.</p></div>
  </div>
</div>
@endsection