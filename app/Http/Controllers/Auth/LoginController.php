<?php

namespace App\Http\Controllers\Auth;

use App\Providers\RouteServiceProvider;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Contracts\Auth\StatefulGuard;
use Illuminate\Auth\SessionGuard;
use JWTAuth;
use Tymon\JWTAuth\Token;
use Validator;
use App\Http\Controllers\Auth\Controller;



class LoginController extends Controller
{ 

    protected $guard;

    public function __construct()
    {
        $this->guard = "api";

    }
    
    
    public function authenticate(Request $request)
    {  
        $input = $request->all();
 
        Validator::make($input, [  
            'email' => ['required', 'string', 'email', 'max:255'],
            'password' => ['required','string'],
        ])->validate();

        
        $credentials = $request->only('email', 'password');
        //getting token for the user
        $token = auth($this->guard)->attempt($credentials);

        if(empty($token))
        {
            return response()->json(["errors" => [
                "failed" => "invalid credentials"
            ]]);
        }
       
        //get authenticated user
        $user = auth($this->guard)->user();

        if( ! $user->hasVerifiedEmail())
        {
            return response()->json(["errors" => [
                "verification" => "you need to verify your email account"
            ]]);
        }


            //set user's token
        auth($this->guard)->setToken($token);
        $token = auth($this->guard)->getToken();
        $expiration = JWTAuth::decode($token)->get('exp');


        return response()->json([
            'token' => (string)$token,
            'token_type' => 'bearer',
            'expires_in' => $expiration
        ]);       
    }

    public function logout()
    {
        auth($this->guard)->logout();
        return response()->json(['message' => 'logged out successfully!']);
    }
    

   
    
}
