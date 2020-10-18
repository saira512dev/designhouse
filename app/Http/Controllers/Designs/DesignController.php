<?php

namespace App\Http\Controllers\Designs;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\Design;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use App\Http\Resources\DesignResource;
use Illuminate\Support\Facades\Storage;


class DesignController extends Controller
{
    use AuthorizesRequests;

    public function index()
    {
        $designs = Design::all();
        return DesignResource::collection($designs);
    }

    public function update(Request $request,$id)
    {
        $design = Design::findOrFail($id);
        //return $user = $design->user();

        $this->authorize('update', $design,$design);
        
        $this->validate($request,[
            'title' => ['required', 'unique:designs,title,'.$id],
            'description' => ['required','string','min:20', 'max:140'],
            'tags' => ['required']
        ]);


        $design->update([
            'title' => $request->title,
            'description' => $request->description,
            'slug' => Str::slug($request->title),
            'is_live' => !$design->upload_successfull ? false :$request->is_live
        ]);

        //Apply tags
       $design->retag($request->tags);

        return new DesignResource($design);
    }

    public function destroy($id)
    {
        $design = Design::findOrFail($id);
        $this->authorize('delete', $design);

        //delete the files associated with the record
        foreach(['thumbnail','large','original'] as $size){
            //check if the file exists
            if(Storage::disk($design->disk)->exists("uploads/designs/{$size}/".$design->image)){
                Storage::disk($design->disk)->delete("uploads/designs/{$size}/".$design->image);
            }
        }

        $design->delete();

        return response()->json(["message" => "Record deleted"], 200);

    }
    
}
