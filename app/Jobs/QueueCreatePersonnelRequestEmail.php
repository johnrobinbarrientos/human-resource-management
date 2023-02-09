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

class QueueCreatePersonnelRequestEmail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $template = '';
    private $recipients = null;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($recipients = [])
    {
        $this->recipients = $recipients;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $recipients = $this->recipients;
        foreach ($recipients as $recipient)
        {
            $user = User::where('company_id','=',$recipient)->where('is_company_admin','=',true)->first();

            if (!$user) {
                continue;
            }

            $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Primus Workforce Personnel Request Form',  'user' => $user, 'template' => 'create-personnel-request'];
            Mail::to($user->email)->queue(new SendMail($data)); 
        }
        

        // $request = PersonnelRequest::where('is_admin_notified','=',false)->update(['is_admin_notified' => true]);
        // $this->info('Primus Team has been notified about '.$count.' new personnel requests...');     
    }
}
