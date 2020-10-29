<?php

namespace App\Http\Controllers\Chats;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use App\Repositories\Interfaces\{IChat,IMessage};
use App\Http\Resources\MessageResource;
use App\Http\Resources\ChatResource;
use App\Repositories\Eloquent\Criteria\WithTrashed;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;



class ChatController extends Controller
{   
    use AuthorizesRequests;

    protected $chats;
    protected $messages;

    public function __construct(IChat $chats,IMessage $messages)
    {
        $this->chats = $chats;
        $this->messages = $messages;

    }

    public function sendMessage(Request $request)
    {
        //validate the request
        $this->validate($request,[
            'recipient' => ['required'],
            'body' => ['required']
        ]);

        $recipient = $request->recipient;
        $user = auth()->user();
        $body = $request->body;
        
        
        //check if there is an existing chat 
        //between the logged in user and recipient
        $chat = $user->getChatWithUser($recipient);
        
        if(!$chat){
            $chat = $this->chats->create([]);
            $this->chats->createParticipants($chat->id,[$user->id, $recipient]);
        }
        
        $message = $this->messages->create([
            'user_id' => $user->id,
            'chat_id' => $chat->id,
            'body' => $body,
            'last_read' => null,

        ]);

        return new MessageResource($message);
    }

    public function getUserChats()
    {
        $chats = $this->chats->getUserChats();
        return ChatResource::collection($chats);
    }

    public function getChatMessages($id)
    {
        $messages = $this->messages->withCriteria([
                        new WithTrashed()
                     ])->findwhere('chat_id',$id);
        return MessageResource::collection($messages);
    }

    public function markAsRead($id)
    {
        $chat = $this->chats->find($id);
        $chat->markAsReadForUser(auth()->id());
        return response()->json(['message' => 'successful'],200);
    }

    public function destroyMessage($id)
    {
      $message = $this->messages->find($id);
      $this->authorize('delete', $message);
      $message->delete();  
    }
}
