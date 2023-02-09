<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobPostApplication extends Model
{
    use SoftDeletes;
    
    protected $table = 'job_post_applications';

    protected $casts = [
        'user_id' => 'integer',
        'job_post_id' => 'integer',
    ];

    public function job()
    {
        return $this->belongsTo('App\Models\JobPost','job_post_id');
    }



    public function user()
    {
        return $this->belongsTo('App\Models\User');
    }
}