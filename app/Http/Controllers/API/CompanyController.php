<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\Company;

use Auth;

class CompanyController extends Controller
{

    public function search()
    {
        $keyword = request()->q;
        $type = request()->type;
        
        $companies = Company::where(function($query) use ($keyword) {
            $query->where('name','LIKE','%'.$keyword.'%')
            ->orWhere('email','LIKE','%'.$keyword.'%');
        })->get();

        foreach ($companies as $company) {
            $company->text = $company->name;
        }
            
        return response()->json(['success' => 1, 'rows' => $companies], 200); 
    }

    public function index()
    {
        $user = Auth::user();
        $keyword = request()->keyword;
        
        if (!$user || $user->type != 'Admin') {
            return response()->json(['success' => 1, 'rows' => []], 200); 
        }

        $companies = Company::where('id','>',0)->orderBy('created_at','desc');

        if (!empty($keyword)) {
            $companies = $companies->where(function($query) use ($keyword) {
                $query->where('name','like','%'.$keyword.'%')
                ->orWhere('email','like','%'.$keyword.'%')
                ->orWhere('phone','like','%'.$keyword.'%')
                ->orWhere('address','like','%'.$keyword.'%');
            });
        }

        /* pagination start */
        $count = $companies->count();
        $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
        $page = (is_numeric(request()->page)) ? request()->page : 1;
        $offset = (($page - 1 ) * $take);
        
        $companies = $companies->take($take);
        $companies = $companies->offset($offset);
        $companies = $companies->get();
        /* pagination end */

        foreach ($companies as $company) {
            $users = User::where('company_id','=',$company->id)->count();
            $company->users = $users;
        }

        return response()->json(['success' => 1, 'rows' => $companies, 'count' => $count], 200); 
    }

    public function getCompany($id)
    {

        $company = Company::where('id','=',$id)->get();
        return response()->json(['success' => 1, 'rows' => $company], 200);
    }

    public function store()
    {
        $company = new Company;
        $company->name = request()->company_name;
        $company->address = request()->company_address;
        $company->email = request()->email_address;
        $company->phone = request()->phone;
        $company->country_code = request()->country_code;
        $company->description = request()->description;
        $company->save();

        $company = Company::find($company->id);

        return response()->json(['success' => 1, 'data' => $company, 'message' => 'Company has been successfully added!'],200);
    }

    public function update($id)
    {
        $auth = Auth::user();

        
        if ($auth->type != 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Unable to perform the action'],500);
        }

        // var_dump('asdasd');
        // die();

        $company_id = $id;
        $company = Company::find($company_id);

        // if user type is employer
        $company_name = ucwords(request()->company_name);
        $phone = request()->phone;
        $country_code = request()->country_code;
        $company_address = request()->company_address;
        $description = request()->description;

        if (empty($company_name)) {
            return response()->json(['success' => 0, 'message' => 'Company name is required!'],500);
        }


        $company->name = $company_name;
        $company->phone = $phone;
        $company->country_code = $country_code;
        $company->address = $company_address;
        $company->description = $description;

        $company->save();
        
        return response()->json(['success' => 1, 'data' => $company, 'message' => 'Company successfully changed.'],200); 
    }
}