<?php
namespace App\Repositories\Eloquent;
use App\Models\User;
use App\Repositories\Interfaces\IUser;

class UserRepository extends BaseRepository implements IUser
{
    public function model()
    {
        return User::class;
    }
   
}