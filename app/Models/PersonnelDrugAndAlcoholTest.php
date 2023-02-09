<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PersonnelDrugAndAlcoholTest extends Model
{
    use SoftDeletes;
    
    protected $table = 'personnel_drug_and_alcohol_tests';

    protected $casts = [
        'required_personnel_id' => 'integer'
    ];
}