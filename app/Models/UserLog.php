<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserLog extends Model
{
    use SoftDeletes;
    
    protected $table = 'user_logs';

    protected $casts = [
        'user_id' => 'integer',
        'logged_by' => 'integer',
    ];

    public function user()
    {
        return $this->belongsTo('App\Models\User', 'logged_by');
    }
}