<?php

namespace App\Repositories\Interfaces;

Interface IDesign
{
    public function applyTags($id, array $data);
    public function addComment($designId, array $data);
    public function like($id);
    public function isLikedByUser($id);
}