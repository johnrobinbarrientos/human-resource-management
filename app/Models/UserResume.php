<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserResume extends Model
{
    use SoftDeletes;
    
    protected $table = 'user_resumes';

    protected $casts = [
        'user_id' => 'integer',
        'file_avatar_id' => 'integer',
        'file_resume_id' => 'integer',
        'file_tickets_id' => 'integer',
    ];
}