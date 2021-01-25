<?php

namespace App\Repositories\Interfaces;

use Illuminate\Http\Request;

Interface IDesign
{
    public function applyTags($id, array $data);
    public function addComment($designId, array $data);
    public function like($id);
    public function isLikedByUser($id);
    public function search(Request $request);
    public function getByTag($tag);
}