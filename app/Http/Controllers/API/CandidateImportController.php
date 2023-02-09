<?php
namespace App\Http\Controllers\API;

use App\Imports\CandidatesImport;
use App\Http\Controllers\Controller;
use Maatwebsite\Excel\Facades\Excel; 
use Illuminate\Http\Request;

class CandidateImportController extends Controller
{
    public function store(Request $request) {
        $file = $request->file;

        #Excel::import(new CandidatesImport, $file);
        $import = new CandidatesImport;
        $import->import($file);

        return response()->json(['success' => 1, 'errors' => $import->errors, 'imported' => $import->imported_counter], 200); 
    }
}
