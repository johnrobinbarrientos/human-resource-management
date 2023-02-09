<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

use App\Models\User;
use App\Models\UserSkill;
use App\Models\JobCategory; 
use App\Models\JobSubcategoryItem; 
use App\Models\JobPost; 
use App\Models\JobPostSkill; 
use App\Models\JobPostRecommendation; 
use App\Models\JobWorkerRecommendation; 

use App\Models\JobPostCategory;


use Mail;
use App\Mail\SendMail;
use Twilio\Rest\Client;

//use Curl\Curl;
//use Klaviyo\Klaviyo as Klaviyo;
//use Klaviyo\Model\ProfileModel as KlaviyoProfile;

class SendJobRecommendations extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'send:job-recommendations';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This command will send email recommendation to all the workers';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $account_sid = getenv("TWILIO_SID");
        $auth_token = getenv("TWILIO_AUTH_TOKEN");
        $twilio_number = getenv("TWILIO_NUMBER");
        $client = new Client($account_sid, $auth_token);

        $recommendations = JobPostRecommendation::where('status','=','pending')->get();

        foreach ($recommendations  as $recommendation)
        {
            $recommendation->status = 'sent';
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
