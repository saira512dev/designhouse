<?php

namespace App\Http\Controllers\Teams;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use App\Repositories\Interfaces\IInvitation;
use App\Repositories\Interfaces\ITeam;
use App\Repositories\Interfaces\IUser;
use Mail;
use App\Models\Team;
use App\Mail\SendInvitationToJoinTeam;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;


class InvitationsController extends Controller
{
    use AuthorizesRequests;

    protected $invitations;
    protected $teams;
    protected $users;


    public function __construct(IInvitation $invitations,ITeam $teams,IUser $users)
    {
        $this->invitations = $invitations;
        $this->teams = $teams;
        $this->users = $users;
    }

    public function Invite(Request $request,$teamId)
    {
        //get the team
        $team = $this->teams->find($teamId);

        $this->validate($request,[
            'email' => ['required','email']
        ]);

        $user = auth()->user();
        //check if the user owns the team

        if(!$user->isOWnerOfTeam($team)){
            return response()->json([
                'email' => 'You are not the owner'
            ],401);
        }

        //check if the email has a pending invitation
        if($team->hasPendingInvite($request->email)){
            return response()->json([
                'email' => 'Email already has a pending invitation'
            ],200);
        }


        //get the recipient by email
        $recipient = $this->users->findByEmail($request->email);

        //if the recipient doesnt exist,send an invitation to join the team
        if(!$recipient){
            $this->createInvitation(false,$team,$request->email);
            return response()->json([
                'message' => 'Invitation sent to user'
            ], 200);
        
        }

        //check if the team already has the user
        if($team->hasUser($recipient)){
            return response()->json([
                'email' => 'This user seems to be team member already'
            ],422);
        
        }

        //send the invitation to the user

        $this->createInvitation(true,$team,$request->email);
        return response()->json([
             'message' => 'Invitation sent to user'
        ], 200);

    }

    public function resend($id)
    {
        $invitation = $this->invitations->find($id);
        $this->authorize('resend',$invitation);
        
        $recipient = $this->users
                        ->findByEmail($invitation->recipient_email);
                        Mail::to($invitation->recipient_email)
                        ->send(new SendInvitationToJoinTeam($invitation,!is_null($recipient)));

        return response()->json(['message' => 'Invitation resent to user'], 200);
    }

    public function respond(Request $request,$id)
    {
        $this->validate($request,[
            'token' => ['required'],
            'decision' => ['required']
        ]);

        $token = $request->token;
        $decision = $request->decision;//accept or deny
        $invitation = $this->invitations->find($id);

        //check if the invitation belongs to this user
       $this->authorize('respond',$invitation);

        //make sure the tokens match
        if($invitation->token!= $token){
            return response()->json([
                'message' => 'Invalid token'
            ],401);
        }

        //check if accepted
        if($decision != 'deny'){
           $this->invitations->addUserToTeam($invitation->team, auth()->id());
        }

        $invitation->delete();

        return response()->json(['message' => 'successful'], 200);
    }

    protected function createInvitation(bool $user_exists,Team $team ,string $email)
    {
        $invitation = $this->invitations->create([
            'team_id' => $team->id,
            'sender_id' => auth()->id(),
            'recipient_email' => $email,
            'token' => md5(uniqid(microtime()))
        ]);

        Mail::to($email)
                ->send(new SendInvitationToJoinTeam($invitation,$user_exists));
    }

    public function destroy($id)
    {
        $invitation = $this->invitations->find($id);
        $this->authorize('delete' ,$invitation);
        $invitation->delete();

        return response()->json(['message' => 'invitation deleted'],200);
    }
}
