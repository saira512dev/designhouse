<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Str;
use DB;

class ResetPasswordController extends Controller
{
    protected function reset(Request $request)
    {   
        $request->validate([
            'token' => 'required',
            'email' => 'required|email|exists:users',
            'password' => 'required|min:8|confirmed',
        ]);
    
        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function ($user, $password) use ($request) {
                $user->forceFill([
                    'password' => Hash::make($password)
                ])->save();
    
                $user->setRememberToken(Str::random(60));
                event(new PasswordReset($user));
            }
        );
        if($request->expectsJson()){

            return $status == Password::PASSWORD_RESET
            ?response()->json(['status' => 'Success','message' => 'New password set'],201)
            : response()->json(['status' => 'Fail','message' => 'Password could not be reset'],401);
    
        }           

    }
}
