<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 

use App\Models\User;
use App\Models\Message; 
use App\Models\MessageReply;

use Auth;

class MessageReplyController extends Controller
{
    // RECEIVER CONTROLS

    public function getReplies($message_id) {
        $message = Message::find($message_id);
        
        // ensures if the message exist
        if (!$message) {
            return response()->json(['success' => 0, 'message' => 'Message Does not exist!'], 200);
        }

        // get all messages
        $messages = MessageReply::with('receiver')
            ->with('sender')
            ->where('message_id', $message->id)
            ->get();

        return response()->json(['success' => 1, 'rows' => $messages], 200);
    }

    // SENDER CONTROLS

    public function store() {

        $message_id = request()->message_id;
        $message = Message::find($message_id);

        $sender = Auth::user();
        $receiver_id = ($sender->id != $message->sender_id ) ? $message->sender_id : $message->receiver_id ;
        
        $reply = new MessageReply();
        
        $reply->message_id = request()->message_id;



        $reply->sender_id = $sender->id;
        $reply->receiver_id = $receiver_id;

        $reply->message = request()->message;
        $reply->save();

        return response()->json(['success' => 1, 'rows' => $reply], 200);
    }
    
}