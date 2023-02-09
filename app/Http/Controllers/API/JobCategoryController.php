<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\JobCategory; 

use Illuminate\Support\Facades\Auth; 

class JobCategoryController extends Controller
{
    public function index()
    {
        $keyword = request()->keyword;

        if (!empty($keyword)) {
            $categories = JobCategory::where('name','like','%'.$keyword.'%')->get();
        } else {
            $categories = JobCategory::all();
        }
       

        return response()->json(['success' => 1, 'rows' => $categories],200);

    }

    public static function store() {
        $name = request()->name;
        if (empty($name)) {
            return response()->json(['success' => 0, 'message' => 'Please enter a job category name'],500);
        }

        $category = new JobCategory;
        $category->name = $name;
        $category->save();

        return response()->json(['success' => 1, 'data' => $category, 'message' => 'Job Category has been successfully added!'],200);
    }

    public static function update()
    {
        // ensures if the category id exist
        $category = JobCategory::find(request()->id);
        if (!$category) {
            return response()->json(['success' => 0, 'message' => 'Could not find Job Category!'], 200);
        }

        $category->name = request()->name;
        $category->push();

        return response()->json(['success' => 1, 'row' => $category], 200);
    }

    public static function delete($id)
    {
        // ensures if the category id exist
        $category = JobCategory::find($id);
        if (!$category) {
            return response()->json(['success' => 0, 'message' => 'Could not find Job Category!'], 200);
        }

        $category->delete();
        return response()->json(['success' => 1, 'row' => $category], 200);
    }

}