<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobSubcategoryItem extends Model
{
    use SoftDeletes;
    
    protected $table = 'job_subcategory_items';
    
    protected $casts = [
        'job_subcategory_id' => 'integer',
        'job_type_id' => 'integer',
    ];

    protected $fillable = [
        'job_subcategory_id', 'job_type_id'
    ];


    public function jobType()
    {
        return $this->belongsTo('App\Models\JobType');
    }
}