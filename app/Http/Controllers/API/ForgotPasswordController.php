<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use Illuminate\Support\Str;

use Illuminate\Support\Facades\Auth; 

use App\Models\User;
use App\Models\UserRetrieval;

use App\Jobs\QueueForgotPasswordEmail;


class ForgotPasswordController extends Controller
{
    public function retrieve()
    {
        $email = request()->email;
        $user = User::where('email','=',$email)->first();

        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'Could not find the account...' ],500);
        }

        $retrieval = UserRetrieval::where('user_id','=',$user->id)->first();

        $retrieval = ($retrieval) ? $retrieval : new UserRetrieval;
        $retrieval->user_id = $user->id;
        $retrieval->token = 'RTRV-'.Str::uuid();
        $retrieval->status = 'pending';
        $retrieval->save();


        // send email via queue
        QueueForgotPasswordEmail::dispatch($retrieval);
        
        return response()->json(['success' => 1, 'message' => 'Account Retrieval success, Please check your email inbox to continue the retrieval process..' ],200);
    }


    public function complete()
    {
        $token = request()->token;
        $password = request()->password;
        $password2 = request()->password2;
        
        if (empty($token)) {
            return response()->json(['success' => 0, 'message' => 'Unable to reset, the link must have been expired or invalid...'],500); 
        }

        if (strlen($password) < 8) {
            return response()->json(['success' => 0, 'message' => 'The password must be at least 8 characeters long'],500); 
        }

        if ($password != $password2) {
            return response()->json(['success' => 0, 'message' => 'Password not matched!'],500); 
        }


        $retrieval = UserRetrieval::where('token','=',$token)->where(function($query){
            $query->where('status','!=','expired')
                ->where('status','!=','invalid');
        })->first();

        if (!$retrieval) {
            return response()->json(['success' => 0, 'message' => 'Unable to reset, the link must have been expired or invalid...' ],500);
        }

        $user = User::find($retrieval->user_id);
        
        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'Unable to reset, the link must have been expired or invalid...' ],500);
        }

        $user->password = \Hash::make($password);
        $user->save();

        $retrieval->status = 'expired'; // mark as expired to prevent re-using it...
        $retrieval->save();
        
        return response()->json(['success' => 1, 'message' => 'Account Retrieval success, you may now login to your account..' ],200);
    }
}