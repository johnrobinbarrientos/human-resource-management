<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\Company;
use App\Models\UserFile; 

use Auth;

class FileController extends Controller
{
    public function download($id)
    {
        $file = UserFile::find($id);

        if (!$file) {
            return response()->json(['success' => 0, 'message' => 'File not found...'],500); 
        }

        if ($file->type == 'resume') {
            $path = public_path('storage/resumes/'.$file->name);
        } else if ($file->type == 'ticket') {
            $path = public_path('storage/tickets/'.$file->name);
        }


     
        return response()->download($path,$file->orginal_name);
    }
}
