<?php

namespace App\Http\Controllers\Teams;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use App\Repositories\Interfaces\{ITeam,IUser,IInvitation};
use Illuminate\Support\Str;
use App\Http\Resources\TeamResource;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\Auth;


class TeamsController extends Controller
{
    use AuthorizesRequests;

    protected $teams;
    protected $users;
    protected $invitations;

    public function __construct(ITeam $teams,IUser $users,IInvitation $invitations)
    {
        $this->teams = $teams;
        $this->users = $users;
        $this->invitations = $invitations;

    }
    
    //get list of all items
    public function index()
    {
        $teams = $this->teams->all();
        return TeamResource::collection($teams);
    
    }

    //save team to database
    public function store(Request $request)
    {
        $this->validate($request,[
            'name' => ['required','string','max:80','unique:teams,name']
        ]);

        //create a team in database
        $team = $this->teams->create([
            'owner_id' => auth()->id(),
            'name' => $request->name,
            'slug' => Str::slug($request->name)
        ]);

        //current user is inserted as team member
        // using boot method in team model

        return new TeamResource($team);
    }


    //update team in database
    public function update(Request $request,$id)
    {
        $team = $this->teams->find($id);

        $this->authorize('update', $team);
        
        $this->validate($request,[
            'name' => ['required','string','max:80','unique:teams,name,'.$id]
        ]);
            

        $team = $this->teams->update($id,[
            'name' => $request->name,
            'slug' => Str::slug($request->name)
        ]);


        return new TeamResource($team);
    }

    //fetch teams of a particular users
    public function fetchUserTeams()
    {
        $teams = auth()->user()->teams;
        return TeamResource::collection($teams);
    }

    //search for a team by its id
    public function findById($id)
    {
        $team = $this->teams->find($id);
        return new TeamResource($team);
    }

    //search for a team by its slug
    public function findBySlug($slug)
    {
        $team = $this->teams->find($slug);
        return new TeamResource($team);
    }

    //delete team from database
    public function destroy($id)
    {
        $team = $this->teams->find($id);
        $this->authorize('delete',$team);

        $team->delete();

        return response()->json(['message' => 'Team deleted'], 200);
    }

    public function removeFromTeam($teamId,$userId)
    {
        $team = $this->teams->find($teamId);
        $user = $this->users->find($userId);

        //check that the user is not the owner
        if($user->isOwnerOfTeam($team)){
            return response()->json([
                'message' => 'you are the owner'
            ],401);
        }

        //check that the person sending request is either the owner of the team
        //or the person himself who wants to exit
        if(!auth()->user()->isOWnerOfTeam($team) && auth()->id() != $user->id){
            return response()->json([
                'message' => 'you cannot do this'
            ],401);
        }
        $this->invitations->removeUserFromTeam($team,$userId);

        return response()->json(['message' => 'success'], 200);
    }

}
