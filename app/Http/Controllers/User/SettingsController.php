<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Support\Facades\Auth;
use App\Rules\MatchOldPassword;
use App\Rules\CheckSamePassword;
use Illuminate\Http\Request;
use App\Http\Resources\UserResource;
use Grimzy\LaravelMysqlSpatial\Types\Point;
use App\Repositories\Interfaces\IUser;
use Validator;

class SettingsController extends Controller
{
    
    
    public function __construct(IUser $users)
    {
        $this->users = $users;
    }
    
    public function updateProfile(Request $request)
    {
        $user = auth()->user();

        $this->validate($request,[
            'tagline' => ['required'],
            'name' => ['required'],
            'about' => ['required','string','min:20'],
            'formatted_address' => ['required'],
            'location.latitude' => ['required','numeric','min:-90','max:90'],
            'location.longitude' => ['required','numeric','min:-180','max:180'],
        ]);

        $location =  new Point($request->location['latitude'], $request->location['longitude']);
            
        $user = $this->users->update(auth()->id(),[
            'tagline' => $request->tagline,
            'name' => $request->name,
            'about' => $request->about,
            'formatted_address' => $request->formatted_address,
            'location' => $location,
            'available_to_hire' =>$request->available_to_hire,
        ]);


        return new UserResource($user);

    }

    public function updatePassword(Request $request)
    {
        $this->validate($request,[
            'current_password' => ['required', new MatchOldPassword],
            'password' => ['required','confirmed','min:6',new CheckSamePassword],
        ]);

        $user = $this->users->update(auth()->user()->id,[
            'password' => bcrypt($request->password)
        ]);

        return response()->json(['message' => 'password updated'],200);
    }
}
