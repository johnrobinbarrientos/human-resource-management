<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobPost extends Model
{
    use SoftDeletes;
    
    protected $table = 'job_posts';

    protected $casts = [
        'user_id' => 'integer',
        'is_public' => 'boolean',
    ];


    public function company()
    {
        return $this->belongsTo('App\Models\Company','company_id');
    }

    public function personnel_request()
    {
        return $this->belongsTo('App\Models\PersonnelRequest','personnel_request_id');
    }
}