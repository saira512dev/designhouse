<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Auth;


class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'username' => $this->username,
            $this->mergeWhen(Auth::check() && Auth::id() == $this->id,[
                'email' => $this->email,
            ]),
            'name' => $this->name,
            'photo_url' => $this->profile_photo_url,
            'designs' => DesignResource::collection(
                            $this->whenLoaded('designs')),
            'formatted_address' => $this->formatted_address,
            'tagline' => $this->tagline,
            'about' => $this->about,
            'location' => $this->location,
            'available_to_hire' => $this->available_to_hire,
            'created_dates' => [
                'created_at_human' => $this->created_at->diffForHumans(),
                'created_at' => $this->created_at
            ]

            ];
    }
}
