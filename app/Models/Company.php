<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Company extends Model
{
    use SoftDeletes;
    
    protected $table = 'companies';


    public function users()
    {
        return $this->hasMany('App\Models\User');
    }

    public function employees()
    {
        return $this->hasMany('App\Models\CompanyEmployee');
    }
}