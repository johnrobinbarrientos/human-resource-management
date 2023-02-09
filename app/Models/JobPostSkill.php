<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobPostSkill extends Model
{
    use SoftDeletes;
    
    protected $table = 'job_post_skills';

    protected $casts = [
        'job_post_id' => 'integer',
        'job_subcategory_item_id' => 'integer',
    ];

    public function job()
    {
        return $this->belongsTo('App\Models\JobPost');
    }
}