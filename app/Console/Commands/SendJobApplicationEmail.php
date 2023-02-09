<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use App\Models\JobPostApplication;

use Mail;
use App\Mail\SendMail;

class SendJobApplicationEmail extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'mail:new-job-applications';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This command will send an email to the Primus teams regarding about the job applications';

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
        $applications = JobPostApplication::where('status','=','pending')->where('is_admin_notified','=',false)->with('job')->with('user')->get();
        $count = count($applications);

        if ($count < 1) {
            $this->info('Nothing to notify...');
            return;
        }

        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'New job applications',  'applications' => $applications, 'template' => 'new-job-applications'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));

        $applications = JobPostApplication::where('status','=','pending')->where('is_admin_notified','=',false)->update(['is_admin_notified' => true]);
        $this->info('Primus Team has been notified about '.$count.' new applications...');
    }
}
