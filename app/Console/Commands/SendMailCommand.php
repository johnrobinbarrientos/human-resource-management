<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

use Mail;
use App\Mail\SendMail;
use Twilio\Rest\Client;

use App\Models\MailReceiver; 

class SendMailCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'mail:send';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This command will send both SMS and email to the inteded users';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {

        $account_sid = getenv("TWILIO_SID");
        $auth_token = getenv("TWILIO_AUTH_TOKEN");
        $twilio_number = getenv("TWILIO_NUMBER");
        $client = new Client($account_sid, $auth_token);
        
        $mails = \App\Models\Mail::where('status','=','pending')->get();

        foreach ($mails as $mail) {
            
            $this->info('Sending '.$mail->subject);

            $mail->status = 'sending';
            $mail->save();

            $receivers = MailReceiver::where('mail_id','=',$mail->id)->where('status','=','pending')->with('user')->get();

            foreach ($receivers as $receiver) {

                $receiver->status = 'sending';
                $receiver->save();

                if ($mail->is_email) {
                    $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => $mail->subject, 'message' => $mail->message, 'user' => $receiver->user, 'template' => $mail->template];
                    Mail::to($receiver->user->email)->queue(new SendMail($data));
            

                    if ($receiver->user->is_company_admin) {
                        $company = \App\Models\Company::find($receiver->user->company_id);
                        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => $mail->subject, 'message' => $mail->message, 'user' => $receiver->user, 'template' => $mail->template];
                        Mail::to($company->email)->queue(new SendMail($data));
                    }
                }

                
                if ($mail->is_sms) {
                    $this->info('Sending SMS..');
                    try {
                        $recipients =  '+63'.$receiver->user->phone;
                        $message = $mail->message;
                        $closing = ['</p>','</h1>','</h2>','</h3>','</h4>','</h5>','</h6>'];
                        $message = str_replace($closing, "\n\n" , $message);
                        $message = strip_tags($message);
  
                        
                        $this->info('Sending '.$message);
                        $this->info('NUMBER '.$recipients);
                        $client->messages->create($recipients, ['from' => $twilio_number, 'body' => "{$message}"]);
                    } catch(\Throwable  $e) {
                        // just skip the undelivered SMS message due to service error, invalid number so we can proceed with sending on the next recipients
                        $this->info('Sending '.$e->getMessage());
                    }
                    
                }
                

                $receiver->status = 'delivered';
                $receiver->save();
            }

            $mail->status = 'sent';
            $mail->save();
            
        }
    }
}
