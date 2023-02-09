<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserRetrieval extends Model
{
    use SoftDeletes;
    
    protected $table = 'user_retrievals';

    protected $casts = [
        'user_id' => 'integer',
    ];
}