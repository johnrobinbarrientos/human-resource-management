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

class QueueForgotPasswordEmail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $template = '';
    private $retrieval = [];
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($retrieval = null)
    {
        $this->retrieval = $retrieval;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $retrieval = $this->retrieval;
        $user = User::find($retrieval->user_id);

        if (!$user) { 
            return;
        }


        $retrieval->status = 'sending';
        $retrieval->save();

        $token = $retrieval->token;
        $url = getenv("APP_URL").'/forgot-password?token='.$token;

        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Primus Workforce Password Reset', 'user' => $user, 'url' => $url, 'template' => 'forgot-password'];
        Mail::to($user->email)->send(new SendMail($data));

        $retrieval->status = 'sent';
        $retrieval->save(); 
            
    }
}
