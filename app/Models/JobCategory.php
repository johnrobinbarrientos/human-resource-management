<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobCategory extends Model
{
    use SoftDeletes;
    
    protected $table = 'job_categories';

    protected $fillable = [
        'name'
    ];
}