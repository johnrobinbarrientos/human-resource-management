@extends('app')

@section('title', '| Browse Jobs')

@section('content')
<div class="container lg-max-width">
    <div class="pr-container-inner pr-page-content">
        <h2>Submit Resume</h2>
    </div>

    <div id="resume-form" style="background:#fff;  margin-bottom:20px; box-shadow: 0 0 12px 0 rgba(0,0,0,0.06); border-radius: 4px; padding:50px;">
        <resume-form></resume-form>
    </div>
</div>

@endsection