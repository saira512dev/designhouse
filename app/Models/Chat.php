<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Chat extends Model
{
    use HasFactory;


    public function participants()
    {
        return $this->belongsToMany(User::Class,'participants');
    }

    public function messages()
    {
        return $this->hasMany(Message::Class);
    }

    public function getLatestMessageAttribute()
    {
        return $this->messages()->latest()->first();
    }


    public function isUnreadForUser($userId)
    {
        return (bool)$this->messages()
                ->whereNull('last_read')
                ->where('user_id','<>',$userId)
                ->count();
    }

    public function markAsReadForUser($userId)
    {
        $this->messages()
            ->whereNull('last_read')
            ->where('user_id','<>',$userId)
            ->update([
                'last_read' => Carbon::now()
            ]);

    }
}
