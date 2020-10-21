<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Auth\Events\Registered;
use App\Http\Controllers\Auth\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundations\Auth\VerifiesEmails;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\URL;
use App\Repositories\Interfaces\IUser;



class VerificationController extends Controller
{
    /**
     * Handles Email verification for recently registered user.
     *
     * 
     */
    public function __construct(IUser $users)
    {
        $this->users = $users;
    }
    
     public function verify(Request $request,User $user)
    {
        //check if url is a valid signed url
        if(!URL::hasValidSignature($request)){
            return response()->json(["errors" => [
                "message" => "invalid verification link"]],402);
        }

        //check if user has already verified email
        if ($user->hasVerifiedEmail()) {
            return response()->json(["errors" => [
                "message" => "Email already verified"]],402);    
        }

        $user->markEmailAsVerified();
        //event(new Registered($user));
        return response()->json(["message" => "email successfully verified"],402);


    }

    public function resend(Request $request)
    {
        $this->validate($request, [
            'email' => ['email', 'required']
        ]);
        
        $user = $this->users->findWhereFirst('email', $request->email);
        if(!$user){
            return response()->json(["errors" => [
                "email" => "No user could be found with this email address"
            ]], 422);
        }
        
        //check if user has already verified email
        if ($user->hasVerifiedEmail()) {
        return response()->json(["errors" => [
            "message" => "Email already verified"]],402);    
        } 

        $user->sendEmailVerificationNotification();

        return response()->json(['status' => "verification link resent"]);
        
        
    }
    
    
    
    
    // public function store(Request $request)
    // {
    //     if ($request->user()->hasVerifiedEmail()) {
    //         return $request->wantsJson()
    //                     ? new JsonResponse('', 204)
    //                     : redirect(config('fortify.home'));
    //     }

    //     $request->user()->sendEmailVerificationNotification();

    //     return $request->wantsJson()
    //                 ? new JsonResponse('', 202)
    //                 : back()->with('status', 'verification-link-sent');
    // }
}
