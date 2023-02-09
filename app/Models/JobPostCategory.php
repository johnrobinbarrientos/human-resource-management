<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobPostCategory extends Model
{
    use SoftDeletes;
    
    protected $table = 'job_post_categories';

    protected $casts = [
        'job_post_id' => 'integer',
        'job_category_id' => 'integer',
    ];


    public function job()
    {
        return $this->belongsTo('App\Models\JobPost');
    }

    public function category()
    {
        return $this->belongsTo('App\Models\JobCategory');
    }
}