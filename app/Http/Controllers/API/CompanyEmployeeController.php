<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User; 
use App\Models\CompanyEmployee; 
use App\Models\JobWorkerRecommendation; 
use App\Models\JobPostRecommendation; 

use Illuminate\Support\Facades\Auth; 

class CompanyEmployeeController extends Controller
{

    public function getEmployees()
    {
        $user = Auth::user();
        $keyword = request()->keyword;

        if ($user->type == 'Admin')
        {
            $employees = CompanyEmployee::with('job')->with('user')->with('company');

            $employees = $employees->orderBy('company_employees.created_at','desc');
            
            /* pagination start */
            $count = $employees->count();
            $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
            $page = (is_numeric(request()->page)) ? request()->page : 1;
            $offset = (($page - 1 ) * $take);
            
            $employees = $employees->take($take);
            $employees = $employees->offset($offset);
            $employees = $employees->get();
            /* pagination end */

            if (!empty($keyword)) {
                $employees = CompanyEmployee::leftJoin('users', 'users.id', '=', 'company_employees.user_id')
                ->leftJoin('job_posts', 'job_posts.id', '=', 'company_employees.job_post_id')
                ->leftJoin('personnel_requests', 'job_posts.personnel_request_id', '=', 'personnel_requests.id')
                ->leftJoin('companies', 'companies.id', '=', 'company_employees.company_id');

                $employees = $employees->where(function($query) use ($keyword) {
                    $query->where('users.first_name','like','%'.$keyword.'%')
                    ->orWhere('users.last_name','like','%'.$keyword.'%')
                    ->orWhere('companies.name','like','%'.$keyword.'%')->get();
                });
            }



        } else {
            # ..user is 'Employer'
            $employees = CompanyEmployee::with('job')->with('user')->with('company')->where('company_id', $user->company_id);

             /* pagination start */
             $count = $employees->count();
             $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
             $page = (is_numeric(request()->page)) ? request()->page : 1;
             $offset = (($page - 1 ) * $take);
             
             $employees = $employees->take($take);
             $employees = $employees->offset($offset);
             $employees = $employees->get();
             /* pagination end */
            
        }

        return response()->json(['success' => 1, 'rows' => $employees, 'count' => $count], 200);
    }

    public function getCompany($user_id)
    {
        $employee = CompanyEmployee::where('user_id', $user_id)->where('status','=','active')->with('company')->with('user')->first();
        return response()->json(['success' => 1, 'data' => $employee],200);
    }

    public function removeOrRehireEmployee($company_id, $employee_id)
    {
        if (request()->action == 'remove') {
            # make worker inactive
            $employee = CompanyEmployee::where('user_id', $employee_id)
                ->where('company_id', $company_id)
                ->where('job_post_id', request()->job_post_id)
                ->where('status','=','active')
                ->first();

            $employee->status = 'removed';
            $employee->save();

            # remove candidate's company tag
            $user = User::where('id', $employee_id)->where('company_id', $company_id)->first();
            $user->company_id = null;
            $user->save();

            # mark 'job worker recommendation to employer' as 'removed (by employer)' to inform admin
            $jobworker = JobWorkerRecommendation::where('user_id', $employee_id)
                ->where('job_post_id', request()->job_post_id)
                ->first();
            $jobworker->status = 'removed';
            $jobworker->save();

            # mark 'job post recommendation to candidate' as 'removed' to inform worker
            $jobpost = JobPostRecommendation::where('user_id', $employee_id)
                ->where('job_post_id', request()->job_post_id)
                ->first();
            $jobpost->status = 'removed';
            $jobpost->save();

            return response()->json(['success' => 1, 'data' => [$employee, $user, $jobworker, $jobpost]], 200);
        }



        /** if RE-HIRE **/

        # make sure worker is not hired by others.
        $user = User::find($employee_id);
        if ($user->company_id != NULL) {
            return response()->json(['success' => 0, 'msg' => 'Worker is no longer available.'], 500);
        }

        # make worker status as being invited to be re-hired
        $employee = CompanyEmployee::where('user_id', $employee_id)
            ->where('company_id', $company_id)
            ->where('job_post_id', request()->job_post_id)
            ->where('status','removed')->orWhere('status', 'declined')
            ->first();

        $employee->status = 'rehiring';
        $employee->save();

        # mark 'job worker recommendation to employer' as 'rehiring (by employer)' to inform admin
        $jobworker = JobWorkerRecommendation::where('user_id', $employee_id)
            ->where('job_post_id', request()->job_post_id)
            ->first();
        $jobworker->status = 'rehiring';
        $jobworker->save();

        # mark 'job post recommendation to candidate' as 'rehiring' to inform worker
        $jobpost = JobPostRecommendation::where('user_id', $employee_id)
            ->where('job_post_id', request()->job_post_id)
            ->first();
        $jobpost->status = 'rehiring';
        $jobpost->save();

        return response()->json(['success' => 1, 'data' => [$user, $jobworker, $jobpost]], 200);
    } 
}