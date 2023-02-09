<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\UserLog;

use Illuminate\Support\Facades\Auth; 

class UserLogController extends Controller
{
    public function getLogs() {

        // Make sure that type is admin
        if(Auth::user()->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops something went wrong.']);
        }

        $logs = UserLog::with('user')
            ->where('type', request()->type)
            ->where('user_id', request()->user_id)
            ->orderBy('id','DESC')
            ->take(15)
            ->get();
            
        return response()->json(['success' => 1, 'data' => $logs]);
    }

    public function store() {
        $user_logged_in = Auth::user();

        // Make sure that type is admin
        if($user_logged_in->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops something went wrong.']);
        }
        
        $log = new UserLog();
        $log->user_id = request()->user_id;
        $log->type = request()->type;
        $log->outcome = request()->outcome;
        $log->date = request()->date;
        $log->time = request()->time;
        $log->description = request()->description;
        $log->logged_by = $user_logged_in->id;
        $log->save();

        return response()->json(['success' => 1,'data' => $log, 'message' => 'Log Saved!'], 200);
    }

    public function update() {
        $user_logged_in = Auth::user();

        // Make sure that type is admin
        if($user_logged_in->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops something went wrong.']);
        }
        
        $log = UserLog::find(request()->id);
        $log->outcome = request()->outcome;
        $log->date = request()->date;
        $log->time = request()->time;
        $log->description = request()->description;
        $log->logged_by = $user_logged_in->id;
        $log->save();

        return response()->json(['success' => 1,'data' => $log, 'message' => 'Log Updated!'], 200);
    }

    public function delete($log_id) {
        // Make sure that type is admin
        if(Auth::user()->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops! Something went wrong'], 500);
        }

        // ensures if the type id exist
        $log = UserLog::find($log_id);
        if (!$log) {
            return response()->json(['success' => 0, 'message' => 'Could not find Log!'], 500);
        }
        $log->delete();

        return response()->json(['success' => 1, 'message' => 'Log Deleted!'], 200);
    }
}