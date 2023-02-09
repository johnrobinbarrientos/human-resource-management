<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobWorkerRecommendation extends Model
{
    use SoftDeletes;
    
    protected $table = 'job_worker_recommendations';

    protected $casts = [
        'job_post_id' => 'integer',
        'user_id' => 'integer',
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