<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MessageLog extends Model
{
    use SoftDeletes;
    
    protected $table = 'message_logs';

    protected $casts = [
        'sender_id' => 'integer',
        'receiver_id' => 'integer',
    ];

    public function sender()
    {
        return $this->belongsTo('App\Models\User','sender_id');
    }

    public function receiver()
    {
        return $this->belongsTo('App\Models\User','receiver_id');
    }
}
