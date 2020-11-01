<?php

namespace App\Repositories\Interfaces;

use Illuminate\Http\Request;


Interface IUser
{
    public function findByEmail($email);
    public function search(Request $request);
}