<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\UserSkill;
use App\Models\JobPostApplication; 
use App\Models\JobCategory; 
use App\Models\JobPost; 
use App\Models\JobPostCategory; 
use App\Models\JobPostSkill; 
use App\Models\JobPostRecommendation; 
use App\Models\PersonnelRequest; 

use Illuminate\Support\Facades\Auth; 
use Illuminate\Support\Str;

class JobPostController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $keyword = request()->keyword;

        if ($user->type == 'Admin')
        {
            $rows = JobPost::where('id','>',0)->orderBy('created_at','desc');

            if (!empty($keyword)) {
                $rows = $rows->where(function($query) use ($keyword) {
                    $query->where('title','like','%'.$keyword.'%')
                        ->orWhere('location','like','%'.$keyword.'%');
                });
            }

            /* pagination start */
            $count = $rows->count();
            $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
            $page = (is_numeric(request()->page)) ? request()->page : 1;
            $offset = (($page - 1 ) * $take);
            
            $rows = $rows->take($take);
            $rows = $rows->offset($offset);
            $rows = $rows->get();
            /* pagination end */

            foreach ($rows as $row) {
                $row->skills = JobPostSkill::where('job_post_id','=',$row->id)->pluck('job_subcategory_item_id')->toArray();
                $deleted_user_ids = User::onlyTrashed()->pluck('id')->toArray();
                $row->matches = UserSkill::whereNotIn('user_id',$deleted_user_ids)->whereIn('job_subcategory_item_id',$row->skills)->get()->groupBy('user_id')->count();

                // waiting_for_candidate, accepted_by_candidate, rejected_by_candidate													
                // waiting_for_employer, accepted_by_employer, rejected_by_employer	
                $row->applicants = JobPostRecommendation::where('job_post_id','=',$row->id)->whereIn('status',['accepted_by_candidate','waiting_for_employer','accepted_by_employer','rejected_by_employer'])->count();
                $row->recommendations = JobPostRecommendation::where('job_post_id','=',$row->id)->count();
            }
 
        } else if ($user->type == 'Employer') {
            $rows = JobPost::where('user_id','=',$user->id)->orderBy('created_at','desc');;

            if (!empty($keyword)) {
                $rows = $rows->where(function($query) use ($keyword) {
                    $query->where('title','like','%'.$keyword.'%')
                        ->orWhere('location','like','%'.$keyword.'%');
                });
            }

            /* pagination start */
            $count = $rows->count();
            $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
            $page = (is_numeric(request()->page)) ? request()->page : 1;
            $offset = (($page - 1 ) * $take);
             
            $rows = $rows->take($take);
            $rows = $rows->offset($offset);
            $rows = $rows->get();
            /* pagination end */

            $deleted_user_ids = User::onlyTrashed()->pluck('id')->toArray();
            foreach ($rows as $row) {
                $row->skills = JobPostSkill::where('job_post_id','=',$row->id)->pluck('job_subcategory_item_id')->toArray();
                $row->matches = UserSkill::whereNotIn('user_id',$deleted_user_ids)->whereIn('job_subcategory_item_id',$row->skills)->get()->groupBy('user_id')->count();
                $row->recommendations = JobPostRecommendation::where('job_post_id','=',$row->id)->count();
            }
        } else if ($user->type == 'Candidate') {

            $skills = UserSkill::where('user_id','=',$user->id)->pluck('job_subcategory_item_id')->toArray();
            $job_matches = JobPostSkill::whereIn('job_subcategory_item_id',$skills)->groupBy('job_post_id')->pluck('job_post_id')->toArray();
            
            $ignored_applications = JobPostApplication::where('user_id','=',$user->id)->where(function($query) {
                $query->where('status','=','ignored')
                    ->orWhere('status','=','deleted')
                    ->orWhere('status','=','declined');
            })->pluck('job_post_id')->toArray();
            
            $rows = JobPost::whereIn('id',$job_matches)->where('is_public','=',1)->whereNotIn('id',$ignored_applications)->orderBy('created_at','desc');;

            if (!empty($keyword)) {
                $rows = $rows->where(function($query) use ($keyword) {
                    $query->where('title','like','%'.$keyword.'%')
                        ->orWhere('location','like','%'.$keyword.'%');
                });
            }

            /* pagination start */
            $count = $rows->count();
            $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
            $page = (is_numeric(request()->page)) ? request()->page : 1;
            $offset = (($page - 1 ) * $take);
             
            $rows = $rows->take($take);
            $rows = $rows->offset($offset);
            $rows = $rows->get();
            /* pagination end */
            
            foreach ($rows as $row) {
                $row->skills = JobPostSkill::where('job_post_id','=',$row->id)->pluck('job_subcategory_item_id')->toArray();
                $row->application = JobPostApplication::where('job_post_id','=',$row->id)->where('user_id','=',$user->id)->first();
                $row->recommended = JobPostRecommendation::where('job_post_id','=',$row->id)->where('user_id','=',$user->id)->first();
                
                $row->matches = 0;
                $row->recommendations = 0;
            }
        }
        return response()->json(['success' => 1, 'rows' => $rows, 'count' => $count], 200);
    }

    public function search()
    {
        $keyword = request()->q;
        $type = request()->type;
        $text = request()->text;

  
        $job_posts = JobPost::where('title','LIKE','%'.$keyword.'%')->get();

        foreach ($job_posts as $job_post) {
            $job_post->text =  $job_post->title;
        }
            
        return response()->json(['success' => 1, 'rows' => $job_posts], 200); 
    }

    public function show($jobPostID)
    {
        $data = JobPost::where('id',$jobPostID)->with('company')->with('personnel_request')->first();

        if (!$data) {
            return response()->json(['success' => 0, 'message' => 'Could\'nt find the job post...'],500);
        }

        unset($data->personnel_request);
        $data->personnel_request = PersonnelRequest::withTrashed()->where('id','=',$data->personnel_request_id)->first();
        $data->category_ids = JobPostCategory::where('job_post_id','=',$data->id)->pluck('job_category_id')->toArray();
        $data->skills = JobPostSkill::where('job_post_id','=',$data->id)->pluck('job_subcategory_item_id')->toArray();

        return response()->json(['success' => 1, 'data' => $data],200);
    }

    public static function store() {
        
        $title = request()->title;
        $location = request()->location;
        $type = request()->type;

        $description = request()->description;

        $personnel_request_id = request()->personnel_request_id;
        $personnel_request = PersonnelRequest::find($personnel_request_id);

        if ($personnel_request) {
            $company_id = $personnel_request->company_id;
        } else {
            $company_id = request()->company_id;
        }



        $min_hourly_rate = request()->min_hourly_rate;
        $max_hourly_rate = request()->max_hourly_rate;
        $minimum_salary = request()->minimum_salary;
        $maximum_salary = request()->maximum_salary;

        $min_hourly_rate = str_replace("$","",$min_hourly_rate);
        $max_hourly_rate = str_replace("$","",$max_hourly_rate);
        $minimum_salary = str_replace("$","",$minimum_salary);
        $maximum_salary =str_replace("$","",$maximum_salary);

        $external_link = request()->external_link;

        $start_date = request()->start_date;
        $end_date = request()->end_date;

        $skills = request()->skills;
        $subcategteogry_item_ids = (is_array($skills)) ? $skills : []  ;

        $category_ids = request()->category_ids;
        $category_ids = (is_array($category_ids)) ? $category_ids : []  ;


        if (empty($title)) {
            return response()->json(['success' => 0, 'message' => 'Title is required.'],500);
        }



        if (empty($description)) {
            return response()->json(['success' => 0, 'message' => 'Description is required.'],500);
        }

        //$slug = Str::slug($title, "-");

        $user = Auth::user();

        $post = new JobPost;
        $post->user_id = $user->id;
        $post->personnel_request_id = $personnel_request_id;
        $post->company_id = $company_id;

        $post->title = $title;
        $post->type = $type;
        //$post->slug = $slug;
        $post->location = $location;

        $post->description = $description;

        $post->min_hourly_rate = (!empty($min_hourly_rate)) ? $min_hourly_rate : null;
        $post->max_hourly_rate = (!empty($max_hourly_rate)) ? $max_hourly_rate : null;
        $post->minimum_salary = (!empty($minimum_salary)) ? $minimum_salary : null;
        $post->maximum_salary = (!empty($maximum_salary)) ? $maximum_salary : null;
        $post->external_link = $external_link;
        $post->start_date = $start_date;
        $post->end_date = $end_date;
        $post->save();


        $delete = JobPostSkill::where('job_post_id','=',$post->id)->whereNotIn('job_subcategory_item_id',$skills)->delete();
        
        foreach ($subcategteogry_item_ids as $subcategteogry_item_id) {
            
            $skill = JobPostSkill::where('job_post_id','=',$post->id)
            ->where('job_subcategory_item_id','=',$subcategteogry_item_id)
            ->withTrashed()
            ->first();

            $skill = ($skill) ? $skill : new JobPostSkill();
            $skill->job_post_id = $post->id;
            $skill->job_subcategory_item_id = $subcategteogry_item_id;
            $skill->deleted_at = null;
            $skill->save();
        }

        $delete = JobPostCategory::where('job_post_id','=',$post->id)->withTrashed()->delete();
        
        foreach ($category_ids as $category_id) {
            
            $category = JobPostCategory::where('job_post_id','=',$post->id)
            ->where('job_category_id','=',$category_id)
            ->withTrashed()
            ->first();

            $category = ($category) ? $category : new JobPostCategory();
            $category->job_post_id = $post->id;
            $category->job_category_id = $category_id;
            $category->deleted_at = null;
            $category->save();
        }

        return response()->json(['success' => 1, 'data' => $post, 'message' => 'The job has been posted!'],200);
    }

    public static function update() {
        
        $id = request()->id;
        $title = request()->title;
        $type = request()->type;
        $location = request()->location;

        $description = request()->description;
        $personnel_request_id = request()->personnel_request_id;

        $min_hourly_rate = request()->min_hourly_rate;
        $max_hourly_rate = request()->max_hourly_rate;
        $minimum_salary = request()->minimum_salary;
        $maximum_salary = request()->maximum_salary;

        $min_hourly_rate = str_replace("$","",$min_hourly_rate);
        $max_hourly_rate = str_replace("$","",$max_hourly_rate);
        $minimum_salary = str_replace("$","",$minimum_salary);
        $maximum_salary =str_replace("$","",$maximum_salary);

        $external_link = request()->external_link;
        
        
        $skills = request()->skills;
        $subcategteogry_item_ids = (is_array($skills)) ? $skills : []  ;

        $category_ids = request()->category_ids;
        $category_ids = (is_array($category_ids)) ? $category_ids : []  ;


        if (empty($title) || empty($description)) {
            return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);
        }

        $user = Auth::user();

        $post = JobPost::find($id);

        if ($post->user_id != $post->user_id) {
            return response()->json(['success' => 0, 'message' => 'You dont\'t have permission do perform this action'],500);
        }
        $post->title = $title;
        $post->type = $type;
        $post->location = $location;
  
        $post->description = $description;
        $post->personnel_request_id = $personnel_request_id;
        $post->min_hourly_rate = (!empty($min_hourly_rate)) ? $min_hourly_rate : null;
        $post->max_hourly_rate = (!empty($max_hourly_rate)) ? $max_hourly_rate : null;
        $post->minimum_salary = (!empty($minimum_salary)) ? $minimum_salary : null;
        $post->maximum_salary = (!empty($maximum_salary)) ? $maximum_salary : null;
        $post->external_link = $external_link;
        $post->save();

        $delete = JobPostSkill::where('job_post_id','=',$post->id)->whereNotIn('job_subcategory_item_id',$subcategteogry_item_ids)->delete();
        
        foreach ($subcategteogry_item_ids as $subcategteogry_item_id) {
            
            $skill = JobPostSkill::where('job_post_id','=',$post->id)
            ->where('job_subcategory_item_id','=',$subcategteogry_item_id)
            ->withTrashed()
            ->first();

            $skill = ($skill) ? $skill : new JobPostSkill();
            $skill->job_post_id = $post->id;
            $skill->job_subcategory_item_id = $subcategteogry_item_id;
            $skill->deleted_at = null;
            $skill->save();
        }

        $delete = JobPostCategory::where('job_post_id','=',$post->id)->withTrashed()->delete();
        
        foreach ($category_ids as $category_id) {
            
            $category = JobPostCategory::where('job_post_id','=',$post->id)
            ->where('job_category_id','=',$category_id)
            ->withTrashed()
            ->first();

            $category = ($category) ? $category : new JobPostCategory();
            $category->job_post_id = $post->id;
            $category->job_category_id = $category_id;
            $category->deleted_at = null;
            $category->save();
        }

        return response()->json(['success' => 1, 'data' => $post, 'message' => 'The job has been updated!'],200);
    }

    
    public function recommendations($jobPostID)
    {
        $post = JobPost::find($jobPostID);
        $recommendations = JobPostRecommendation::where('job_post_id','=',$post->id)->with('user')->with('job')->get();
        return response()->json(['success' => 1, 'rows' => $recommendations], 200);
    }


    public function saveRecommendation($jobPostID)
    {
        $post = JobPost::find($jobPostID);

        $user = User::find(request()->user_id);

        $recommend = JobPostRecommendation::where('job_post_id','=',$jobPostID)
            ->where('user_id','=',$user->id)
            ->withTrashed()
            ->first();


        $recommend = ($recommend) ? $recommend : new  JobPostRecommendation();
        $recommend->job_post_id = $jobPostID;
        $recommend->user_id = $user->id;
        $recommend->deleted_at = null;
        $recommend->save();

        return response()->json(['success' => 1, 'row' => $recommend, 'message' => $user->first_name.' has been recommended'], 200); 
    }


    public function deleteRecommendation($jobPostID)
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

    public function visibility($jobPostID)
    {
        $post = JobPost::find($jobPostID);

        if (!$post) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'],500);
        }

        $post->is_public = request()->is_public;
        $post->save();

        return response()->json(['success' => 1, 'data' => $post, 'message' => $post->title.' has been updated'], 200); 
    }

    public static function createJobRequest() {
        
        // var_dump(request()->company_id);
        // die();

        $user = Auth::user();

        $post = new JobPost;
        $post->user_id = $user->id;
        $post->personnel_request_id = request()->request_id;
        $post->company_id = request()->company_id;

        $post->title = request()->title;
        $post->type = request()->type;
        $post->location = request()->job_location;
        $post->description = request()->description;
        $post->start_date = request()->start_date;
        $post->end_date = request()->end_date;
        $post->save();


        foreach (request()->skills as $skill) {
            $post_skill = new JobPostSkill;
            $post_skill->job_post_id = $post->id;
            $post_skill->job_subcategory_item_id = $skill;
            $post_skill->save();
        }



        return response()->json(['success' => 1, 'data' => $post, 'message' => 'The job has been posted!'],200);
    }




}