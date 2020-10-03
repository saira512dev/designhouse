<?php

namespace App\Http\Controllers\Auth;

use App\Providers\RouteServiceProvider;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Supports\Facades\Hash;
use Illuminate\Supports\Facades\Validator;



class RegisterController extends Controller
{


    // public function __construct()
    // {
    //     //$this->middleware('guest');
    // }
    
     protected function register(Request $request, User $user)
    {
        return response()->json($request,'200');
    }
   
    // protected function registered(Request $request, User $user)
    // {
    //     return response()->json($user,'200');
    // }
   
    // protected function validator(array $data)
    // {
    //     return validator::make($data, [
    //         'username' => ['required', 'string', 'max:15', 'alpha_dash','unique:users,username'],
    //         'name' => ['required', 'string', 'max:255'],
    //         'email' => ['required','string','email','max:255','unique:users'],
    //         'password' => ['required', 'string', 'min:8','confirmed'],
    //     ]);
    // }

    // protected function create(array $data)
    // {
    //     return User::create([
    //         'name' => $data['name'],
    //         'username' => $data['username'],
    //         'email' => $data['email'],
    //         'password' => Hash::make($data['password']),
    //     ]);
    // }   

    
}
