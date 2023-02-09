<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PersonnelOperatorRequirement extends Model
{
    use SoftDeletes;
    
    protected $table = 'personnel_operator_requirements';

    protected $casts = [
        'personnel_required_id' => 'integer'
    ];

}