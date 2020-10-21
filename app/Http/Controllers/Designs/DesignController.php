<?php

namespace App\Http\Controllers\Designs;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\Design;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use App\Http\Resources\DesignResource;
use Illuminate\Support\Facades\Storage;
use App\Repositories\Interfaces\IDesign;
use App\Repositories\Eloquent\Criteria\{LatestFirst,IsLive,ForUser,EagerLoad};
use App\Repositories\Criteria\ICriteria;
use App\Repositories\Criteria\ICriterion;


class DesignController extends Controller
{
    use AuthorizesRequests;
    
    protected $designs;

    public function __construct(IDesign $designs)
    {
        $this->designs = $designs;
    }
    
    
    public function index()
    {
        $designs = $this->designs->withCriteria([
            new LatestFirst(),
            new IsLive(),
            new ForUser(1),
            new EagerLoad(['user','comments'])
        ])->all();

        return DesignResource::collection($designs);
    }

    public function findDesign($id)
    {
        $design = $this->designs->find($id);
        return new DesignResource($design);
    }

    public function update(Request $request,$id)
    {
        $design = $this->designs->find($id);
        //return $user = $design->user();

        $this->authorize('update', $design,$design);
        
        $this->validate($request,[
            'title' => ['required', 'unique:designs,title,'.$id],
            'description' => ['required','string','min:20', 'max:140'],
            'tags' => ['required']
        ]);
            

        $design = $this->designs->update($id,[
            'title' => $request->title,
            'description' => $request->description,
            'slug' => Str::slug($request->title),
            'is_live' => !$design->upload_successfull ? false :$request->is_live
        ]);

        //Apply tags
       $this->designs->applyTags($id,$request->tags);

        return new DesignResource($design);
    }

    public function destroy($id)
    {
        $design = $this->designs->find($id);
        $this->authorize('delete', $design);

        //delete the files associated with the record
        foreach(['thumbnail','large','original'] as $size){
            //check if the file exists
            if(Storage::disk($design->disk)->exists("uploads/designs/{$size}/".$design->image)){
                Storage::disk($design->disk)->delete("uploads/designs/{$size}/".$design->image);
            }
        }

        $this->designs->delete($id);

        return response()->json(["message" => "Record deleted"], 200);

    }

    public function like($id)
    {
        $this->designs->like($id);
        
        return response()->json(["message" => "successfull"], 200);
    }

    public function checkIfUserHasLiked($designId)
    {
        $isLiked =  $this->designs->isLikedByUser($designId);
        return response()->json(["liked" => $isLiked],200);
    }
    
}
