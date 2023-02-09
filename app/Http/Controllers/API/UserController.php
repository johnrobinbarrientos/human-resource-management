<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\Company;
use App\Models\Note;
use App\Models\User;
use App\Models\UserFile;

use App\Models\JobPost;
use App\Models\JobPostRecommendation;

use App\Mail\SendMail;

use Illuminate\Support\Facades\Auth; 

class UserController extends Controller
{
    public function search()
    {
        $keyword = request()->q;
        $type = request()->type;
        $text = request()->text;
        $job_post_id = request()->job_post_id;
        $job_recommendation_status = request()->job_recommendation_status;

        $type = ($type == 'Employer') ?  $type  : 'Candidate';
        
        $users = User::where('type','=',$type)->where(function($query) use ($keyword) {
            $query->where('first_name','LIKE','%'.$keyword.'%')
            ->orWhere('last_name','LIKE','%'.$keyword.'%')
            ->orWhere('email','LIKE','%'.$keyword.'%');
        });
        
        // if filter by job post
        if (!empty($job_post_id) && $job_post_id != 0) {
            
            $job_post_recommendation_user_ids = ($job_recommendation_status == 'all') 
                ? JobPostRecommendation::where('job_post_id','=',$job_post_id)->pluck('user_id')->toArray()
                : JobPostRecommendation::where('job_post_id','=',$job_post_id)->where('status','=',$job_recommendation_status)->pluck('user_id')->toArray();

            $users = $users->whereIn('id',$job_post_recommendation_user_ids);
        }
        
        $users = $users->get();

        foreach ($users as $user) {
            $user->text = ($text == 'company')  ? $user->company_name : $user->first_name.' '.$user->last_name;
        }
            
        return response()->json(['success' => 1, 'rows' => $users], 200); 
    }

    public function index()
    {
        $type = request()->type;
        $type = (empty($type)) ? 'all' : $type;
        $keyword = request()->keyword;

        $availability = (empty(request()->availability)) ? 'all' : request()->availability;
        $personal_vehicle = (empty(request()->personal_vehicle)) ? 'all' : request()->personal_vehicle;
        $job_category = (empty(request()->job_category)) ? 'all' : request()->job_category;


        # Admin: GET all users
        if ($type === 'all' && Auth::user()->type === 'Admin')
        {
            $users = User::where('id','>',0)->orderBy('created_at','desc');
        }
        # Admin: GET all users based on user type.
        else if (Auth::user()->type === 'Admin')
        {
            if ($job_category!='all') {

                $users = User::leftJoin('user_skills', function($join) {
                    $join->on('users.id', '=', 'user_skills.user_id');
                  })
                  ->where('user_skills.job_subcategory_item_id', $job_category)
                  ->where('type','=',$type)->
                  orderBy('users.created_at','desc');

            }else{
                $users = User::with('company')->with('UserSkill')->where('type','=',$type)->orderBy('created_at','desc');
            }
        }
        # Employer (company admin): get user based on company
        else if ($type === 'Employer' && Auth::user()->is_company_admin)
        {
            $users = User::with('company')->where('company_id','=',Auth::user()->company_id);
        }
        # access not allowed
        else {
            return response()->json(['success' => 0, 'message' => 'Oops Something went wrong'], 500);
        }
        

       // $users = $users->leftJoin('companies', 'companies.id', '=', 'users.company_id');
        
        if (!empty($keyword)) {
            $users = $users->where(function($query) use ($keyword) {
                $query->where('first_name','like','%'.$keyword.'%')
                    ->orWhere('last_name','like','%'.$keyword.'%')
                    ->orWhere('email','like','%'.$keyword.'%')
                    ->orWhere('location','like','%'.$keyword.'%');
            });
        }

        if ($availability!='all') {
            if ($availability=='yes') {
                $users = $users->where('is_available','=',1);
            }else{
                $users = $users->where('is_available','=',0);
            }
        }

        if ($personal_vehicle!='all') {
            if ($personal_vehicle=='yes') {
                $users = $users->where('is_personal_vehicle_available','=',1);
            }else{
                $users = $users->where('is_personal_vehicle_available','=',0);
            }
        }

        /* pagination start */
        $count = $users->count();
        $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
        $page = (is_numeric(request()->page)) ? request()->page : 1;
        $offset = (($page - 1 ) * $take);
        
        $users = $users->take($take);
        $users = $users->offset($offset);
        $users = $users->get();
        /* pagination end */


        return response()->json(['success' => 1, 'rows' => $users, 'count' => $count], 200);
    }

    public function getProfile($id) {
        $user = User::with('company')->find($id);

        if (isset(request()->tickets) && request()->tickets == 'yes') {
            $tickets = UserFile::where('user_id',$user->id)->where('type','=','ticket')->get();
        }

        $avatar = UserFile::find($user->file_avatar_id);
        $avatar = ($avatar) ? asset('storage/avatars/'.$avatar->name) : null;

        $user->avatar = $avatar;

        return response()->json(['success' => 1, 'data' => $user, 'tickets' => $tickets], 200);
    }

    public function store()
    {
        $first_name = request()->first_name;
        $last_name = request()->last_name;
        $email = request()->email;
        $phone = request()->phone;
        $country_code = request()->country_code;
        $password = request()->password;
        $password2 = request()->password2;
        $type = request()->type;
        $type = ($type != 'Admin' && $type != 'Employer' && $type != 'Candidate') ? 'Candidate' : $type;
        $company_id = request()->company_id;


        # if user type is employer
        // $company_name = ucwords(request()->company_name);
        $is_company_admin = request()->is_company_admin;

        if (empty($first_name) || empty($last_name)  || empty($email) || empty($password)) {
            return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
        }

        if (strlen($password) < 8) {
            return response()->json(['success' => 0, 'message' => 'The password must be at least 8 characeters long'],500); 
        }

        if ($password != $password2) {
            return response()->json(['success' => 0, 'message' => 'Password not matched!'],500); 
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return response()->json(['success' => 0, 'message' => 'You have entered an invalid email address'],500); 
        } 

        $exists = User::where('email','=',$email)->withTrashed()->first();

        if ($exists && $exists->email = $email && !$exists->trashed()) {
            return response()->json(['success' => 0, 'message' => 'The email address has already been taken'],500); 
        }

        if (($type === 'Employer' && $company_id === null) && empty($company_name)) {
            return response()->json(['success' => 0, 'message' => 'Please enter company name'], 500);
        }

        $user = User::where('email','=',$email)->withTrashed()->first();
        $user = (!$user) ? new User() : $user;
        $user->first_name = $first_name;
        $user->last_name = $last_name;
        $user->email = $email;
        $user->phone = $phone;
        $user->country_code = $country_code;
        $user->type = $type;
        $user->password = \Hash::make($password);
        $user->is_company_admin = $is_company_admin;
        $user->company_id = $company_id;
        $user->deleted_at = null;
        
        $user->is_verified = 1;
        $user->verification_status = 'verified';

        $user->save();

        # all admin will be pointed to PRIMUS company
        // if ($type === 'Admin') {
        //     $user->company_id = 1;
        //     $user->save();
        // } else if ($type === 'Employer' && $is_company_admin  && $company_id === null) {
        //     # only "employer admin" can create a new company
        //     $company = new Company;
        //     $company->name = $company_name;
        //     $company->email = $email;
        //     $company->phone = $phone;
        //     $company->country_code = $country_code;
        //     $company->save();

        //     $user->company_id = $company->id;
        //     $user->save();
            
        //     $user->company = $company;
        // } else if ($type === 'Employer' && !$is_company_admin  && $company_id !== null) {
        //     # else: employer is not a company admin
        //     $company = Company::find($company_id);
        //     $user->save();
        //     $user->company = $company;
        // }

        return response()->json(['success' => 1, 'data' => $user, 'message' => 'User Added!'], 200);  
    }

    
    public function updateProfile($id)
    {

        
        $first_name = ucwords(request()->first_name);
        $last_name = ucwords(request()->last_name);
        $email = request()->email;
        $phone = request()->phone;
        $country_code = request()->country_code;

        $company_id = request()->company_id;
        $is_company_admin = request()->is_company_admin;

        // Validate fields
        if (empty($first_name) || empty($last_name)  || empty($email)) {
            return response()->json(['success' => 0, 'message' => 'Please check all the required fields.'],500);   
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return response()->json(['success' => 0, 'message' => 'You have entered an invalid email address.'],500); 
        } 
        
        $exists = User::where('email','=',$email)->first();

        // ensures 'if email $exists' it should be the owner otherwise its already taken
        if ($exists && $exists->id != $id) {
            return response()->json(['success' => 0, 'message' => 'The email address has already been taken.'],500); 
        }

        

        $user = User::find($id);

        
        $user->first_name = $first_name;
        $user->last_name = $last_name;
        $user->email = $email;
        $user->phone = $phone;
        $user->country_code = $country_code;
        $user->is_company_admin = $is_company_admin;
        $user->company_id = $company_id;
        
        // Should be on another method when updating company details----John

        # sync 'employer admin' to his 'company' details
        // if(($user->type === 'Employer' && $user->is_company_admin == true) || Auth::user()->type === 'Admin') {
        //     var_dump('asdasdsa');
        //     die();
        //     $company_id = $user->company_id;
        //     $company = Company::find($company_id);

        //     $company->email = $email;
        //     $company->phone = $phone;
        //     $company->save();
        // }

        $user->save();
        
        return response()->json(['success' => 1, 'data' => $user, 'message' => 'User Updated.'], 200);  
    }

    public function updatePassword($id)
    {
        $current_password = request()->current;
        $new_password = request()->new;
        $confirm_new_password = request()->confirm_new;

        if(empty($current_password) || empty($new_password) || empty($confirm_new_password)) {
            return response()->json(['success' => 0, 'message' => 'Required fields must be completed.'],500); 
        }

        if ($new_password != $confirm_new_password) {
            return response()->json(['success' => 0, 'message' => 'Password not matched.'],500); 
        }

        if (strlen($new_password) < 8) {
            return response()->json(['success' => 0, 'message' => 'The password must be at least 8 characeters long.'],500); 
        }
        
        $user = User::find($id);
        $password_check = \Hash::check($current_password, $user->password);

        if(!$password_check) {
            return response()->json(['success' => 0, 'message' => 'Invalid current password credential.'],500);
        }
        $new_password = \Hash::make($new_password);
        $user->password = $new_password;
        $user->save();

        return response()->json(['success' => 1, 'message' => 'Password successfully changed.'],200); 
    }


    public function updateCompany($id)
    {
        $user = User::find($id);
        $company_id = $user->company_id;
        $company = Company::find($company_id);

        // if user type is employer
        $company_name = ucwords(request()->company_name);
        $address = request()->address;
        $description = request()->description;


        if ($user->type === 'Employer') {
            if (empty($company_name))
            {
                return response()->json(['success' => false, 'message' => 'Please enter company name'], 500);
            }
            if (empty($address))
            {
                return response()->json(['success' => false, 'message' => 'Please enter address'], 500);
            }
            if (empty($description))
            {
                return response()->json(['success' => false, 'message' => 'Please enter a company description'], 500);
            }
        }

        $company->name = $company_name;
        $company->address = $address;
        $company->description = $description;

        $company->save();
        
        return response()->json(['success' => 1, 'data' => $company, 'message' => 'Company successfully changed.'],200); 
    }

    public function updateCandidateProfile()
    {
        $field = request()->field;
        $first_name = ucwords(request()->first_name);
        $last_name = ucwords(request()->last_name);
        $email = request()->email;
        $phone = request()->phone;
        $country_code = request()->country_code;
        $is_available = request()->is_available;
        $is_personal_vehicle_available = request()->is_personal_vehicle_available;
        $date_available = request()->date_available;
        $date_of_birth = request()->date_of_birth;
        $location = request()->location;
        $content = request()->content;
        $candidate_id = request()->user_id;


        $candidate = User::find($candidate_id);

        if ($field == 'fullname') {
            if (empty($first_name) || empty($last_name)) {
                return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
            }

            $candidate->first_name = $first_name;
            $candidate->last_name = $last_name;
            $candidate->save();
        }

        if ($field == 'email') {
            if (empty($email)) {
                return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
            }

            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                return response()->json(['success' => 0, 'message' => 'You have entered an invalid email address.'],500); 
            } 

            $exists = User::where('email','=',$email)->first();

            // ensures 'if email $exists' it should be the owner otherwise its already taken
            if ($exists && $exists->id != $candidate_id) {
                return response()->json(['success' => 0, 'message' => 'The email address has already been taken.'],500); 
            }

            $auth = Auth::user();
            
            if (!$exists && $auth->type == 'Admin') {
                $candidate->email = $email;
                $candidate->save();

                
            } else if (!$exists && $auth->type == 'Candidate') {

                $candidate->confirmation_code = 'vrfy-'.\Uuid::generate(4);
                $candidate->new_email = $email;
                $candidate->save();

               // send verification code email
               $confirmation_code = $candidate->confirmation_code;
               $url = getenv("APP_URL").'/email-change-verify/'.$confirmation_code;
               $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Please Confirm Your Email - Action Required',  'user' => $candidate, 'url' => $url, 'template' => 'email-change-confirmation'];
               \Mail::to($candidate->new_email)->queue(new SendMail($data));
            }

            

            
        }

        if ($field == 'phone') {
            if (empty($phone)) {
                return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
            }

            $candidate->phone = $phone;
            $candidate->country_code = $country_code;
            $candidate->save();
        }

        if ($field == 'available_to_work') {
            $candidate->is_available = $is_available;
            $candidate->save();
        }

        if ($field == 'personal_vehicle') {
            $candidate->is_personal_vehicle_available = $is_personal_vehicle_available;
            $candidate->save();
        }


        if ($field == 'date_available') {
            if (empty($date_available)) {
                return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
            }

            $candidate->date_available = $date_available;
            $candidate->save();
        }

        if ($field == 'date_of_birth') {
            if (empty($date_of_birth)) {
                return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
            }

            $candidate->date_of_birth = $date_of_birth;
            $candidate->save();
        }

        if ($field == 'location') {
            if (empty($location)) {
                return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
            }

            $candidate->location = $location;
            $candidate->save();
        }

        if ($field == 'content') {
            if (empty($content)) {
                return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
            }

            $candidate->content = $content;
            $candidate->save();
        }

        
        return response()->json(['success' => 1, 'data' => $candidate, 'userprofile' => 1, 'message' => 'User Updated.'], 200);  
    }

    public function uploadAvatar(Request $request)
    {
        $file = $request->file('file');

        $ext =           $file->extension();
        $original_name = $file->getClientOriginalName();
        $size =          $file->getSize();

        if ($ext != 'jpg' && $ext != 'jpeg' && $ext != 'png') {
            return response()->json(['success' => 0, 'message' => 'You have uploaded an invalid file '.$ext],500); 
        }

        $user_id = request()->user_id;
        $auth = Auth::user();
        $user = User::find($user_id);

        // if ($auth->type != 'Admin' && $auth->id != $user_id) {
        //     return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500); 
        // }

        $name = 'avatar-'.$user->id.'-'.time();
        $name = $name.'.'.$ext;

        $new = new UserFile;
        $new->user_id = $user->id;
        $new->type = 'avatar';
        $new->name = $name;
        $new->original_name = $original_name;
        $new->size = $size;
        $new->save();
        
        $path = 'avatars';
        $file->storeAs($path, $name,['disk' => 'public']);

        $resume = User::where('id','=',$user->id)->first();
        $resume->file_avatar_id = $new->id;
        $resume->save();

        return response()->json(['success' => 1, 'message' => 'Avatar has been successfully uploaded', 'url' => asset('storage/'.$path.'/'.$name)],200);
    }
}