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
use App\Models\Company;
use App\Models\CompanyEmployee;

use Mail;
use App\Mail\SendMail;

use App\Jobs\QueueCandidateRecommendationEmail;
use App\Jobs\QueueCandidateAcceptedEmail;

use Illuminate\Support\Facades\Auth;
use Activity;

class JobPostCandidateRecommendationController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $job_ids = JobPost::where('company_id','=',$user->company_id)->pluck('id')->toArray();

        $recommendations = JobPostRecommendation::whereIn('job_post_id',$job_ids)->whereIn('status',['waiting_for_employer','accepted_by_employer','rejected_by_employer'])->with('user')->with('job','job.company')->get();
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

        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        $job = JobPost::find($job_post_id);
        $company = Company::where($job->company_id);
        $candidate = User::find($recommendation->user_id);

        if (!$job || $user->company_id == null || !$candidate) {
            return response()->json(['success' => 0, 'msg' => "Could not process the request..."], 500);
        }
        
        if ($job->company_id != $user->company_id) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }


        if ($recommendation->status != 'waiting_for_employer') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }


        $log = Activity::create([
            'user_id' => $user->id,
            'parent' => 'job-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-recommendation',
            'activity' => 'recommendation-accepted-by-employer',
        ]);
        
        $recommendation->status = 'accepted_by_employer';
        $recommendation->save();

        $company_employee = new CompanyEmployee();
        $company_employee->company_id = $job->company_id;
        $company_employee->user_id = $candidate->id;
        $company_employee->job_post_id = $recommendation->job_post_id;
        $company_employee->status = 'active';
        $company_employee->save();

        $candidate->company_id = $job->company_id;
        $candidate->save();

        $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job.company')->with('user')->first();

        // send email to ADMIN and Candidate (employer accepted the job recommendation)
        QueueCandidateAcceptedEmail::dispatch($recommendation);

        return response()->json(['success' => 1, 'message' => 'Job application sent!', 'data' => $recommendation], 200); 
    }


    public function acceptByToken($recommendationID,$token)
    {
        $user = Auth::user();
        $recommendation = JobPostRecommendation::find($recommendationID);
        $job_post_id = $recommendation->job_post_id;

        $job = JobPost::find($job_post_id);
        $company = Company::where($job->company_id);
        $candidate = User::find($recommendation->user_id);

        if (!$job || $user->company_id == null || !$candidate) {
            return response()->json(['success' => 0, 'msg' => "Could not process the request..."], 500);
        }
        
        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        if ($job->company_id != $user->company_id) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        if ($recommendation->token != $token) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }
        
        if ($recommendation->status == 'accepted_by_employer') {
            // this is for duplicate request bug
            $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job.company')->with('user')->first();
            return response()->json(['success' => 1, 'message' => 'Canidate Hired!', 'data' => $recommendation], 200); 
        }

        if ($recommendation->status != 'waiting_for_employer') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

       
        if (empty(getenv("APP_EMAIL"))) {
            return 'empty';
        }

        $recommendation->status = 'accepted_by_employer';
        $recommendation->save();

        $company_employee = new CompanyEmployee();
        $company_employee->company_id = $job->company_id;
        $company_employee->user_id = $candidate->id;
        $company_employee->job_post_id = $recommendation->job_post_id;
        $company_employee->status = 'active';
        $company_employee->save();

        $candidate->company_id = $job->company_id;
        $candidate->save();

        $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job.company')->with('user')->first();

        $log = Activity::create([
            'user_id' => $user->id,
            'parent' => 'job-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-recommendation',
            'activity' => 'recommendation-accepted-by-employer',
        ]);

        // send email to ADMIN and Candidate (employer accepted the job recommendation)
        QueueCandidateAcceptedEmail::dispatch($recommendation);

        return response()->json(['success' => 1, 'message' => 'Canidate Hired!', 'data' => $recommendation], 200); 
    }

    public function decline($recommendationID)
    {
        $user = Auth::user();
        $recommendation = JobPostRecommendation::where('id',$recommendationID)->with('job.company')->first();
        
        $recommendation = JobPostRecommendation::find($recommendationID);
        $job_post_id = $recommendation->job_post_id;

        $job = JobPost::find($job_post_id);
        $company = Company::where($job->company_id);

        if (!$job || $user->company_id == null) {
            return response()->json(['success' => 0, 'msg' => "Could not process the request..."], 500);
        }
        
        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        if ($job->company_id != $user->company_id) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }


        if ($recommendation->status != 'waiting_for_employer') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        
        $recommendation->status = 'rejected_by_employer';
        $recommendation->save();

        $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job.company')->with('user')->first();

        $log = Activity::create([
            'user_id' => $user->id,
            'parent' => 'job-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-recommendation',
            'activity' => 'recommendation-rejected-by-employer',
        ]);

        // send email to ADMIN (employer rejected the job recommendation)
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => $recommendation->job->company->name.' rejected  '.$recommendation->user->first_name,  'recommendation' => $recommendation, 'template' => 'reject-candidate-recommendation'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));


        return response()->json(['success' => 1, 'message' => 'The candidate has been rejected!', 'data' => $recommendation], 200); 
    }


    public function declineByToken($recommendationID,$token)
    {
        $user = Auth::user();
        $recommendation = JobPostRecommendation::where('id',$recommendationID)->with('job')->first();
        
        $recommendation = JobPostRecommendation::find($recommendationID);
        $job_post_id = $recommendation->job_post_id;

        $job = JobPost::find($job_post_id);
        $company = Company::where($job->company_id);

        if (!$job || $user->company_id == null) {
            return response()->json(['success' => 0, 'msg' => "Could not process the request..."], 500);
        }
        
        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        if ($job->company_id != $user->company_id) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }


        if ($recommendation->status == 'rejected_by_employer') {
            // this is for duplicate request bug
            $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job.company')->with('user')->first();
            return response()->json(['success' => 1, 'message' => 'The candidate has been rejected!', 'data' => $recommendation], 200); 
        }

        if ($recommendation->status != 'waiting_for_employer') {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        if ($recommendation->token != $token) {
            return response()->json(['success' => 0, 'message' => 'Could not process the request...'], 500); 
        }

        if (empty(getenv("APP_EMAIL"))) {
            return 'empty';
        }

        $recommendation->status = 'rejected_by_employer';
        $recommendation->save();

        $recommendation = JobPostRecommendation::where('id','=',$recommendation->id)->with('job.company')->with('user')->first();

        $log = Activity::create([
            'user_id' => $user->id,
            'parent' => 'job-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-recommendation',
            'activity' => 'recommendation-rejected-by-employer',
        ]);

        // send email to ADMIN (employer rejected the job recommendation)
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => $recommendation->job->company->name.' rejected  '.$recommendation->user->first_name,  'recommendation' => $recommendation, 'template' => 'reject-candidate-recommendation'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));

        return response()->json(['success' => 1, 'message' => 'The candidate has been rejected!', 'data' => $recommendation], 200); 
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
            $recommendation->status = 'waiting_for_employer';
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
                'activity' => 'candidate-recommended-to-employer',
            ]);
        }

        // send email via queue
        QueueCandidateRecommendationEmail::dispatch($to_queue);

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