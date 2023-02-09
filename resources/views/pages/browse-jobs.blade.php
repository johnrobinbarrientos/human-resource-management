@extends('app')

@section('title', '| Browse Jobs')

@section('content')
<div class="container lg-max-width">
  <div style="min-height:calc(100vh - 410px);" class="pr-container-inner pr-page-content">
    <h4 class="pr-title smaller-light">Browse Jobs</h4>
    
    <ul class="pr-job-listings">
      @foreach($jobs as $job)
      <li class="job">
        <a href="/job/{{ $job->id }}">
          <div class="job-left">
            <img src="/images/favicon.png">            
          </div>
          <div class="job-right">
            <div class="description">
              <h4> {{ $job->title }} </h4>
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
              <p class="pr-paragraph">{!! $job->description !!}</p>
            </div>
            <div class="other">
            </div>
          </div>
        </a>
      </li>
      @endforeach
    </ul>

  </div>
</div>
@endsection