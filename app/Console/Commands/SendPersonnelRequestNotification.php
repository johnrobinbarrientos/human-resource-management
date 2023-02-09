<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use App\Models\PersonnelRequest;

use Mail;
use App\Mail\SendMail;

class SendPersonnelRequestNotification extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'mail:new-personnel-requests';

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
        $personnel_requests = PersonnelRequest::where('status','=','open')->where('is_admin_notified','=',false)->with('company')->get();
        $count = count($personnel_requests);

        if ($count < 1) {
            $this->info('Nothing to notify...');
            return;
        }

        $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'New Personnel Request Submitted',  'requests' => $personnel_requests, 'template' => 'new-personnel-requests'];
        Mail::to(getenv("APP_EMAIL"))->queue(new SendMail($data));

        $applications = PersonnelRequest::where('is_admin_notified','=',false)->update(['is_admin_notified' => true]);
        $this->info('Primus Team has been notified about '.$count.' new personnel requests...');
    }
}
