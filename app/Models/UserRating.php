<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserRating extends Model
{
    use SoftDeletes;
    
    protected $table = 'user_ratings';

    protected $casts = [
        'user_id' => 'integer',
        'job_post_id' => 'integer',
        'job_competency' => 'integer',
        'health_safety_performance' => 'integer',
        'work_ethic' => 'integer',
    ];

    public function user()
    {
        return $this->belongsTo('App\Models\User');
    }
    
    public function reviewer()
    {
        return $this->belongsTo('App\Models\User','reviewer_id');
    }
}