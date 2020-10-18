<?php

namespace App\Http\Controllers\Designs;

use App\Http\Controllers\Auth\Controller;
use Illuminate\Http\Request;
use App\Jobs\UploadImage;

class UploadController extends Controller
{
    public function upload(Request $request)
    {

        $this->validate($request, [
            'image' => ['required','mimes:jpeg,gif,bmp,png', 'max:2048']
        ]);

        //get the image
        $image = $request->file('image');
        $image_path = $image->getPathName();

        //get original file name,replace spaces with _,add timestamp
        $filename = time()."_".preg_replace('/\s+/', '_', strtolower($image->getClientOriginalName()));

        //move image to temp location
        $tmp = $image->storeAs('uploads/original', $filename, 'tmp');

        //create database record for the design
        $design = auth()->user()->designs()->create([
            'image' => $filename,
            'disk' => config('site.upload_disk')
        ]);

        //dispatch a job to handle the image manipulation
        $this->dispatch(new UploadImage($design));

        return response()->json($design, 200);
    }
}
