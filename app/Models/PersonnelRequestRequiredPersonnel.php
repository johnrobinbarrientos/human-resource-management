<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PersonnelRequestRequiredPersonnel extends Model
{
    use SoftDeletes;
    
    protected $table = 'personnel_request_required_personnels';

    protected $casts = [
        'personnel_request_id' => 'integer'
    ];

    public function requiredTicket()
    {
        return $this->hasOne('App\Models\PersonnelRequiredTicket', 'required_personnel_id');
    }

    public function drugAndAlcoholTest()
    {
        return $this->hasOne('App\Models\PersonnelDrugAndAlcoholTest', 'required_personnel_id');
    }

    public function operatorRequirement()
    {
        return $this->hasOne('App\Models\PersonnelOperatorRequirement', 'required_personnel_id');
    }
    
    public function PersonnelDetails()
    {
        return $this->hasMany('App\Models\PersonnelDetails', 'required_personnel_id');
    }
}