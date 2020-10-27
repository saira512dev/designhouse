<?php

namespace App\Models;

// use Laravel\Jetstream\Events\TeamCreated;
// use Laravel\Jetstream\Events\TeamDeleted;
// use Laravel\Jetstream\Events\TeamUpdated;
// use Laravel\Jetstream\Team as JetstreamTeam;
use Illuminate\Database\Eloquent\Model;


class Team extends Model
{
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    // protected $casts = [
    //     'personal_team' => 'boolean',
    // ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'owner_id',
        'slug',
    ];


    protected static function boot()
    {
        parent::boot();

        //when a team is created,add current user as team member
        static::created(function($team){
            $team->members()->attach(auth()->id());
        });

        static::deleting(function($team){
            $team->members()->sync([]);
        });
    } 



    public function owner()
    {
        return $this->belongsTo(User::class,'owner_id');
    }

    public function members()
    {
        return $this->belongsToMany(User::class)
        ->withTimestamps();
    }

    public function designs()
    {
        return $this->hasMany(Design::class);
    }

    public function hasUser(User $user)
    {
        return $this->members()
                ->where('user_id',$user->id)
                ->first() ? true: false;
    }

    public function invitations()
    {
        return $this->hasMany(Invitation::class);
    }

    public function hasPendingInvite($email)
    {
        return (bool)$this->invitations()
                            ->where('recipient_email',$email)
                            ->count();
    }

    /**
     * The event map for the model.
     *
     * @var array
     */
    // protected $dispatchesEvents = [
    //     'created' => TeamCreated::class,
    //     'updated' => TeamUpdated::class,
    //     'deleted' => TeamDeleted::class,
    // ];
}
