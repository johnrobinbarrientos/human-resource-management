<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PersonnelRequiredTicket extends Model
{
    use SoftDeletes;
    
    protected $table = 'personnel_required_tickets';

    protected $casts = [
        'required_personnel_id' => 'integer'
    ];

}