<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\UserSkill;
use App\Models\JobCategory; 
use App\Models\JobPost; 
use App\Models\JobPostApplication; 
use App\Models\JobPostSkill; 
use App\Models\JobPostRecommendation; 

use Illuminate\Support\Facades\Auth; 

class JobPostApplicationController extends Controller
{
    public function index()
    {

    }

    public function store($jobPostID)
    {
        $message = request()->message;

        if (empty($message)) {
            return response()->json(['success' => 0, 'message' => 'Please enter your message'],500);
        }

        $user = Auth::user();

        $application = JobPostApplication::where('user_id','=',$user->id)->where('job_post_id','=',$jobPostID)->first();
        $application = ($application) ? $application : new  JobPostApplication();
        $application->job_post_id = $jobPostID;
        $application->user_id = $user->id;
        $application->message = $message;
        $application->save();

        return response()->json(['success' => 1, 'data' => $application],200);
    }


    public function delete($jobPostID)
    {
        $message = request()->message;

        $action = request()->action;
        $action = ($action == 'deleted' || $action == 'ignored') ? $action : 'deleted';



        $user = Auth::user();
        $application = JobPostApplication::where('user_id','=',$user->id)->where('job_post_id','=',$jobPostID)->first();
        $application = ($application) ? $application : new  JobPostApplication();
        $application->job_post_id = $jobPostID;
        $application->user_id = $user->id;

        if (!empty($message)) {
            $application->message = $message;
        }

        if($action == 'ignore'){
            $application->status = $action;
            $application->save();
        } // "ignore" if the worker made the action and "decline" if the employer made  the action
        if($action == 'deleted'){
            $application->delete();
        }


        return response()->json(['success' => 1, 'data' => $application],200);
    }
}