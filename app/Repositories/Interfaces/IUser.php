<?php

namespace App\Repositories\Interfaces;

Interface IUser
{
    public function findByEmail($email);
}