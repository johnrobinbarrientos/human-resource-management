<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

use Mail;
use App\Mail\ConfirmationEmail;

class SendEmail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private $template = '';
    private $data = '';
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($template,$data = null)
    {
        $this->template = $template;
        $this->data = $data;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $template = $this->template;
        $data = $this->data;

        Mail::to($data['to'])->send(new ConfirmationEmail($data['data']));
        return 'Sent!';
        
    }
}
