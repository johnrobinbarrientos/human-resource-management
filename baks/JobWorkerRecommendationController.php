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
use App\Models\CompanyEmployee;


use Illuminate\Support\Facades\Auth; 
use Activity;

class JobWorkerRecommendationController extends Controller
{
    
    public function index()
    {
        $user = Auth::user();
        $job_posts_ids = JobPost::where('company_id','=',$user->company_id)->pluck('id')->toArray();
        $recommendations = JobWorkerRecommendation::whereIn('job_post_id',$job_posts_ids)->with('user')->with('job')->get();

        return response()->json(['success' => 1, 'rows' => $recommendations], 200);
    }

    public function show($jobPostID)
    {
        $post = JobPost::find($jobPostID);
        $recommendations = JobWorkerRecommendation::where('job_post_id','=',$post->id)->with('user')->with('job')->get();

        return response()->json(['success' => 1, 'rows' => $recommendations], 200);
    }

    public function accept($jobPostID,$workerID)
    {
        $user = Auth::user();
        $worker = User::find($workerID);
        
        if (!$worker) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        $recommendation = JobWorkerRecommendation::where('job_post_id','=',$jobPostID)->where('user_id','=',$workerID)->first();

        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }


        if ($recommendation->status == 'pending' || $recommendation->status == 'sent' ) {
            $log = Activity::create([
                'user_id' => $user->id,
                'parent' => 'job-worker-recommendation',
                'parent_id' => $recommendation->id,
                'type' => 'job-worker-recommendation',
                'activity' => 'accepted',
            ]);
        }

        $recommendation->status = 'accepted';
        $recommendation->save();

        $user_employee = new CompanyEmployee();
        $user_employee->company_id = $user->company_id;
        $user_employee->user_id = $workerID;
        $user_employee->job_post_id = $jobPostID;
        $user_employee->status = 'active';
        $user_employee->save();

        $worker->company_id = $user->company_id;
        $worker->save();

        
        # in order to notify candidate of employers acceptance.
        $JobPostRecommendation = JobPostRecommendation::where('job_post_id', '=', $jobPostID)->where('user_id','=',$workerID)->first();
        $JobPostRecommendation->status = 'accepted_by_employer';
        $JobPostRecommendation->save();
        
        return response()->json(['success' => 1, 'message' => $worker->first_name.' has been hired!', 'data' => $recommendation], 200); 
    }

    public function decline($jobPostID,$userID)
    {
        $user = Auth::user();

        $worker = User::find($userID);
        
        if (!$worker) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        $recommendation = JobWorkerRecommendation::where('job_post_id','=',$jobPostID)->where('user_id','=',$userID)->first();
        
        if (!$recommendation) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'], 500); 
        }

        if ($recommendation->status == 'pending' || $recommendation->status == 'sent' ) {
            $log = Activity::create([
                'user_id' => $user->id,
                'parent' => 'job-worker-recommendation',
                'parent_id' => $recommendation->id,
                'type' => 'job-worker-recommendation',
                'activity' => 'declined',
            ]);
        }

        $recommendation->status = 'declined';
        $recommendation->save();

        return response()->json(['success' => 1, 'message' => $worker->first_name.' has been declined!', 'data' => $recommendation], 200); 
    }


    public function save($jobPostID)
    {
        $post = JobPost::find($jobPostID);
        $user = User::find(request()->user_id);

        $recommendation = JobWorkerRecommendation::where('job_post_id','=',$jobPostID)
            ->where('user_id','=',$user->id)
            ->withTrashed()
            ->first();

        $recommendation = ($recommendation) ? $recommendation : new  JobWorkerRecommendation();
        $recommendation->job_post_id = $jobPostID;
        $recommendation->user_id = $user->id;
        $recommendation->deleted_at = null;
        $recommendation->save();


        $log = Activity::create([
            'user_id' => $post->user_id,
            'parent' => 'job-worker-recommendation',
            'parent_id' => $recommendation->id,
            'type' => 'job-worker-recommendation',
            'activity' => 'sent',
        ]);
        
        $recommendation = JobWorkerRecommendation::where('job_post_id','=',$recommendation->job_post_id)->where('user_id','=',$recommendation->user_id)->first();

        return response()->json(['success' => 1, 'row' => $recommendation, 'message' => $user->first_name.' has been recommended'], 200); 
    }


    public function delete($jobPostID)
    {
        $post = JobPost::find($jobPostID);
        $user = User::find(request()->user_id);

        $recommended = JobWorkerRecommendation::where('job_post_id','=',$jobPostID)
            ->where('user_id','=',$user->id)
            ->first();

        if ($recommended) {
            $recommended->delete();
        }

        return response()->json(['success' => 1, 'row' => $recommended, 'message' => $user->first_name.' has been removed from recommended list'], 200); 
    }

}