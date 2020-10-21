<?php
namespace App\Repositories\Eloquent;
use App\Models\Comment;
use App\Repositories\Interfaces\IComment;

class CommentRepository extends BaseRepository implements IComment
{
    public function model()
    {
        return Comment::class;
    }

    
}