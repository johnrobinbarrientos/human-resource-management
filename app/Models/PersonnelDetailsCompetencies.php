<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PersonnelDetailsCompetencies extends Model
{
    use SoftDeletes;
    protected $table = 'personnel_details_competencies';



}
