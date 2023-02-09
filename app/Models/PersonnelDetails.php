<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PersonnelDetails extends Model
{
    use SoftDeletes;
    protected $table = 'personnel_details';

    protected $casts = [
        'required_personnel_id' => 'integer'
    ];

    public function PersonnelDetailsCompetencies() 
    {
        return $this->hasMany('App\Models\PersonnelDetailsCompetencies', 'personnel_detail_id');
    }

}
