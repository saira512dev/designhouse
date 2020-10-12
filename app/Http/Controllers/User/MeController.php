<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Http\Resources\UserResource;

class MeController extends Controller
{
    public function getMe()
    {
        if(Auth::check()){
            $user = Auth::user();
            return new UserResource($user);
            //return response()->json(["user" => Auth::user()],200);
        }
        return response()->json(["error" => "not autenticated"],401);
    }
}
