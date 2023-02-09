@extends('app')

@section('title', '| Browse Categories')

@section('content')
<div class="bg-greywhite">
<div class="container lg-max-width">
  <div class="pr-container-inner pt-0 pb-0">
    <div class="pr-page-fold">
      <h4 class="pr-title smaller-light mb-0">Browse Categories</h4>
    </div>
  </div>
</div>
<hr class="pr-line-white m-0">
<div style="min-height:calc(100vh - 410px);" class="container lg-max-width pr-page-content">
  <div class="row">
    @foreach ($categories as $category)
        <div class="col-12 col-md-3">
            <a href="http://primus.local/browse-jobs?cat={{ urlencode($category->name) }}">
                <div class="pr-counter bg-orange">
                    <h5 class="c-fff">{{ $category->name }}</h5>
                    <span class="c-light-dark">{{ $category->jobs }}</span>   
                </div>
            </a>
        </div>
    @endforeach
  </div>  
</div>
</div>
@endsection