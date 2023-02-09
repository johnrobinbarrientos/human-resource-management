<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MailReceiver extends Model
{
    use SoftDeletes;
    
    protected $table = 'mail_receivers';

    public function user()
    {
        return $this->belongsTo('App\Models\User');
    }

    public function mail()
    {
        return $this->belongsTo('App\Models\Mail');
    }

}