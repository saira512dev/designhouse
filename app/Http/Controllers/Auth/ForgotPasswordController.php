<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Password;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;
use App\Models\User;
use Input;


class ForgotPasswordController extends Controller
{
     protected function sendResetLinkEmail(Request $request)
    {
        $request->validate(['email' => 'required|email']);
        if (User::where('email', $request->email)->first()){
            $status = Password::sendResetLink(
                $request->only('email')
            );
            
            if($request->expectsJson()){
                return $response = Password::RESET_LINK_SENT
                    ? response()->json(['status' => 'Success','message' => 'Reset Password Link Sent'],201)
                    : response()->json(['status' => 'Fail','message' => 'Reset Link Could Not Be Sent'],401);
            }  
        }
        return response()->json(["error" => "No such user is registered with us"],401);


        // We will send the password reset link to this user. Once we have attempted
        // to send the link, we will examine the response then see the message we
        // need to show to the user. Finally, we'll send out a proper response.

        
        
        

    }
    
    
}
