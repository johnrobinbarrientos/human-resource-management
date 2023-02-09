<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User; 
use App\Models\UserRating; 
use App\Models\JobPost; 

use App\Mail\SendMail;
use Illuminate\Support\Facades\Auth; 

class UserRatingController extends Controller
{
    public function getUserJobRating($user_id,$job_post_id)
    {
        $rating = UserRating::where('user_id','=',$user_id)->where('job_post_id','=',$job_post_id)->first();

        return response()->json(['success' => 1, 'data' => $rating]);
    }

    public function getUserRatings($user_id)
    {
        $ratings = UserRating::where('user_id','=',$user_id)->with('reviewer.company')->get();

        $job_competency = 0;
        $health_safety_performance = 0;
        $work_ethic = 0;
        $count = 0;

        foreach ($ratings as $rating) {
            $count++;
            $job_competency += $rating->job_competency;
            $health_safety_performance += $rating->health_safety_performance;
            $work_ethic += $rating->work_ethic;
        }

        $avg_job_competency             = ($job_competency > 0 ) ? $job_competency / $count : 0;
        $avg_health_safety_performance  = ($health_safety_performance > 0 ) ? $health_safety_performance / $count : 0;
        $avg_work_ethic                 = ($work_ethic > 0 ) ? $work_ethic / $count : 0;

        $avg_total = $avg_job_competency + $avg_health_safety_performance + $work_ethic;
        $avg_total = ($avg_total > 0) ? $avg_total / ($count * 3) : 0;
        
        $averages = [
            'job_competency' => $avg_job_competency,
            'health_safety_performance' => $avg_health_safety_performance,
            'work_ethic' => $avg_work_ethic,
            'total' => $avg_total,
        ];

        return response()->json(['success' => 1, 'ratings' => $ratings, 'averages' => $averages]);
    }

    public function store()
    {
        
        $job_post_id = request()->job_post_id;
        $user_id = request()->user_id;
        $job_competency = request()->job_competency;
        $health_safety_performance = request()->health_safety_performance;
        $work_ethic = request()->work_ethic;
        $comment = request()->comment;

        if ($job_competency < 1) {
            return response()->json(['success' => 0, 'message' => 'Please rate the Job Competency...']);
        }

        if ($health_safety_performance < 1) {
            return response()->json(['success' => 0, 'message' => 'Please rate the Health & Safety Performance...']);
        }

        if ($work_ethic < 1) {
            return response()->json(['success' => 0, 'message' => 'Please rate the Work Ethic...']);
        }

        if (empty(trim($comment))) {
            return response()->json(['success' => 0, 'message' => 'Please say something about your experience']);
        }

        $auth = Auth::user();

        if ($auth->type != 'Employer') {
            return response()->json(['success' => 0, 'message' => 'Only the Employer can perform this action']);
        }

        $job_post = JobPost::find($job_post_id);

        if (!$job_post || $job_post->company_id != $auth->company_id) {
            return response()->json(['success' => 0, 'message' => 'You cannot review this user for this job']);
        }

        $rating = UserRating::where('user_id','=',$user_id)->where('job_post_id','=',$job_post_id)->first();
        
        if ($rating) {
            return response()->json(['success' => 0, 'message' => 'You already submitted a review for this user']);
        }

        $rating = new UserRating();
        $rating->job_post_id = $job_post_id;
        $rating->user_id = $user_id;
        $rating->reviewer_id = $auth->id;
        $rating->job_competency = $job_competency;
        $rating->health_safety_performance = $health_safety_performance;
        $rating->work_ethic = $work_ethic;
        $rating->comment = $comment;
        $rating->save();

        return response()->json(['success' => 1, 'message' => 'Your review has been successfully submitted!']);
    }
}