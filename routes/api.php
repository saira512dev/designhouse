<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Routes for authenticated users only

Route::group(['middleware' => ['auth:sanctum']],function(){

});

//Routes for guests only
Route::group(['middleware' => ['guest:api']], function(){
    Route::post('register', 'Auth\RegisterController@register');
});




