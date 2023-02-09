<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;

use Mail;
use App\Mail\SendMail;

class SendVerificationCodeEmail extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'mail:verification';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This command will send a verification code to the email';

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
        $users = User::where('verification_status','=','pending')->get();

        foreach ($users as $user) {
            $confirmation_code = $user->confirmation_code;


            $url = getenv("APP_URL").'/verify/'.$confirmation_code;
            $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Please Confirm Your Email - Action Required',  'user' => $user, 'url' => $url, 'template' => 'confirmation'];
            Mail::to($user->email)->queue(new SendMail($data));
            $user->verification_status = 'sent';
            $user->save();
        }
    }
}
