<?php

namespace App\Repositories\Interfaces;

Interface IInvitation
{
    public function addUserToTeam($team,$user_id);
    public function removeUserFromTeam($team,$user_id);
}