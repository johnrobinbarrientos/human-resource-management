<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class UserProfileExportItem extends Model
{
    use SoftDeletes;
    
    protected $table = 'user_profile_export_items';

    protected $casts = [
        'user_id' => 'integer',
    ];

    public function UserProfileExport()
    {
        return $this->belongsTo('App\Models\UserProfileExport');
    }

    public function User()
    {
        return $this->belongsTo('App\Models\User');
    }


}