<?php

namespace App\Exceptions;

use Exception;

class ModelNotDefined extends Exception
{
    public function render( $request)
    {
        if($request->expectsJson()){
            return response()->json([
                "errors" => [ "message" => " No Model Defined"]], 500);    
        }
    }   
}
