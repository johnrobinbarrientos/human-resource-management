@extends('app')

@section('title', '| Find Workers')

@section('content')
<div class="bg-greywhite">
  <div class="container lg-max-width">
    <div class="pr-page-fold">
      <h1 class="pr-title small-light mb-0">Contact Us</h1>                
    </div>
  </div>
</div>

<div style="padding:80px 0px;">
<div class="container">
    <div class="row">
        <div class="col-12 col-md-8">
        <form class="form-contact-us" action="/contact-us/send">
            <h3>Contact Form</h3>
            <div style="margin-top:20px; margin-bottom:20px;">
                <div style="display:none;" class="form-success alert alert-success">Your message has been successfully sent!</div>
                <div style="display:none;" class="form-error alert alert-danger">Failed to Send Message</div>
                
                <div class="form-fields">
                    <div class="form-group">
                        <span style="font-weight:600;">Name</span> <span style="color:red;">*</span>
                        <input name="first_name" style="max-width:400px;" type="text" class="form-control">
                    </div>

                    <div class="form-group">
                        <span style="font-weight:600;">Email</span> <span style="color:red;">*</span>
                        <input name="email" style="max-width:400px;" type="text" class="form-control">
                    </div>

                    <div class="form-group">
                        <span style="font-weight:600;">Message</span> <span style="color:red;">*</span>
                        <textarea name="message" style="width:100%; border:1px solid #ccc; border-radius:3px; padding:15px;" rows="8" ></textarea>
                    </div>

                    <div class="form-group">
                        <button style="background:#f58220; color:#fff; padding:10px 30px; border:none; border-radius:5px;">Send</button>
                    </div>
                </div>
            </div> 
            </form> 
        </div>
        <div class="col-12 col-md-4">
            <div style="background:#f8f8f8; padding:20px; margin-bottom:40px;">
                <p>PRIMUS WORKFORCE LTD.</p>
                <div style="padding:0px 5px;">
                    <p><i class="las la-angle-right"></i> 1313 10 St, Nisku,</p>
                    <p><i class="las la-angle-right"></i> AB T9E 8L6, Canada</p>
                    <br/>
                    <p><i class="las la-phone"></i> +1 (780) 979-0744 (office)</p>
                    <p><i class="las la-phone"></i> +1 (780) 885-1373 (oncall)</p>
                    <p style="color:#f58220;">www.primusworkforce.com</p>
                </div>
            </div>

            <div style="text-align:center;">
                <a href="https://www.facebook.com/primus.workforce.3" target="_blank" style="font-size:40px; color:#f58220;"><i class="lab la-facebook-f"></i></a>
                <a href="https://ca.indeed.com/cmp/Primus-Workforce-Ltd/reviews" style="font-size:40px; color:#f58220;" target="_blank"><i class="las la-info"></i></a>
                <a href="https://www.linkedin.com/company/primus-workforce-ltd" style="font-size:40px; color:#f58220;" target="_blank"><i class="lab la-linkedin-in"></i></a>
            </div>
        </div>
    </div>
</div>
</div>
@endsection

@section('scripts')
<script>
$(document).ready(function(){
    $(document).on('submit','.form-contact-us',function(e){

        e.preventDefault(); // avoid to execute the actual submit of the form.

        var form = $(this);
        var url = form.attr('action');
        var data =  form.serialize();

        form.find('.form-success').hide();
        form.find('.form-error').hide();
        

        $.ajax({
            url: url,
            type: "POST",
            data: data,
            headers: {
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            success: function (response) {
                form.find('.form-success').show();
                form.find('.form-fields').hide();
            },
            error: function(res) {
                
                form.find('.form-error').show();
            }
        });
    });
});
</script>
@endsection 