<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller; 

use Auth;
use Mail;
use Log;
use App\Mail\SendMail;
use Twilio\Rest\Client;

use App\Models\User;

class TwilioController extends Controller
{
    public function call($user_id)
    {
        $account_sid = getenv("TWILIO_SID");
        $auth_token = getenv("TWILIO_AUTH_TOKEN");
        $twilio_number = getenv("TWILIO_NUMBER");


        $auth = Auth::user();
        $user = User::find($user_id);

        // admin's phone number
        $to_number = $auth->phone;
        $user_number = $user->phone;

        if (empty($to_number)) {
            return response()->json(['success' => 0, 'message' => 'You must setup your phone number first..'], 500);
        }


        if (empty($user_number)) {
            return response()->json(['success' => 0, 'message' => $user->first_name.' does not have phone number yet...'], 500);
        }

        $client = new Client($account_sid, $auth_token);
        $client->account->calls->create(  
            $to_number,
            $twilio_number,
            [
                "statusCallback" => "https:/dashboard.primusworkforce.com/api/twilio/events",
                "statusCallbackMethod" => "POST",
                "twiml" => "<Response><Say>Calling ".$user->first_name.", Please wait</Say>
                    <Dial>".$user_number."</Dial>
                </Response>",
            ]
        );


        return response()->json(['success' => 1, 'message' => 'Calling '.$user->first_name], 200);
    }

    public function events()
    {
        Log::debug(print_r(request()->all(),true));
        return 'aaa';
    }
}