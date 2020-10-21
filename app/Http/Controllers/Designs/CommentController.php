<?php

namespace App\Http\Controllers\Designs;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\CommentResource;
use App\Repositories\Interfaces\{IDesign,IComment};
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;


class CommentController extends Controller
{
    use AuthorizesRequests;

    protected $comments,$designs;

    public function __construct(IComment $comments,IDesign $designs)
    {
        $this->comments = $comments;
        $this->designs = $designs;
    }
    
    
    public function store(Request $request,$designId)
    {

        $this->validate($request,[
            'body' => ['required']
        ]);

        $comment = $this->designs->addComment($designId, [
            'body' => $request->body,
            'user_id' =>auth()->user()->id
        ]);

        return new CommentResource($comment);
    }

    public function update(Request $request ,$id)
    {
        $comment = $this->comments->find($id);
        $this->Authorize('update',$comment);


        $this->validate($request,[
            'body' => ['required']
        ]);
        

        $comment = $this->comments->update($id, [
            'body' => $request->body
        ]);

        return new CommentResource($comment);


    }

    public function destroy($id)
    {
        $comment = $this->comments->find($id);
        $this->Authorize('update',$comment);

        $this->comments->delete($id);

        return response()->json(["message" => "Item deleted"], 200);
    }
}
