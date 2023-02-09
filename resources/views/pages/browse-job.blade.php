@extends('app')

@section('title', '| Job')

@section('content')
<!-- section 1 -->
<div class="bg-greywhite">
    <div class="container lg-max-width">
        <div class="pr-page-fold d-flex align-items-center justify-content-between">
            <div>
                <h1 class="pr-title normal mb-0">{{ $job->title }}</h1>
                <h5 style="color: #505050; font-size: 16px; font-weight: 400;">
                    @foreach ($job->categories as $category)
                        {{ $category->name }}, 
                    @endforeach
                </h5>
                
            </div>
            <div>
                <!-- <a href="#" class="pr-btn-2">Login to boookmark</a> -->
            </div>
        </div>
    </div>
</div>


<div style="min-height:calc(100vh - 410px);" class="container lg-max-width">
    <div class="pr-page-content">
        <!-- <div class="notification-bar">Applications have closed </div> -->
        <div class="row">
            <div class="col-8">
                <img src="/images/favicon.png">
                <p style="font-size: 18px; color: #888; font-weight: 500; margin-top:20px; margin-bottom:40px;">
                    {!! $job->description !!}
                </p>
                <!-- <a href="#" class="pr-btn-w-icon mb-3"><i class="las la-link" style="font-size: 18px;"></i> <span>Website</span></a> -->
                <job-application :job_post_id="{{ $job->id }}"></job-application>
                <require-auth :redirect="'/register'"></require-auth>

                <hr class="pr-line-grey mt-5 mb-5">
                <!-- <p class="c-665">This listing has expired.</p> -->
            </div>
            <div class="col-4">
                <h4 class="pr-title smaller-light mb-3">Job Overview</h4>
                <div class="pr-container pr-border rounded">
                    <div class="pr-blurb">
                        <div>
                            <i class="las la-calendar"></i>
                        </div>
                        <div>
                            <strong class="blurb-title">Date Posted:</strong>
                            <p class="blurb-desc">Posted 3 months ago</p>
                        </div>
                    </div>

                    <div class="pr-blurb">
                        <div>
                            <i class="las la-map-marked-alt"></i>
                        </div>
                        <div>
                            <strong class="blurb-title">Location:</strong>
                            <p class="blurb-desc">{{ $job->location }}</p>
                        </div>
                    </div>

                    <div class="pr-blurb">
                        <div>
                            <i class="las la-user"></i>
                        </div>
                        <div>
                            <strong class="blurb-title">Job Title:</strong>
                            <p class="blurb-desc">{{ $job->title }}</p>
                        </div>
                    </div>

                    <div class="pr-blurb">
                        <div>
                            <i class="las la-money-bill"></i>
                        </div>
                        <div>
                            <strong class="blurb-title">Rate:</strong>
                            @if($job->min_hourly_rate || $job->max_hourly_rate)
                                <p style="margin-bottom:5px;" class="blurb-desc">${{ $job->min_hourly_rate }}/hr to ${{ $job->max_hourly_rate }}/hr</p>
                            @endif
                            
                            
                            @if($job->max_hourly_rate || $job->max_hourly_rate)
                                <p style="margin-bottom:5px;" class="blurb-desc">${{ $job->maximum_salary }} to ${{ $job->maximum_salary }}</p>
                            @endif
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



@endsection