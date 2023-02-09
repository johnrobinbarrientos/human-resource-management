<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Mail;
use App\Mail\SendMail;
use Twilio\Rest\Client;

use App\Mail\TestEmail;

class TestController extends Controller
{
    public function auth()
    {

        $token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFjZWNvbW1lcmNpYWwuZHVtbXlAZ21haWwuY29tIiwiZW1haWwiOiJhY2Vjb21tZXJjaWFsLmR1bW15QGdtYWlsLmNvbSIsImV4cCI6MTYwNzk5ODM1NCwidXNlcl9pZCI6NTA4NTJ9.igz_mKvxlzluFT9Si_YSuoZehzR-9HzrTfGnRWqAAEM';
        $url = 'https://api.ivr-platform.com/api/callerids';
        $headers = [
        'Authorization: JWT '.$token,
        'Accept: application/json',
        'Content-Type: application/json',
        ];

        $payload = [
            'account' => 'ace-dummy',
            'phone' => '2345555555',
            'notes' => 'Test caller id',
        ];

        $ch = curl_init();

        curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_HTTPHEADER => $headers,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POSTFIELDS => json_encode($payload),
        ]);

        $result = curl_exec($ch);
        echo print_r($result,true);
        return;

        $email = md5('acecommercial.dummy@gmail.com');
        $password = md5('acecommercial');

        $ch = curl_init();

        curl_setopt_array($ch, [
            CURLOPT_URL => 'https://api.ivr-platform.com/api/token-auth',
            CURLOPT_POST => 1,
            CURLOPT_POSTFIELDS => ['email' => $email, 'password' => $password],
            CURLOPT_RETURNTRANSFER => true,
        ]);

        $result = curl_exec($ch);

        echo print_r($result,true);
    }
    
    public function mail()
    {
        $data = ['message' => 'Hi HELOW GOOD BYE AA'];
        Mail::to('kenjimagto@gmail.com')->send(new TestEmail($data));
        return 'Sent!';
    }

    public function mailConfirmation()
    {
       $view = view('emails.confirmation');

       return $view;
    }

    public function aaa()
    {

        $account_sid = getenv("TWILIO_SID");
        $auth_token = getenv("TWILIO_AUTH_TOKEN");
        $twilio_number = getenv("TWILIO_NUMBER");

        // Where to make a voice call (your cell phone?)
        $to_number = "+639155890949";

        $client = new Client($account_sid, $auth_token);
        $client->account->calls->create(  
            $to_number,
            $twilio_number,
            [
                "twiml" => " <Response>
                    <Say>Calling Kenji, Please wait</Say>
                    <Dial>+639177012719</Dial>
                </Response>",
            ]
        );
    }
}