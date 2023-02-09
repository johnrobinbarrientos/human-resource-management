@extends('app')

@section('title', '| Find Work')

@section('content')
<!-- section 1 -->
<div class="bg-greywhite">
  <div class="container lg-max-width">
    <div class="pr-page-fold">
      <h1 class="pr-title small-light mb-0">Find Work</h1>                
    </div>
  </div>
</div>


<!-- section 2 --> 
<div class="container lg-max-width">
  <div class="pr-page-content">

    <div class="row">
      <!-- <div class="col-lg-4 col-sm-12 order-2 order-lg-1">
        <h5 class="pr-title smaller-light">Find Work</h5>
        <a href="/browse-jobs" class="pr-btn-w-icon"><i class="las la-angle-right"></i> <span>Browse Jobs</span></a>
        <a href="/browse-categories" class="pr-btn-w-icon"><i class="las la-angle-right"></i> <span>Browse Categories</span></a>
      </div>-->
      <div class="col-lg-6">
        <h2 class="pr-title small-light">Browse Jobs:</h2>
        <ul class="pr-job-listings">
          @foreach($jobs as $job)
            <li class="job">
              <a href="/job/{{ $job->id }}">
                <div class="job-right">
                  <div class="description">
                    <h4 style="font-weight: 600"> {{ $job->title }} </h4>
                    <div class="more-details mb-2"> 
                      <span><i class="las la-briefcase"></i> Primus Workforce</span>
                      <span><i class="las la-map-marked-alt"></i> @if($job->location) {{ $job->location }} @else <span>Not Available</span> @endif</span>
                      <span><i class="las la-money-bill"></i>
                      @if ($job->min_hourly_rate && $job->max_hourly_rate)
                        @if ($job->min_hourly_rate) {{ $job->min_hourly_rate }} @else <span>Negotiable</span> @endif
                        - 
                        @if ($job->max_hourly_rate) {{ $job->max_hourly_rate }} @else <span>Negotiable</span> @endif
                        / hour
                      @else <span>Negotiable / hour</span>
                      @endif
                      </span>
                    </div>
                    <div class="job-description">{!! $job->description !!}</div>
                    <span class="pr-btn-outline-1">More Details <i class="las la-angle-right"></i></span>
                  </div>
                  <div class="other">
                  </div>
                </div>
              </a>
            </li>
          @endforeach
        </ul>
      </div>
      <div class="col-lg-6 col-sm-12 order-1 order-lg-2">
        <h2 class="pr-title small-light text-center">Take Control of Your Career</h2>
        <p class="pr-paragraph mb-4 text-center">Primus Workforce makes the toilsome task of the Job Hunt easy by connecting you with a wide range of potential employers and opportunities that are tailored to meet your end goals.</p>

        <div class="row">
          <!-- <div class="col-lg-6 col-sm-12 h-100 align-items-center">
            <img class="pr-img-block mb-4" src="/images/Employees-Celebrate-Success-In-A-Modern-Office.jpg">
          </div> -->
          <div class="col-lg-12 col-sm-12">
            <img class="pr-img-block mb-4" src="/images/Employees-Celebrate-Success-In-A-Modern-Office.jpg">
            <p class="pr-paragraph">
              We don’t just focus on jobs, we help you build a career. At Primus Workforce we believe you are more than what your resume says about you. We care about your passions, goals and your comfort zone. Whether you’re on the hunt for a new opportunity to get a better work-life balance or looking for part-time employment to make extra money on the side, we’ve got all your needs covered. 

              We keep our platform updated regularly with rewarding career opportunities in Canada. 

              Applying for Jobs in Canada has never been easier. All you need to do is search for the best-suited job and we’ll connect you with some of the biggest names in that industry.          
            </p>
          </div>
        </div>
        
        <div class="row">
          <div class="col-lg-12 col-sm-12">
            <h3 class="pr-title normal mb-2">Flourish Your Career in Administrative Support</h3>
            <p class="pr-paragraph">
              There has been a massive shift in the admin sector over the last few years as it’s no longer restricted to entering data and keeping schedules. In fact, the industry has taken a more complex edge and has added additional functions that primarily include accounting duties and maintaining internal systems. So if you are someone looking to apply for administrative jobs in Canada, you are now expected to be more digitized and tech-savvy at the same time. We can help you discover the skills you already have and guide you to learning what is needed to land that perfectly challenging and rewarding career.
            </p>
          </div>
          <div class="col-lg-6 col-sm-12 h-100 align-items-center">
            <!-- <img class="pr-img-block mb-4" src="/images/Young-People-Work-In-Modern-Office.jpg"> -->
          </div>
        </div>

        <div class="row">
          <!--<div class="col-lg-6 col-sm-12 h-100 align-items-center">
            <img class="pr-img-block mb-4" src="/images/Employees-Celebrate-Success-In-A-Modern-Office.jpg">
          </div>-->
          <div class="col-lg-12 col-sm-12">
              <h3 class="pr-title normal mb-2">Rise through the Ranks with Top Construction Jobs</h3>
              <p class="pr-paragraph">
                Over 1.3 million people in Canada are associated with some sort of Construction job that varies from earth works to mining to oil and gas. It’s no wonder that the industry itself has a booming potential. At Primus Workforce we connect you with the best Canadian employers all across the civil, infrastructure, and ICI building projects. If you are someone willing to explore construction jobs in Canada, we have a lot of openings for you that are sure to help you build a career.
              </p>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-12 col-sm-12">
          <img class="pr-img-block mb-4" src="/images/Young-People-Work-In-Modern-Office.jpg">

            <h3 class="pr-title normal mb-2">Explore the Top Oil And Gas Jobs In Canada</h3>
            <p class="pr-paragraph">
            An industry that has transformed like none other, and is on a constant shift from oil to natural gas, new export opportunities and geographies and oncoming digitization is the oil & gas sector. The overall market of oil and gas has grown significantly and it is predicted that it will remain the case. We work with the biggest names in the industry and have an enviable list of jobs in the oil & gas sector from the national and global oil leading companies. 

Interested in building your career in oil & gas in Canada? You’ve come to right place!
            </p>
          </div>
          <!--<div class="col-lg-6 col-sm-12 h-100 align-items-center">
            <img class="pr-img-block mb-4" src="/images/Young-People-Work-In-Modern-Office.jpg">
          </div>-->
        </div>



      </div>
    </div> <!-- end row -->

  </div>


</div>

<div style="background: #eee; padding: 50px 0; margin-top: 50px;">
    <div style="max-width: 900px; margin: 0 auto;">
      <div class="row">
            <div class="col-12">
              <h3 class="pr-title normal text-center mb-2">Questions?</h3>
              <p class="pr-paragraph text-center">
                We don’t just act as the middle man, we help people overcome their career obstacles. Be it any challenging interview question, your resume or confusion about salary; we have all the resources to help you, just ask us.</p>
              <div class="text-center">
                <a href="/contact-us" class="pr-btn-yellow">Contact Us</a>
              </div>
            </div>
      </div>
    </div>
@endsection