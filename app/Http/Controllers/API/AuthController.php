<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\UserFile;
use App\Models\Company;
use App\Models\CompanyList;

use App\Mail\SendMail;

use Illuminate\Support\Facades\Auth; 

class AuthController extends Controller
{

    public function check()
    {
        $user = Auth::user();
        $user->company = Company::find($user->company_id);

        $avatar = UserFile::find($user->file_avatar_id);
        $avatar = ($avatar) ? asset('storage/avatars/'.$avatar->name) : null;

        $user->avatar = $avatar;

        return response()->json(['success' => 1, 'user' => $user, 'authenticated' => true], 200);
    }

    public function revoke()
    {
        $user = Auth::user();
        $user->token()->revoke(); 
        return response()->json(['success' => 1, 'authenticated' => true], 200);
    }

    public function confirmation()
    {
        $token = request()->token;

        if ($token == '' || $token == 'INVALID' || $token == 'COMPLETED') {
            return response()->json(['success' => 0, 'message' => 'The token is invalid or already been used...'], 500);
        }

        $password = request()->password;
        $password2 = request()->password2;

        if (strlen($password) < 8) {
            return response()->json(['success' => 0, 'message' => 'Your password must be at least 8 characters long..'], 500);
        }

        if ($password != $password2) {
            return response()->json(['success' => 0, 'message' => 'Password not matched..'], 500);
        }


        $user = User::where('confirmation_token','=',$token)->first();

        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'The token is invalid or already been used...'], 500);
        }

        $user->password = \Hash::make($password);
        $user->confirmation_token = 'COMPLETED';
        $user->is_verified = true;
        $user->save();

        $user->company = Company::find($user->company_id);
        
        $token = $user->createToken('authToken')->accessToken;

        return response()->json(['success' => 1, 'token' => $token, 'user' => $user, 'message' => 'Authenticated!'], 200); 
    }


    public function register()
    {
        $email = request()->email;
        $password = request()->password;
        $password2 = request()->password2; 
        $first_name = ucwords(request()->first_name);
        $last_name = ucwords(request()->last_name);

        $type = request()->type;
        $type = ($type != 'Candidate') ? 'Employer' :  'Candidate';

        // if user type is employer
        $company_name = ucwords(request()->company_name);
        $company_email = request()->company_email;
        $company_address = request()->company_address;

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return response()->json(['success' => 0, 'message' => $email.' is an invalid email address'],500);
        }

        if (strlen($first_name) < 1) {
            return response()->json(['success' => 0, 'message' => 'Please enter your first name'],500);
        }

        if (strlen($last_name) < 1) {
            return response()->json(['success' => 0, 'message' => 'Please enter your last name'],500);
        }

        if ($password != $password2) {
            return response()->json(['success' => 0, 'message' => 'Password not matched'],500);
        }

        if (strlen($password) < 8) {
            return response()->json(['success' => 0, 'message' => 'The password must be at least 8 characeters long'],500);
        }

        $exists = User::where('email','=',$email)->first();
        if ($exists) {
            return response()->json(['success' => 0, 'message' => 'The email address has already been taken'],500);
        }
        
        if ($type === 'Employer' && empty($company_name)) {
            return response()->json(['success' => 0, 'message' => 'Please enter company name'], 500);
        }


        if ($type == 'Employer') {
            // only employer can create new company
            $company = new Company;
            $company->name = $company_name;
            $company->email = $email;
            $company->save();
        }


        $user = new User;
        $user->company_id = ($type === 'Employer' ? $company->id : null);
        $user->is_company_admin = ($type === 'Employer' ? true : false);
        $user->email = $email;
        $user->password = \Hash::make(request()->password);
        $user->first_name = $first_name;
        $user->last_name = $last_name;
        $user->type = $type;
        $user->confirmation_code = 'vrfy-'.\Uuid::generate(4);
        $user->save();


        $user = User::find($user->id);

        // send verification code email
        $confirmation_code = $user->confirmation_code;
        $url = getenv("APP_URL").'/verify/'.$confirmation_code;
        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Please Confirm Your Email - Action Required',  'user' => $user, 'url' => $url, 'template' => 'confirmation'];
        \Mail::to($user->email)->queue(new SendMail($data));
        $user->verification_status = 'sent';
        $user->save();

        $user->company = Company::find($user->company_id);

        $avatar = UserFile::find($user->file_avatar_id);
        $avatar = ($avatar) ? asset('storage/avatars/'.$avatar->name) : null;

        $user->avatar = $avatar;

        $accessToken = $user->createToken('authToken')->accessToken;

        return response(['success' => 1, 'user' => $user, 'token' => $accessToken, 'message' => 'You have successfully created an account...']);
    }

    public function login(Request $request)
    {
        $loginData = $request->validate([
            'email' => 'email|required',
            'password' => 'required'
        ]);

        try
        {
            if(Auth::attempt($loginData)) { 
                $user = Auth::user(); 

                if (!$user->is_verified) {
                    return response()->json(['success' => 0, 'message' => 'Please verify your account'], 401); 
                }

                $user->company = Company::find($user->company_id);

                $avatar = UserFile::find($user->file_avatar_id);
                $avatar = ($avatar) ? asset('storage/avatars/'.$avatar->name) : null;

                $user->avatar = $avatar;

                $token =  $user->createToken('authToken')->accessToken; 
                return response()->json(['success' => 1, 'token' => $token, 'user' => $user, 'message' => 'Authenticated!'], 200); 
            } else { 
                return response()->json(['success' => 0, 'message' => 'Invalid email and password!'], 401); 
            } 
        } catch (Exception $e) {
            return response()->json(['success' => 0, 'message' => 'Invalid email and password!'], 401);
        }
    }

    public function verifyToken($token)
    {
        $user = User::where('confirmation_code','=',$token)->where('is_verified','=',false)->first();

        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'Invalid email and password!','reason' => 'Invalid Token'], 401); 
        }

        $user->is_verified = true;
        $user->verification_status = 'verified';
        $user->save();

        $user->company = Company::find($user->company_id);
        $accessToken = $user->createToken('authToken')->accessToken;
        return response(['success' => 1, 'user' => $user, 'token' => $accessToken, 'message' => 'You have successfully created an account...']);
    }

    public function changeEmailVerifyToken($token)
    {
        $user = User::where('confirmation_code','=',$token)->where('new_email','!=','')->first();

        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'Couldn\'t verify, its either the code is expired or does not exist at all', 'reason' => 'Invalid Token'], 401); 
        }

        $new_email = $user->new_email;

        $exists = User::where('email','=',$new_email)->first();

        if ($exists) {
            return response()->json(['success' => 0, 'message' => 'The email has already been taken', 'reason' => 'Email Taken'], 401); 
        }

        $user->email = $new_email;
        $user->new_email = '';
        $user->save();

        $user->company = Company::find($user->company_id);
        $accessToken = $user->createToken('authToken')->accessToken;
        return response(['success' => 1, 'user' => $user, 'token' => $accessToken, 'message' => 'You have successfully created an account...']);
    }
}