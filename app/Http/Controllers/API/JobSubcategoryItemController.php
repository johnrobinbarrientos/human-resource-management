<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;

use App\Models\JobSubcategoryItem; 

use Illuminate\Support\Facades\Auth; 

class JobSubcategoryItemController extends Controller
{
    public function index()
    {

        $subcat_item = JobSubcategoryItem::with('jobType')
        ->get();

        return response()->json(['success' => 1, 'rows' => $subcat_item], 200);
    }


    

}