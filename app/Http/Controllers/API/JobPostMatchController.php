<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\UserSkill;
use App\Models\JobCategory; 
use App\Models\JobSubcategoryItem; 
use App\Models\JobPost; 
use App\Models\JobPostSkill; 
use App\Models\JobPostRecommendation; 
use App\Models\JobWorkerRecommendation; 

use Illuminate\Support\Facades\Auth; 

class JobPostMatchController extends Controller
{
    public function index($jobPostID)
    {
        $post = JobPost::find($jobPostID);

        $post->skills = JobPostSkill::where('job_post_id','=',$post->id)->pluck('job_subcategory_item_id')->toArray();

        $deleted_user_ids = User::onlyTrashed()->pluck('id')->toArray();
        $post->matches = UserSkill::whereNotIn('user_id',$deleted_user_ids)->whereIn('job_subcategory_item_id',$post->skills)->with('user')->groupBy('user_id')->get();

        foreach ($post->matches as $match) {
            $job_recommendation = JobPostRecommendation::where('job_post_id','=',$jobPostID)->where('user_id','=',$match->user->id)->first();
            $match->job_recommendation = $job_recommendation;

            $worker_recommendation = JobWorkerRecommendation::where('job_post_id','=',$jobPostID)->where('user_id','=',$match->user->id)->first();
            $match->worker_recommendation = $worker_recommendation;
        }

        return response()->json(['success' => 1, 'rows' => $post], 200);
    }

    public function skills($job_post_id,$user_id)
    {
        $post = JobPost::find($job_post_id);

        $job_post_skills = JobPostSkill::where('job_post_id','=',$job_post_id)->pluck('job_subcategory_item_id')->toArray();
        $user_skills = UserSkill::where('user_id','=',$user_id)->pluck('job_subcategory_item_id')->toArray();
        
        $results = array_intersect($job_post_skills, $user_skills);

        $results = JobSubcategoryItem::whereIn('id',$results)->with('jobType')->get();

        return response()->json(['success' => 1, 'rows' => $results], 200);
    }

}