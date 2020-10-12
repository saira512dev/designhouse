<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Public routes
Route::get('me', 'User\MeController@getMe');

//Routes for authenticated users only

Route::group(['middleware' => ['auth:api']],function(){
    Route::post('logout','Auth\LoginController@logout');
});

//Routes for guests only
Route::group(['middleware' => ['guest:api']], function(){
    Route::post('register', 'Auth\RegisterController@create');
    Route::post('verification/verify/{user}', 'Auth\VerificationController@verify')->name('verification.verify');
    Route::post('verification/resend', 'Auth\VerificationController@resend')->middleware([ 'throttle:6,1'])->name('verification.send');    
    Route::post('login', 'Auth\LoginController@authenticate');
    Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail');
    Route::post('password/reset', 'Auth\ResetPasswordController@reset');

});





