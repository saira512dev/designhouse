<?php
namespace App\Repositories\Eloquent;
use App\Models\Design;
use App\Repositories\Interfaces\IDesign;
use Illuminate\Http\Request;


class DesignRepository extends BaseRepository implements IDesign
{
    public function model()
    {
        return Design::class;
    }

    public function applyTags($id, array $data)
    {
        $design = $this->find($id);
        $design->retag($data);
    }

    public function addComment($designId, array $data)
    {
        //get the design for which we want to create a comment
        $design = $this->find($designId);

        //create the comment
        $comment = $design->comments()->create($data);

        return $comment;
    }

    public function like($id)
    {
        $design = $this->model->findOrFail($id);
        if($design->isLikedByUser(auth()->id())){
            $design->unlike();
        } else {
            $design->like();
        }
    }

    public function isLikedByUser($id)
    {
        $design = $this->model->findOrFail($id);

        return $design->isLikedByUser(auth()->id());
    }

    public function search(Request $request)
    {
        $query = ($this->model)->newQuery();

        $query->where('is_live',true);
        
        //return only designs having comments
        if($request->has_comments){
            $query->has('comments');
        }
        
        
        //return only designs assigned to teams
        if($request->has_team){
            $query->has('team');
        }
        
        //search title and description for provided string
        if($request->q){
            $query->where(function($q) use ($request){
                $q->where('title', 'like','%'.$request->q.'%')
                    ->orWhere('description','like','%'.$request->q.'%');
            });
        }
        
        
        //order the query by likes or latest first
        if($request->orderBy == 'likes'){
            $query->withCount('likes')//likes_count
                    ->orderByDesc('likes_count');
        } else {
            $query->latest();
        }

        return $query->get();
    }

    public function getByTag($tag)
    {

         $designs = $this->model->withAllTags($tag)->get();
         return $designs;
    }

    public function getMostLiked()
    {

         $designs = $this->model->withCount('likes')->orderByDesc('likes_count')->limit(4)->get();
         return $designs;
    }


}