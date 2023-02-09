<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserProfileExport extends Model
{
    use SoftDeletes;
    
    protected $table = 'user_profile_exports';

    protected $casts = [
        'user_id' => 'integer',
    ];

    public function UserProfileExportItem()
    {
        return $this->hasMany('App\Models\UserProfileExportItem');
    }

}