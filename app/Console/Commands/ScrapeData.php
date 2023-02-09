<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;


use App\Models\User;
use App\Models\UserResume;

class ScrapeData extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'scrape:data';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Use this command to scrape data. example: transfer field value from one table to another';

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
        $resumes = UserResume::all();

        foreach ($resumes as $resume) {
            $user = User::find($resume->user_id);

            if (!$user) {
                continue;
            }

            $user->content = $resume->content;
            $user->save();
        }

        $this->info('All "content" data has been migrated to "users" table ');
    }
}
