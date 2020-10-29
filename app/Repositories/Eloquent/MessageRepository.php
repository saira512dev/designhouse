<?php
namespace App\Repositories\Eloquent;
use App\Models\Message;
use App\Repositories\Interfaces\IMessage;

class MessageRepository extends BaseRepository implements IMessage
{
    public function model()
    {
        return Message::class;
    }

    
}