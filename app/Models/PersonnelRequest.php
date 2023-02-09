<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PersonnelRequest extends Model
{
    use SoftDeletes;
    
    protected $table = 'personnel_requests';

    protected $casts = [
        'company_id' => 'integer'
    ];

    public function company()
    {
        return $this->belongsTo('App\Models\Company');
    }

    public function requiredPersonnel()
    {
        return $this->hasMany('App\Models\PersonnelRequestRequiredPersonnel');
    }

    public function jobs()
    {
        return $this->hasMany('App\Models\JobPost');
    }
}
