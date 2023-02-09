<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\MailReceiver; 

use Mail;
use App\Mail\SendMail;
use Twilio\Rest\Client;

use App\Models\User;
use App\Models\UserRetrieval;

class SendForgotPasswordMailCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'mail:send-forgot-password';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This command will send forgot password email to the users';

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

        $retrievals = UserRetrieval::where('status','=','pending')->get();

        foreach ($retrievals as $retrieval) {
            
            $user = User::find($retrieval->user_id);

            if (!$user) { continue; }

            $this->info('Sending email to '.$user->email);

            $retrieval->status = 'sending';
            $retrieval->save();

            $token = $retrieval->token;
            $url = getenv("APP_URL").'/forgot-password?token='.$token;

            $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Primus Workforce Password Reset', 'user' => $user, 'url' => $url, 'template' => 'forgot-password'];
            Mail::to($user->email)->queue(new SendMail($data));


            $retrieval->status = 'sent';
            $retrieval->save();
            
        }
    }
}
