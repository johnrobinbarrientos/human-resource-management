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
    private $recommendation = null;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($recommendation = [])
    {
        $this->recommendation = $recommendation;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $recommendation = $this->recommendation;

        // send email to ADMIN (employer accepted the job recommendation)
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => $recommendation->job->company->name.' has just hired  '.$recommendation->user->first_name, 'self' => 'no',  'recommendation' => $recommendation, 'template' => 'accept-candidate-recommendation'];
        Mail::to(getenv("APP_EMAIL"))->send(new SendMail($data)); 

        $data = ['APP_URL' => getenv("APP_URL"), 'subject' => 'You\'ve been hired by '.$recommendation->job->company->name, 'self' => 'yes', 'recommendation' => $recommendation, 'template' => 'accept-candidate-recommendation'];    
        Mail::to($recommendation->user->email)->send(new SendMail($data));     
    }
}
