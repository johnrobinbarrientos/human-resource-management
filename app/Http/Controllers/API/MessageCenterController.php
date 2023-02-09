<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\Mail; 
use App\Models\MailReceiver; 

use App\Jobs\QueueMessageCenterEmail;


class MessageCenterController extends Controller
{
    public function index()
    {
        $mails = Mail::where('sent_from_message_center','=', true)->get();

        foreach ($mails as $mail) {
            $mail->recipients =  MailReceiver::where('mail_id','=',$mail->id)->with('user')->get();
            
            $message = strip_tags($mail->message);

            unset($mail->message);
            $mail->message = $message;
        }

        return response()->json(['success' => 1, 'rows' => $mails]);
    }


    public function store()
    {
        $subject = request()->subject;
        $message = request()->message;

        $recipients = request()->recipients;
        $recipients = (is_array($recipients)) ? $recipients : [];

        $is_email = request()->is_email;
        $is_email = ($is_email == 'yes') ? true : false;

        $is_sms = request()->is_sms;
        $is_sms = ($is_sms == 'yes') ? true : false;

        $mail = new Mail();
        $mail->subject = $subject;
        $mail->message = $message;
        $mail->is_email = $is_email;
        $mail->is_sms = $is_sms;
        $mail->status = 'pending';
        $mail->sent_from_message_center = true;
        $mail->save();

        foreach ($recipients as $recipient)
        {
            $receiver = MailReceiver::where('mail_id','=',$mail->id)->where('user_id','=',$recipient)->first();
            $receiver = ($receiver) ? $receiver : new MailReceiver();
            $receiver->mail_id = $mail->id;
            $receiver->user_id = $recipient;
            $receiver->status = 'pending';
            $receiver->save();
        }

        $delete = MailReceiver::whereNotIn('user_id',$recipients)->delete();

        

        // send email to all receipients
        $mail = Mail::find($mail->id);
        QueueMessageCenterEmail::dispatch($mail);

        return response()->json(['success' => 1, 'data' => $mail]);
    }

    public function update($mail_id)
    {
        $subject = request()->subject;
        $message = request()->message;

        $recipients = request()->recipients;
        $recipients = (is_array($recipients)) ? $recipients : [];

        $is_email = request()->is_email;
        $is_email = ($is_email === 1 || $is_email === true || $is_email === 'yes') ? true : false;

        $is_sms = request()->is_sms;
        $is_sms = ($is_sms === 1 || $is_sms === true || $is_sms === 'yes') ? true : false;

        $mail = Mail::find($mail_id);
        
        if (!$mail) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'],500);
        }

        $mail->subject = $subject;
        $mail->message = $message;
        $mail->is_email = $is_email;
        $mail->is_sms = $is_sms;
        $mail->status = 'pending';
        $mail->save();

        foreach ($recipients as $recipient)
        {
            $receiver = MailReceiver::where('mail_id','=',$mail->id)->where('user_id','=',$recipient)->withTrashed()->first();
            $receiver = ($receiver) ? $receiver : new MailReceiver();
            $receiver->mail_id = $mail->id;
            $receiver->user_id = $recipient;
            $receiver->status = 'pending';
            $receiver->deleted_at = null;
            $receiver->save();
        }

        $delete = MailReceiver::whereNotIn('user_id',$recipients)->delete();


        return response()->json(['success' => 1, 'data' => $mail]);
    }

    public function delete($mail_id)
    {

        $mail = Mail::find($mail_id);
        
        if (!$mail) {
            return response()->json(['success' => 0, 'message' => 'An error occur while processing...'],500);
        }


        $mail->delete();

        return response()->json(['success' => 1, 'data' => $mail, 'message' => 'Successfully deleted!']);
    }
    
}