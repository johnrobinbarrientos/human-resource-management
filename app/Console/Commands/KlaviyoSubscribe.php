<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

use App\Models\User;

use Curl\Curl;
use Klaviyo\Klaviyo as Klaviyo;
use Klaviyo\Model\ProfileModel as KlaviyoProfile;

class KlaviyoSubscribe extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'klaviyo:subscribe';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This command will subscribe all the users to klaviyo';

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
        // dd($client->lists->getLists());
        $payload = [];
        $client = new Klaviyo(env('KLAVIYO_PRIVATE_KEY'),env('KLAVIYO_PUBLIC_KEY'));

        $users = User::where('klaviyo_status','=','pending')->get();

        foreach ($users as $user) {
            $profile = ['$email' => $user->email, '$first_name' => $user->first_name, '$last_name' => $user->last_name];
            $payload[] =  new KlaviyoProfile($profile);
        }
        
        if ($users->count() > 0) {
            $client->lists->addMembersToList( 'Wp6Mup', $payload);
            
        
            foreach ($users as $user) {
                $user->klaviyo_status = 'subscribed';
                $user->save();
            }
        }

        /* SEND EMAIL VIA KLAVIYO*/
        $curl = new Curl();
        $curl->post('https://a.klaviyo.com/api/v1/email-template/Rida4Y/send', array(
            'api_key' => env('KLAVIYO_PRIVATE_KEY'),
            'from_email' => 'dev@thinkorion.com',
            'from_name' => 'Kenji',
            'subject' => 'Job Recommendation',
            'to' => '[{ "email" : "kenjimagto@thinkorion.com", "first_name" : "Kenji" }]',
        ));

        var_dump($curl->response);
        
    }
}
