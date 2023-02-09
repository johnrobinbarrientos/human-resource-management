<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Message extends Model
{
    use SoftDeletes;
    
    protected $table = 'messages';

    protected $casts = [
        'sender_id' => 'integer',
        'receiver_id' => 'integer',
    ];

    public function messageReplies() 
    {
        return $this->hasMany('App\Models\MessageReply')->orderByDesc('created_at')->take(1);
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
