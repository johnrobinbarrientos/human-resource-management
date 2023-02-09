<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\Note;

use Illuminate\Support\Facades\Auth; 

class NoteController extends Controller
{
    
    public function getNotes($user_id) {

        // Make sure that type is admin
        if(Auth::user()->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops! Something went wrong'], 500);
        }

        $notes = Note::where('user_id', $user_id)->get();

        return response()->json(['success' => 1, 'data' => $notes], 200);
    }


    public function store($user_id) {

        // Make sure that type is admin
        if(Auth::user()->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops! Something went wrong'], 500);
        }

        if(!isset(request()->message)) {
            return response()->json(['success' => 0, 'message' => 'Note cannot be empty!'], 500);
        }

        $note = new Note();
        $note->message = request()->message;
        $note->user_id = $user_id;
        $note->save();

        return response()->json(['success' => 1,'data' => $note, 'message' => 'Note Saved!'], 200);
    }

    public function update($note_id) {

        // Make sure that type is admin
        if(Auth::user()->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops! Something went wrong'], 500);
        }

        if(!isset(request()->message)) {
            return response()->json(['success' => 0, 'message' => 'Note cannot be empty!'], 500);
        }

        $note = Note::find($note_id);
        $note->message = request()->message;
        $note->save();

        return response()->json(['success' => 1, 'data' => $note, 'message' => 'Note Updated!'], 200);
    }

    public function delete($note_id) {
        // Make sure that type is admin
        if(Auth::user()->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops! Something went wrong'], 500);
        }

        // ensures if the type id exist
        $note = Note::find($note_id);
        if (!$note) {
            return response()->json(['success' => 0, 'message' => 'Could not find Note!'], 500);
        }
        $note->delete();

        return response()->json(['success' => 1, 'message' => 'Note Deleted!'], 200);
    }


}
