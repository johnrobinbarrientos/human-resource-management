<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User; 
use App\Models\UserFile; 
use App\Models\UserResume; 
use App\Models\UserSkill; 
use App\Models\UserTicket; 

use Illuminate\Support\Facades\Auth; 

class UserSkillController extends Controller
{
    public function index($user_id)
    {
        $user_skills = UserSkill::where('user_id', $user_id)->whereNull('deleted_at')->get();
        return response()->json(['success' => 1, 'rows' => $user_skills], 200);
    }

    public function update($user_id)
    {
        $auth = Auth::user();
        $user = User::find($user_id);

        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500); 
        }

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500); 
        }

        $skills = (isset(request()->skills) && is_array(request()->skills)) ? request()->skills : [];
        
        UserSkill::where('user_id','=',$user->id)->whereNotIn('job_subcategory_item_id',$skills)->delete();

        foreach ($skills as $skill) {
            $data = UserSkill::where('user_id','=',$user->id)
            ->where('job_subcategory_item_id','=',$skill)
            ->withTrashed()
            ->first();

            $data = ($data) ? $data : new UserSkill();
            $data->user_id = $user->id;
            $data->job_subcategory_item_id = $skill;
            $data->deleted_at = null;
            $data->save();
        }
        

        return response()->json(['success' => 1, 'message' => 'Changes Saved!'],200);
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

        $new = new UserFile;
        $new->user_id = $user->id;
        $new->type = 'resume';
        $new->name = $name;
        $new->original_name = $original_name;
        $new->size = $size;
        $new->save();
        
        $path = 'resumes';
        $file->storeAs($path, $name,['disk' => 'public']);

        $resume = UserResume::where('user_id','=',$user->id)->first();
        $resume->file_resume_id = $new->id;
        $resume->save();

        return response()->json(['success' => 1, 'message' => 'Resume has been successfully uploaded', 'data' => $new, 'url' => asset('storage/'.$path.'/'.$name)],200);
    }


    public function uploadTickets(Request $request)
    {
        
        $file = $request->file('file');
        $ext = $file->extension();
        $original_name = $file->getClientOriginalName();
        $size = $file->getSize();

        /*
        if ($ext != '.pdf' && $ext != '.doc' && $ext != '.docx' && $ext != '.txt') {
            return response()->json(['success' => 0, 'message' => 'You have uploaded an invalid file '.$ext.', please use the following: .doc, .docx, .pdf, .txt'],500); 
        }
        */

        $user_id = request()->user_id;
        $user = User::find($user_id);

        $name = 'ticket-'.$user->id.'-'.time();
        $name = $name.'.'.$ext;

        $new = new UserFile;
        $new->user_id = $user->id;
        $new->type = 'ticket';
        $new->name = $name;
        $new->original_name = $original_name;
        $new->size = $size;
        $new->save();
        
        $path = 'tickets';
        $file->storeAs($path, $name,['disk' => 'public']);

        $resume = UserResume::where('user_id','=',$user->id)->first();
        $resume->file_tickets_id = $new->id;
        $resume->save();

        return response()->json(['success' => 1, 'message' => 'Tickets has been successfully uploaded', 'data' => $new, 'url' => asset('storage/'.$path.'/'.$name)],200);
    }

    public function deleteTicketsFile(Request $request){
        $user_id = request()->user_id;
        $auth = Auth::user();
        $user = User::find($user_id);

        if ($auth->type != 'Admin' && $auth->id != $user_id) {
            return response()->json(['success' => 0, 'message' => 'You don\'t have permission to perform this action '],500);
        }

        $skill = UserFile::where('id','=',$request->ticket_id)
            ->first();

        if ($skill) {
            $skill->delete();
        }

        return response()->json(['success' => 1, 'message' => 'Skill added', 'data' => $skill],200);
    }
}