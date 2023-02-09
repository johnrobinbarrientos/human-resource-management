<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendMail extends Mailable
{
    use Queueable, SerializesModels;

    public $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function build()
    {
        $data = $this->data;
        
        $address = getenv("APP_EMAIL");

        $subject = $data['subject'];
        //$name = $data['user']['first_name'];

        $template = $data['template'];
    
        return $this->view('emails.'.$template)
                    ->from($address, 'Primus Workforce')
                    ->replyTo($address,'Primus Workforce')
                    ->subject($subject)
                    ->with($data);
    }
}
