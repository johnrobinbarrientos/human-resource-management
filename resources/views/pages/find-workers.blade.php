@extends('app')

@section('title', '| Find Workers')

@section('content')
<!-- section 1 -->
<div class="bg-greywhite">
  <div class="container lg-max-width">
    <div class="pr-page-fold">
      <h1 class="pr-title small-light mb-0">Find Workers</h1>                
    </div>
  </div>
</div>


<!-- section 2 --> 
<div class="container lg-max-width">
  <div class="pr-page-content">

    <div class="row">
      <div class="col-lg-4 col-sm-12 order-2 order-lg-1">
        <h5 class="pr-title smaller-light">Find Workers</h5>
        <a href="/jobs/posts" class="pr-btn-w-icon"><i class="las la-angle-right"></i> <span>Post a Job</span></a>
        <a href="/contact-us" class="pr-btn-w-icon"><i class="las la-angle-right"></i> <span>Contact</span></a>
      </div>
      <div class="col-lg-8 col-sm-12 order-1 order-lg-2">
        <h2 class="pr-title small-light text-center">Your One Stop Shop for Ideal Human Resource</h2>
        <p class="pr-paragraph mb-4 text-center">Welcome to Canada’s Best Staffing Agency! We connect the right manpower to the right opportunities!</p>

        <div class="row">
          <div class="col-lg-6 col-sm-12 h-100 align-items-center">
            <img class="pr-img-block mb-4" src="/images/Young-People-Work-In-Modern-Office.jpg">
          </div>
          <div class="col-lg-6 col-sm-12">
            <p class="pr-paragraph">
              We are a full-service manpower staffing agency in Canada with a great market understanding and strong footprints in the field of administration, oil & gas, and Construction. 

              At Primus, we work upstream, midstream and downstream to provide you the ideal human resource in almost every industry. As a matter of fact, we have our name associated with Canada’s biggest companies and groups that make us the market leader in ManPower. 

              For Manpower services in Edmonton, we have the most qualified and experienced people to help you.
            </p>
          </div>
        </div>
      </div>
    </div>

  </div>
</div>
@endsection