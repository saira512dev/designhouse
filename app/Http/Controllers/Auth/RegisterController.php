<?php

namespace App\Http\Controllers\Auth;

use App\Providers\RouteServiceProvider;
use App\Models\User;
use Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Actions\Fortify\PasswordValidationRules;
use Illuminate\Auth\Events\Registered;
use App\Http\Controllers\Auth\Controller;
use App\Repositories\Interfaces\IUser;


class RegisterController extends Controller
{ 
    use PasswordValidationRules;

    public function __construct(IUser $users)
    {
        $this->users = $users;
    }

    public function create(Request $request)
    {
        $input = $request->all();
        
        Validator::make($input, [
            'name' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => $this->passwordRules(),
        ])->validate();

        $result = $this->users->create([
            'name' => $input['name'],
            'username' => $input['username'],
            'email' => $input['email'],
            'password' => Hash::make($input['password']),
        ]);

        event(new Registered($result));


        // $result->sendEmailVerificationNotification();

        return response()->json($result,'200');
    }
   
    
    
}
