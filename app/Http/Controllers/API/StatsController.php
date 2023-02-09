<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\ActivityLog;
use App\Models\User;
use App\Models\UserSkill;
use App\Models\JobCategory; 
use App\Models\JobPost; 
use App\Models\JobPostSkill; 
use App\Models\JobPostRecommendation; 
use App\Models\JobPostApplication;
use App\Models\PersonnelRequest;
use App\Models\CompanyEmployee;

use Illuminate\Support\Facades\Auth; 
use Activity;

class StatsController extends Controller
{
    public function counter()
    {
        $jobs = JobPost::where('id','>=',1)->count();
        $personnel_requests = PersonnelRequest::where('id','>=',1)->count();
        $employers = User::where('type','=','Employer')->count();
        $cadidates = User::where('type','=','Candidate')->count();

        return response()->json(['success' => 1, 'jobs' => $jobs, 'personnel_requests' => $personnel_requests, 'employers' => $employers, 'cadidates' => $cadidates], 200); 
    }

    public function employerCounter()
    {
        $user = Auth::user();
        $jobs = JobPost::where('company_id', $user->company_id)->count();
        $personnel_requests = PersonnelRequest::where('company_id', $user->company_id)->count();
        $employees = CompanyEmployee::where('company_id', $user->company_id)->count();
        
        return response()->json(['success' => 1, 'personnel_requests' => $personnel_requests, 'jobs' => $jobs, 'employees' => $employees], 200); 
    }

    public function activities()
    {
        $user = Auth::user();
        

        $take = (request()->take && request()->take <= 20) ? request()->take : 10;
        $page = (request()->page) ? request()->page : 1;
        $skip = $take * ($page - 1);

        if ($user->type == 'Admin') {
            $logs = ActivityLog::where('type','=','job-recommendation')->orWhere('type','=','job-worker-recommendation')->take($take)->skip($skip)->orderBy('id','DESC')->get();
        } else {
            $logs = ActivityLog::where('user_id','=',$user->id)
                ->where(function($query) {
                    $query->where('type','=','job-recommendation');
                })
                ->orWhere(function($query) {
                    $query->where('type','=','job-worker-recommendation');
                })
                ->take($take)
                ->skip($skip)
                ->orderBy('id','DESC')
                ->get();
        }

        //dd($logs);

        foreach ($logs as $log) {
            // dd($log);
            $log->render = Activity::render($user,$log);
        }

        return response()->json(['success' => 1, 'activities' => $logs], 200);
    }

}