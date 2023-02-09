<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserTicket extends Model
{
    use SoftDeletes;
    
    protected $table = 'user_tickets';

    protected $casts = [
        'user_id' => 'integer',
    ];
}