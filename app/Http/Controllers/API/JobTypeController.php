<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\JobCategory; 
use App\Models\JobSubcategory; 
use App\Models\JobType; 

use Illuminate\Support\Facades\Auth; 

class JobTypeController extends Controller
{
    public function index()
    {
        $keyword = request()->keyword;

        $types = JobType::where('id','>',0)->orderBy('name');
    
        if (!empty($keyword)) {
            $types = $types->where('name','like','%'.$keyword.'%');
        }

        /* pagination start */
        $count = $types->count();
        $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
        $page = (is_numeric(request()->page)) ? request()->page : 1;
        $offset = (($page - 1 ) * $take);
        
        $types = $types->take($take);
        $types = $types->offset($offset);
        $types = $types->get();
        /* pagination end */

        return response()->json(['success' => 1, 'rows' => $types, 'count' => $count] ,200);
    }

    public static function store() {

        $name = request()->name;

        if (empty($name)) {
            return response()->json(['success' => 0, 'message' => 'Please enter a job type name'],500);
        }

        $exist = JobType::where('name','=',$name)->first();

        if ($exist) {
            return response()->json(['success' => 0, 'message' => 'Job type has already been added!'],500);
        }

        $job_type = new JobType;
        $job_type->name = $name;
        $job_type->save();

        $job_type = JobType::find($job_type->id);

        return response()->json(['success' => 1, 'data' => $job_type, 'message' => 'Job Type has been successfully added!'],200);
    }

    public static function update()
    {
        // ensures if the type id exist
        $type = JobType::find(request()->id);
        if (!$type) {
            return response()->json(['success' => 0, 'message' => 'Could not find Job Type!'], 200);
        }

        $type->name = request()->name;
        $type->push();

        return response()->json(['success' => 1, 'row' => $type], 200);
    }

    public static function delete() {
        // ensures if the type id exist
        $type = JobType::find(request()->id);
        if (!$type) {
            return response()->json(['success' => 0, 'message' => 'Could not find Job Type!'], 200);
        }

        $type->delete();
        return response()->json(['success' => 1, 'row' => $type], 200);
    }

}