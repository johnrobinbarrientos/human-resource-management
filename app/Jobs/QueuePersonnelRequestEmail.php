<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

use Mail;
use App\Mail\ConfirmationEmail;

use App\Models\User;
use App\Models\UserSkill;
use App\Models\JobCategory; 
use App\Models\JobSubcategoryItem; 
use App\Models\JobPost; 
use App\Models\JobPostSkill; 
use App\Models\JobPostRecommendation; 
use App\Models\JobWorkerRecommendation; 

use App\Models\JobPostCategory;


use App\Mail\SendMail;
use Twilio\Rest\Client;

class QueueCandidateAcceptedEmail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $template = '';
    private $personnel_request = null;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($personnel_request = [])
    {
        $this->personnel_request = $personnel_request;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'New Personnel Request Submitted',  'request' => $personnel_request, 'template' => 'new-personnel-request'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));

        $request = PersonnelRequest::where('is_admin_notified','=',false)->update(['is_admin_notified' => true]);    
    }
}
