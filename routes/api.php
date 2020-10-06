<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Routes for authenticated users only

Route::group(['middleware' => ['auth:api']],function(){

});

//Routes for guests only
Route::group(['middleware' => ['guest:api']], function(){
    Route::post('register', 'Auth\RegisterController@create');
    Route::post('verification/verify/{user}', 'Auth\VerificationController@verify')->name('verification.verify');
    Route::post('verification/resend', 'Auth\VerificationController@resend')->middleware([ 'throttle:6,1'])->name('verification.send');    
    Route::post('login', 'Auth\LoginController@authenticate');
});





