<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserSkill extends Model
{
    use SoftDeletes;
    
    protected $table = 'user_skills';

    protected $fillable = [
        'user_id', 'job_subcategory_item_id'
    ];

    protected $casts = [
        'user_id' => 'integer',
        'job_subcategory_item_id' => 'integer',
    ];

    public function user()
    {
        return $this->belongsTo('App\Models\User');
    }

    public function JobSubcategoryItem()
    {
        return $this->belongsTo('App\Models\JobSubcategoryItem');
    }
}