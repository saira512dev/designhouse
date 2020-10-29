<?php

namespace App\Repositories\Interfaces;

Interface IChat
{
    public function createParticipants($chatId,array $data);
    public function getUserChats();
}