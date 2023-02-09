<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User; 
use App\Models\UserFile; 
use App\Models\UserResume; 
use App\Models\UserSkill; 
use App\Models\UserTicket;


use App\Models\UserProfileExport; 
use App\Models\UserProfileExportItem; 

use App\Models\JobSubcategory; 
use App\Models\JobSubcategoryItem;

use App\Mail\SendMail;

use Illuminate\Support\Facades\Auth; 
use Illuminate\Support\Facades\Storage; 
use Illuminate\Support\Str;

use Spipu\Html2Pdf\Html2Pdf;

class UserResumeController extends Controller
{

    public function test()
    {
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'TEST QUEUE', 'message' => 'HI THERE! ==> '.date('H:i:s'), 'user' => User::find(1), 'template' => 'message'];
        \Mail::to('kenjimagto@gmail.com')->queue(new SendMail($data));

        return response()->json(['success' => 1, 'message' => 'Invalid email and password!'], 200);
    }

    public function show($id)
    {

        if(!empty($id)){
            $user = User::where('id','=',$id)->first();
        }
        
        if($id == 'no-thread'){
            $user = Auth::user();
        }


        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'Page not found! - user'],404);
        }

        $resume = UserResume::where('user_id','=',$user->id)->first();
        
        if (!$resume && $user->type != 'Candidate') {
            return response()->json(['success' => 0, 'message' => 'Page not found! -candidate'],404);
        }

        if (!$resume) {
            $resume = new UserResume();
            $resume->user_id = $user->id;
            $resume->first_name = $user->first_name;
            $resume->last_name = $user->last_name;
            $resume->email = $user->email;
            $resume->phone = '';
            $resume->location = '';
            $resume->save();
        }

        $avatar = UserFile::find($resume->file_avatar_id);
        $avatar = ($avatar) ? asset('storage/avatars/'.$avatar->name) : null;

        $resume->avatar = $avatar;

        $file_resume = UserFile::find($resume->file_resume_id);
        $file_resume = ($file_resume) ? $file_resume : null;

        $file_tickets = UserFile::where('user_id','=',$user->id)->where('type','=','ticket')->get();
        $file_tickets = ($file_tickets) ? $file_tickets : null;


        $skills = UserSkill::where('user_id','=',$user->id)->pluck('job_subcategory_item_id')->toArray();

        $resume->avatar = $avatar;
        $resume->file_resume = $file_resume;
        $resume->file_tickets = $file_tickets;
        $resume->skills = $skills;

        return response()->json(['success' => 1, 'data' => $resume]);
    }


    public function save()
    {
        $user_id = request()->user_id;

        $first_name         = request()->first_name;
        $last_name          = request()->last_name;
        $phone              = request()->phone;
        $email              = request()->email;
        $date_available     = request()->date_available;
        $location           = request()->location;
        $content            = request()->content;
     
        if (empty($first_name) || empty($last_name) || empty($phone) || empty($email) || empty($date_available) || empty($location)) {
            return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return response()->json(['success' => 0, 'message' => 'You have entered an invalid email address '],500); 
        } 

        $auth = Auth::user();
        $user = User::find($user_id);

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500); 
        }

        $resume = UserResume::where('user_id','=',$user->id)->first();
        $resume = ($resume) ? $resume : new UserResume;
        $resume->first_name = $first_name;
        $resume->last_name = $last_name;
        $resume->email = $email;
        $resume->phone = $phone;
        $resume->date_available = $date_available;
        $resume->location = $location;
        $resume->content = $content;
        $resume->save();
        
        return response()->json(['success' => 1, 'message' => 'Your resume has been successfully saved!'],200);
    }

    
    public function saveInline()
    {
        $field = request()->field;
        $user_id = request()->user_id;

        $auth = Auth::user();
        $user = User::find($user_id);

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500); 
        }

        $resume = UserResume::where('user_id','=',$user->id)->first();

        if ($field == 'fullname') {
            if (empty(request()->first_name) || empty(request()->first_name)) {
                return response()->json(['success' => 0, 'message' => 'Please check all the required fields'],500);   
            }

            $resume->first_name = request()->first_name;
            $resume->last_name = request()->last_name;
            $resume->save();

        } else if ($field == 'email') {
            if (!filter_var(request()->email, FILTER_VALIDATE_EMAIL)) {
                return response()->json(['success' => 0, 'message' => 'You have entered an invalid email address '],500); 
            }

            $resume->email = request()->email;
            $resume->save();

        }  else if ($field == 'phone') {
            if (empty(request()->phone)) {
                return response()->json(['success' => 0, 'message' => 'Please enter your phone number'],500); 
            }

            $resume->phone = request()->phone;
            $resume->save();

        }  else if ($field == 'date_available') {
            if (empty(request()->date_available)) {
                return response()->json(['success' => 0, 'message' => 'Please enter your availablity date'],500); 
            }

            $resume->date_available = request()->date_available;
            $resume->save();

        }   else if ($field == 'location') {
            if (empty(request()->location)) {
                return response()->json(['success' => 0, 'message' => 'Please enter your location'],500); 
            }

            $resume->location = request()->location;
            $resume->save();

        }   else if ($field == 'content') {
            if (empty(request()->content)) {
                return response()->json(['success' => 0, 'message' => 'Please enter your message'],500); 
            }

            $resume->content = request()->content;
            $resume->save();
        } else {
            // else they're trying to inject other fields
            return response()->json(['success' => 0, 'message' => 'Something went wrong'],500); 
        }


        return response()->json(['success' => 1, 'message' => 'Your resume has been successfully updated!', 'data' => $resume],200);
    }

    public function saveSkill($jobSubcategoryItemId)
    {
        $user_id = request()->user_id;
        $auth = Auth::user();
        $user = User::find($user_id);

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500); 
        }

        $skill = UserSkill::where('user_id','=',$user->id)
            ->where('job_subcategory_item_id','=',$jobSubcategoryItemId)
            ->withTrashed()
            ->first();

        $skill = ($skill) ? $skill : new UserSkill();
        $skill->user_id = $user->id;
        $skill->job_subcategory_item_id = $jobSubcategoryItemId;
        $skill->deleted_at = null;
        $skill->save();

        return response()->json(['success' => 1, 'message' => 'Skill added', 'data' => $skill],200);
    }

    public function deleteSkill($jobSubcategoryItemId)
    {
        $user_id = request()->user_id;
        $auth = Auth::user();
        $user = User::find($user_id);

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500); 
        }

        $skill = UserSkill::where('user_id','=',$user->id)
            ->where('job_subcategory_item_id','=',$jobSubcategoryItemId)
            ->first();

        if ($skill) {
            $skill->delete();
        }
        
        return response()->json(['success' => 1, 'message' => 'Skill added', 'data' => $skill],200);
    }

    public function uploadAvatar(Request $request)
    {
        $file = $request->file('file');
        $ext = $file->extension();
        $original_name = $file->getClientOriginalName();
        $size = $file->getSize();

        if ($ext != 'jpg' && $ext != 'jpeg' && $ext != 'png') {
            return response()->json(['success' => 0, 'message' => 'You have uploaded an invalid file '.$ext],500); 
        }

        $user_id = request()->user_id;
        $auth = Auth::user();
        $user = User::find($user_id);

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500); 
        }

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

        $resume = UserResume::where('user_id','=',$user->id)->first();
        $resume->file_avatar_id = $new->id;
        $resume->save();

        return response()->json(['success' => 1, 'message' => 'Avatar has been successfully uploaded', 'url' => asset('storage/'.$path.'/'.$name)],200);
    }

    public function uploadResume(Request $request)
    {
        
        $file = $request->file('file');
        $ext = $file->extension();
        $original_name = $file->getClientOriginalName();
        $size = $file->getSize();

        if ($ext != 'pdf' && $ext != 'doc' && $ext != 'docx' && $ext != 'txt') {
            return response()->json(['success' => 0, 'message' => 'You have choosen an invalid file "'.$ext.'", please use the following: .doc, .docx, .pdf, .txt'],500); 
        }

        $user_id = request()->user_id;
        $user = User::find($user_id);

        $name = 'resume-'.$user->id.'-'.time();
        $name = $name.'.'.$ext;

        $delete = UserFile::where('user_id','=',$user->id)->delete();

        $new = new UserFile;
        $new->user_id = $user->id;
        $new->type = 'resume';
        $new->name = $name;
        $new->original_name = $original_name;
        $new->size = $size;
        $new->save();
        
        $path = 'resumes';
        $file->storeAs($path, $name,['disk' => 'public']);

        return response()->json(['success' => 1, 'message' => 'Resume has been successfully uploaded', 'data' => $new, 'url' => asset('storage/'.$path.'/'.$name)],200);
    }


    public function uploadTickets(Request $request)
    {
        $user_id = request()->user_id;
        $user = User::find($user_id);

        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'],500);
        }

        $file = $request->file('file');
        $ticket_type = $request->ticket_type;
        $expiry_date = $request->expiry_date;
        
        $ext = $file->extension();
        $original_name = $file->getClientOriginalName();
        $size = $file->getSize();

        if ($ext != 'pdf' && $ext != 'doc' && $ext != 'docx' && $ext != 'txt') {
            return response()->json(['success' => 0, 'message' => 'You have uploaded an invalid file '.$ext.', please use the following: .doc, .docx, .pdf, .txt'],500); 
        }

        $name = 'ticket-'.$user->id.'-'.time().'-'.rand(1000,9999);
        $name = $name.'.'.$ext;

        $new = new UserFile;
        $new->user_id = $user->id;
        $new->type = 'ticket';
        $new->name = $name;
        $new->original_name = $original_name;
        $new->size = $size;
        $new->ticket_type = $ticket_type;
        $new->expiry_date = $expiry_date;
        $new->save();
        
        $path = 'tickets';
        $file->storeAs($path, $name,['disk' => 'public']);


        return response()->json(['success' => 1, 'message' => 'Tickets has been successfully uploaded', 'data' => $new, 'url' => asset('storage/'.$path.'/'.$name)],200);
    }

    public function deleteResumeFile(Request $request){
        $user_id = request()->user_id;
        $auth = Auth::user();
        $user = User::find($user_id);

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500);
        }

        $file = UserFile::where('id','=',$request->file_id)
            ->first();

        if ($file) {
            $file->delete();
        }

        return response()->json(['success' => 1, 'message' => 'file deleted', 'data' => $file],200);
    }

    public function deleteTicketsFile(Request $request){
        $user_id = request()->user_id;
        $auth = Auth::user();
        $user = User::find($user_id);

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action'],500);
        }

        $file = UserFile::where('id','=',$request->ticket_id)
            ->first();

        if ($file) {
            $file->delete();
        }

        return response()->json(['success' => 1, 'message' => 'file deleted', 'data' => $file],200);
    }

    public function exportResume()
    {
        
        if (count(request()->users) < 1) {
            return response()->json(['success' => 0, 'message' => 'Please select a user'],500);
        }

        $auth = Auth::user();

        $export = new UserProfileExport();
        $export->user_id = $auth->id;
        $export->uuid = Str::uuid();
        $export->status = 'pending';
        $export->save();

        foreach (request()->users as $user) {

            $user = User::find($user['id']);

            if (!$user) {
                continue;
            }

            $export_item = new UserProfileExportItem();
            $export_item->user_profile_export_id = $export->id;
            $export_item->user_id = $user->id;
            $export_item->save();
        }

        return response()->json(['success' => 1, 'message' => 'This typically take a couple of minutes, Please check your email to get the exported file.'],200);
    }
}