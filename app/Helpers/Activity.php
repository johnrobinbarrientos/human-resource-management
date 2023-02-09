<?php // Code within app\Helpers\Helper.php

namespace App\Helpers;

use Illuminate\Support\Facades\Auth; 


use App\Models\ActivityLog;
use App\Models\JobCategory; 
use App\Models\JobPost; 
use App\Models\JobPostSkill; 
use App\Models\JobPostRecommendation; 
use App\Models\JobPostApplication;
use App\Models\JobWorkerRecommendation;
use App\Models\PersonnelRequest;
use App\Models\User;

class Activity
{
    public static function create($params)
    {
        $log = new ActivityLog;
        $log->user_id = $params['user_id'];
        $log->parent = $params['parent'];
        $log->parent_id = $params['parent_id'];
        $log->type = $params['type'];
        $log->activity = $params['activity'];
        $log->save();
    }

    public static function render($auth,$log)
    {
        // var_dump('sulod');
        // die();

        if ($log->type == 'job-recommendation') {
           return Self::jobRecommendation($auth,$log);
        } else if ($log->type == 'job-worker-recommendation') {
            return Self::workerRecommendation($auth,$log);
        }

    }

    public static function jobRecommendation($auth,$log)
    {

        
        $job_recommendation = JobPostRecommendation::find($log->parent_id);

        $job_post = null;

        if ($job_recommendation!=null){
            $job_post = JobPost::find($job_recommendation->job_post_id);
        }
        
        
        $user = User::withTrashed()->find($log->user_id);
        $name = ($log->user_id != $auth->id) ? $user->first_name : 'You';
        
        
        if ($job_post!=null){
            // dd($job_post->title);
            if ($log->activity == 'sent') {
                return '<strong>'.$job_post->title.'</strong> has been recommended to <strong>'.$name.'</strong>';
            } else if ($log->activity == 'accepted') {
                return '<strong>'.$name.'</strong> accepted the  <strong>'.$job_post->title.'</strong>';
            } else if ($log->activity == 'declined') {
                return '<strong>'.$name.'</strong> declined the  <strong>'.$job_post->title.'</strong>';
            }
        }
        
    }

    public static function workerRecommendation($auth,$log)
    {
        $worker_recommendation = JobWorkerRecommendation::find($log->parent_id);

        $job_post = null;

        if ($worker_recommendation!=null){
            $job_post = JobPost::find($worker_recommendation->job_post_id);
        }
        
        $user = User::withTrashed()->find($log->user_id);
        $name = ($log->user_id != $auth->id) ? $user->first_name : 'You';
        $worker = User::withTrashed()->find($worker_recommendation->user_id);

        if ($job_post!=null){
            if ($log->activity == 'sent') {
                return '<strong>'.$worker->first_name.'</strong> has been recommended for <strong>'.$job_post->title.'</strong>';
            } else if ($log->activity == 'accepted') {
                return '<strong>'.$name.'</strong> accepted the '.$worker->first_name.' for job  <strong>'.$job_post->title.'</strong>';
            } else if ($log->activity == 'declined') {
                return '<strong>'.$name.'</strong> declined the '.$worker->first_namee.' for job  <strong>'.$job_post->title.'</strong>';
            }
        }
    }
}