<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobSubcategory extends Model
{
    use SoftDeletes;
    
    protected $table = 'job_subcategories';

    protected $casts = [
        'job_category_id' => 'integer',
    ];

    protected $fillable = [
        'category_id','name'
    ];

    public function jobCategory()
    {
        return $this->belongsTo('App\Models\JobCategory');
    }
}