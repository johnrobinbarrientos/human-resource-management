<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ActivityLog extends Model
{
    use SoftDeletes;
    
    protected $table = 'activity_logs';

    protected $casts = [
        'sender_id' => 'integer',
        'receiver_id' => 'integer',
    ];

    public function user()
    {
        return $this->belongsTo('App\Models\User','user_id');
    }
}
