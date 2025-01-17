<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Cviebrock\EloquentTaggable\Taggable;
use App\Models\Traits\Likeable;

class Design extends Model
{
    use HasFactory,Taggable,Likeable;

    protected $fillable = [
        'user_id',
        'image',
        'team_id',
        'title',
        'description',
        'slug',
        'close_to_comment',
        'is_live',
        'upload_successfull',
        'disk'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function comments()
    {
        return $this->morphMany(Comment::class,'commentable')
                    ->orderBy('created_at','asc');
    }

    public function team()
    {
        return $this->belongsTo(Team::class);
    }

    public function getImagesAttribute()
    {
        return[
            'thumbnail' => $this->getImagePath('thumbnail'),
            'large' => $this->getImagePath('large'),
            'original' => $this->getImagePath('original')

        ];
    }

    protected function getImagePath($size)
    {
        return Storage::disk($this->disk)
                           ->url("uploads/designs/{$size}/".$this->image);
    }
}
