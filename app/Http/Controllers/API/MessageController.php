<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\Message; 

class MessageController extends Controller
{
    // RECEIVER CONTROLS

    public function getUserMessages($user_id) {
        $user = User::find($user_id);
        
        // ensures if the user exist
        if (!$user) {
            return response()->json(['success' => 0, 'message' => 'User Does not exist!'], 200);
        }

        // get all messages
        $messages = Message::with('receiver')
            ->with('sender')
            ->with('messageReplies')
            ->where('receiver_id', $user->id)
            ->orWhere('sender_id', $user->id)
            ->orderByDesc('created_at')
            ->get();
        return response()->json(['success' => 1, 'rows' => $messages], 200);
    }

    // SENDER CONTROLS

    public static function store() {
        $message = new Message();

        $message->sender_id = request()->sender_id;
        $message->receiver_id = request()->receiver_id;

        $message->title = request()->title;
        $message->message = request()->message;
        $message->important = 0;
        $message->read = 0;
        $message->save();

        return response()->json(['success' => 1, 'rows' => $message], 200);
    }

    
    public static function update() {
        $message = Message::find(request()->message_id);

        $message->title = request()->title;
        $message->message = request()->message;
        $message->important = request()->important;
        $message->read = request()->read;
        $message->push();

        return response()->json(['success' => 1, 'rows' => $message], 200);
    }
    
}