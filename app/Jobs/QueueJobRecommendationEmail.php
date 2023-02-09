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

class QueueJobRecommendationEmail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $template = '';
    private $recommendations = [];
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($recommendations = [])
    {
        $this->recommendations = $recommendations;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $recommendations = $this->recommendations;

        foreach ($recommendations  as $recommendation)
        {
            $recommendation->is_candidate_notified = true;
            $recommendation->save();

            $job_post = JobPost::find($recommendation->job_post_id);
            
            $categories = JobPostCategory::leftJoin('job_posts','job_post_categories.job_post_id','=','job_posts.id')
                ->leftJoin('job_categories','job_post_categories.job_category_id','=','job_categories.id')
                ->where('job_post_categories.job_post_id','=',$job_post->id)
                ->get();

            $category_result = "";

            foreach ($categories as $category) {
                $category_result .= ", " . $category->name;
            }

            $category_result = substr($category_result, 1); // remove leading ","

            $user = User::find($recommendation->user_id);
            $email = $user->email;

            $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'New Job Recommendation', 'job' => $job_post, 'recommendation' => $recommendation, 'category_result' => $category_result, 'user' => $user, 'template' => 'job-recommendation'];
            Mail::to($email)->queue(new SendMail($data));
        }        
    }
}
