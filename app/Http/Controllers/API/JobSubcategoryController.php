<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\JobCategory; 
use App\Models\JobSubcategory; 
use App\Models\JobSubcategoryItem; 

use Illuminate\Support\Facades\Auth; 

class JobSubcategoryController extends Controller
{
    public function index()
    {
       

        $keyword = request()->keyword;

        if (!empty($keyword)) {
            $subcategories = JobSubcategory::where('name','like','%'.$keyword.'%')->with('jobCategory')->get();
        } else {
            $subcategories = JobSubcategory::with('jobCategory')->get();
        }

        foreach ($subcategories as $subcategory) {
            $job_types = JobSubcategoryItem::where('job_subcategory_id','=',$subcategory->id)->with('jobType')->get();
            $subcategory->job_types = $job_types;
        }

        return response()->json(['success' => 1, 'rows' => $subcategories],200);

    }

    public static function store() {

        $category_id = request()->category_id;
        $name = request()->name;

        if (empty($name)) {
            return response()->json(['success' => 0, 'message' => 'Please enter a job subcategory name'],500);
        }

        $exists = JobCategory::find($category_id);

        if (!$exists) {
            return response()->json(['success' => 0, 'message' => 'Please select a category'],500);
        }

        $subcategory = new JobSubcategory;
        $subcategory->job_category_id = $category_id;
        $subcategory->name = $name;
        $subcategory->save();

        $subcategory = JobSubcategory::with('jobCategory')->find($subcategory->id);

        return response()->json(['success' => 1, 'data' => $subcategory, 'message' => 'Job Subcategory has been successfully added!'],200);
    }

    public static function update()
    {
        // ensures if the subcategory id exist
        $subcategory = JobSubcategory::find(request()->id);
        if (!$subcategory) {
            return response()->json(['success' => 0, 'message' => 'Could not find Job Sub Category!'], 200);
        }

        // ensures if the category id exist
        $exists = JobCategory::find(request()->category_id);
        if (!$exists) {
            return response()->json(['success' => 0, 'message' => 'Please select a category'],500);
        }

        $subcategory->job_category_id = request()->category_id;
        $subcategory->name = request()->name;
        $subcategory->push();

        return response()->json(['success' => 1, 'row' => $subcategory], 200);
    }

    public static function delete() {
        $category = JobSubcategory::find(request()->id);
        if (!$category) {
            return response()->json(['success' => 0, 'message' => 'Could not find Job Sub Category!'], 200);
        }

        $category->delete();
        return response()->json(['success' => 1, 'row' => $category], 200);
    }

    public static function jobTypes($subcategoryID) {
        
        $items = JobSubcategoryItem::where('job_subcategory_id','=',$subcategoryID);

        if (isset(request()->fields) && request()->fields !== '') {
            $fields = explode(',',request()->fields);
            $items = $items->get($fields);
        } else {
            $items = $items->get();
        }

        

        return response()->json(['success' => 1, 'rows' => $items],200);
    }
    
    public static function jobTypeStore($subcategoryID) {
        
        $job_type_ids = request()->job_type_ids;
        
        $items = JobSubcategoryItem::where('job_subcategory_id','=',$subcategoryID)->delete();

        foreach ($job_type_ids as $job_type_id) {
            $item = JobSubcategoryItem::withTrashed()->where('job_subcategory_id','=',$subcategoryID)->find($job_type_id);
            $item = ($item) ? $item : new JobSubcategoryItem ;
            $item->job_subcategory_id = $subcategoryID;
            $item->job_type_id	 = $job_type_id;
            $item->deleted_at = null;
            $item->save();
        }

        return response()->json(['success' => 1, 'rows' => $job_type_ids],200);
    }

    

}