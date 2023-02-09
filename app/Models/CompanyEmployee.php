<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CompanyEmployee extends Model
{
    use SoftDeletes;
    
    protected $table = 'company_employees';

    protected $fillable = [
        'name'
    ];

    public function user()
    {
        return $this->belongsTo('App\Models\User','user_id');
    }


    public function company()
    {
        return $this->belongsTo('App\Models\Company','company_id');
    }

    public function job()
    {
        return $this->belongsTo('App\Models\JobPost','job_post_id')->with('personnel_request');
    }

    
}