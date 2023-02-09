<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\Mail; 
use App\Models\MailReceiver;
use App\Models\UserLog;

use Illuminate\Support\Facades\Auth; 

class UserCandidateController extends Controller
{
    public function getMessageHistory()
    {
        $candidate_id = request()->candidate_id;
        $type = request()->message_type;
        
        $rows = array();
        $messages = MailReceiver::where('user_id', '=', $candidate_id)->with('user')->with('mail')->get();
        foreach($messages as $message) {
            if($message->mail->is_email && $type === 'email') {
                $rows[] = $message;
            }
            if($message->mail->is_sms && $type === 'SMS') {
                $rows[] = $message;
            }
        }

        return response()->json(['success' => 1, 'rows' => $rows], 200);
    }
    
    public function sendCandidateMessage()
    {
        $is_sms = request()->is_sms;
        $is_email = request()->is_email;

        if($is_email)
        {
            $is_sms = false;
            $subject = request()->subject;
            $message = request()->message;

            // log this action
            $log = new UserLog();
            $log->user_id = request()->id;
            $log->type = 'email';
            $log->description = 'This is an automated log by system. Triggered on SEND EMAIL.';
            $log->logged_by = Auth::user()->id;
            $log->save();
        }
        else if($is_sms)
        {
            $is_email = false;
            $subject = "DIRECT MESSAGE:";
            $message = request()->message;

            // log this action
            $log = new UserLog();
            $log->user_id = request()->id;
            $log->type = 'sms';
            $log->description = 'This is an automated log by system. Triggered on SEND SMS.';
            $log->logged_by = Auth::user()->id;
            $log->save();
        }
        else
        {
            return response()->json(['success' => 0, 'message' => 'Something went wrong'], 500);
        }


        $recipient = request()->id;

        $mail = new Mail();
        $mail->subject = $subject;
        $mail->message = $message;
        $mail->is_email = $is_email;
        $mail->is_sms = $is_sms;
        $mail->status = 'pending';
        $mail->sent_from_message_center = false;
        $mail->save();

        $receiver = MailReceiver::where('mail_id','=',$mail->id)->where('user_id','=',$recipient)->first();
        $receiver = ($receiver) ? $receiver : new MailReceiver();
        $receiver->mail_id = $mail->id;
        $receiver->user_id = $recipient;
        $receiver->status = 'pending';
        $receiver->save();

        return response()->json(['success' => 1, 'data' => $mail]);
    }
}