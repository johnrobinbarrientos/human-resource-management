<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\UserSkill;
use App\Models\JobCategory; 
use App\Models\JobPost; 
use App\Models\JobPostSkill; 
use App\Models\JobPostRecommendation; 
use App\Models\JobWorkerRecommendation;
use App\Models\JobPostApplication;
use App\Models\CompanyEmployee;

use Mail;
use App\Mail\SendMail;

use App\Jobs\QueueJobRecommendationEmail;

use Illuminate\Support\Facades\Auth;
use Activity;

class JobPostRecommendationController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $recommendations = JobPostRecommendation::where('user_id','=',$user->id)->with('user')->with('job','job.company')->get();
        return response()->json(['success' => 1, 'rows' => $recommendations], 200);
    }

    public function show($jobPostID)
    {
        $post = JobPost::find($jobPostID);
        $recommendations = JobPostRecommendation::where('job_post_id','=',$post->id)->with('user')->with('job')->get();

        return response()->json(['success' => 1, 'rows' => $recommendations], 200);
    }

    public function accept($recommendationID)
    {
        $user = Auth::user();
        $recommendation = JobPostRecommendation::find($recommendationID);
        $job_post_id = $recommendation->job_post_id;

        # dont allow if worker is already hired
        if ($user->company_id != null) {
            return response()->json(['success' => 0, 'msg' => "Unable to accept. You're already hired!"], 500);
        }
        
        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        if ($recommendation->user_id != $user->id) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }


        if ($recommendation->status != 'waiting_for_candidate') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }


        $log = Activity::create([
            'user_id' => $user->id,
            'parent' => 'job-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-recommendation',
            'activity' => 'recommendation-accepted-by-candidate',
        ]);
        
        $recommendation->status = 'accepted_by_candidate';
        $recommendation->save();

        $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job')->with('user')->first();
        
        // send email to ADMIN (candidated accepted the job recommendation)
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'New Job Application - '.$recommendation->job->title,  'recommendation' => $recommendation, 'template' => 'accept-job-recommendation'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));

        return response()->json(['success' => 1, 'message' => 'Job application sent!', 'data' => $recommendation], 200); 
    }


    public function acceptByToken($recommendationID,$token)
    {
        $user = Auth::user();
        $recommendation = JobPostRecommendation::where('id',$recommendationID)->with('job')->first();
        
        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        if ($recommendation->user_id != $user->id) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        if ($recommendation->token != $token) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }
        
        if (empty(getenv("APP_EMAIL"))) {
            return 'empty';
        }

       
        if ($recommendation->status == 'accepted_by_candidate') {
            $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job')->with('user')->first();
            return response()->json(['success' => 1, 'message' => 'Job application sent!'], 200); 
        }

        if ($recommendation->status != 'waiting_for_candidate') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }



        $recommendation->status = 'accepted_by_candidate';
        $recommendation->save();

        $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job')->with('user')->first();

        $log = Activity::create([
            'user_id' => $user->id,
            'parent' => 'job-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-recommendation',
            'activity' => 'recommendation-accepted-by-candidate',
        ]);

        // send email to ADMIN (candidated accepted the job recommendation)
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'New Job Application - '.$recommendation->job->title,  'recommendation' => $recommendation, 'template' => 'accept-job-recommendation'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));

        return response()->json(['success' => 1, 'message' => 'Job application sent!', 'data' => $recommendation], 200); 
    }

    public function decline($recommendationID)
    {
        $user = Auth::user();
        $message = request()->message;
        $recommendation = JobPostRecommendation::find($recommendationID);
        $job_post_id = $recommendation->job_post_id;


        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        if ($recommendation->user_id != $user->id) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        if ($recommendation->status != 'waiting_for_candidate') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        
        $recommendation->status = 'rejected_by_candidate';
        $recommendation->save();

        $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job')->with('user')->first();

        $log = Activity::create([
            'user_id' => $user->id,
            'parent' => 'job-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-recommendation',
            'activity' => 'recommendation-rejected-by-candidate',
        ]);

        // send email to ADMIN (candidated rejected the job recommendation)
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Candiate is not interested - '.$recommendation->job->title,  'recommendation' => $recommendation, 'template' => 'reject-job-recommendation'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));


        return response()->json(['success' => 1, 'message' => 'The job has been declined!', 'data' => $recommendation], 200); 
    }


    public function declineByToken($recommendationID,$token)
    {
        $user = Auth::user();

        $message = request()->message;

        $recommendation = JobPostRecommendation::where('id',$recommendationID)->with('job')->first();
        
        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        if ($recommendation->user_id != $user->id) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        if ($recommendation->token != $token) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        if (empty(getenv("APP_EMAIL"))) {
            return 'empty';
        }

        if ($recommendation->status != 'waiting_for_candidate') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }
      
        $recommendation->status = 'rejected_by_candidate';
        $recommendation->save();

        $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job')->with('user')->first();

        $log = Activity::create([
            'user_id' => $user->id,
            'parent' => 'job-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-recommendation',
            'activity' => 'recommendation-rejected-by-candidate',
        ]);

        // send email to ADMIN (candidated rejected the job recommendation)
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Candiate is not interested - '.$recommendation->job->title,  'recommendation' => $recommendation, 'template' => 'reject-job-recommendation'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));

        return response()->json(['success' => 1, 'message' => 'The job has been declined!', 'data' => $recommendation], 200); 
    }


    public function save($jobPostID)
    {
        $user = Auth::user();

        if ($user->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        $post = JobPost::find($jobPostID)->with('job');
        
        $recommendations = request()->recommendations;
        $to_queue = [];

        foreach ($recommendations as $recommendation) {
   
            $user = User::find($recommendation['id']);

            $recommendation = JobPostRecommendation::where('job_post_id','=',$jobPostID)
                ->where('user_id','=',$user->id)
                ->withTrashed()
                ->first();

            $recommendation = ($recommendation) ? $recommendation : new  JobPostRecommendation();
            $recommendation->job_post_id = $jobPostID;
            $recommendation->user_id = $user->id;
            $recommendation->status = 'waiting_for_candidate';
            $recommendation->deleted_at = null;
            $recommendation->token = 'rcmd-'.\Uuid::generate(4);
            $recommendation->save();

            $recommendation = JobPostRecommendation::where('job_post_id','=',$recommendation->job_post_id)->where('user_id','=',$recommendation->user_id)->first();

            $to_queue[] = $recommendation;

            $log = Activity::create([
                'user_id' => $user->id,
                'parent' => 'job-recommendation',
                'parent_id' => $recommendation->id,
                'type' => 'job-recommendation',
                'activity' => 'job-recommended-to-candidate',
            ]);
        }

        // send email via queue
        QueueJobRecommendationEmail::dispatch($to_queue);

        return response()->json(['success' => 1, 'row' => $recommendation, 'message' => $user->first_name.' has been recommended'], 200); 
    }

    public function delete($jobPostID)
    {
        $post = JobPost::find($jobPostID);
        $user = User::find(request()->user_id);

        $recommended = JobPostRecommendation::where('job_post_id','=',$jobPostID)
            ->where('user_id','=',$user->id)
            ->first();

        if ($recommended) {
            $recommended->delete();
        }

        return response()->json(['success' => 1, 'row' => $recommended, 'message' => $user->first_name.' has been removed from recommended list'], 200); 
    }

}