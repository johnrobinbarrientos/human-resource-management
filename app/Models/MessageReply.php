<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MessageReply extends Model
{
    use SoftDeletes;
    
    protected $table = 'message_replies';

    protected $casts = [
        'message_id' => 'integer',
        'sender_id' => 'integer',
        'receiver_id' => 'integer',
    ];

    public function message()
    {
        return $this->belongsTo('App\'Models\Message','message_id');
    }

    public function sender()
    {
        return $this->belongsTo('App\Models\User','sender_id');
    }

    public function receiver()
    {
        return $this->belongsTo('App\Models\User','receiver_id');
    }
}
