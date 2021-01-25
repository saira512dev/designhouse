<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//Public routes
Route::get('me', 'User\MeController@getMe');

//Get designs
Route::get('designs','Designs\DesignController@index');
Route::get('designs/{id}','Designs\DesignController@findDesign');
Route::get('designs/slug/{slug}','Designs\DesignController@findBySlug');
Route::get('designs/tag/{tag}','Designs\DesignController@searchByTag');


//get users
Route::get('users', 'User\UserController@index');
Route::get('users/{id}/designs', 'Designs\DesignController@getForUser');
Route::get('users/{username}', 'User\UserController@findByUsername');


//get teams
Route::get('teams/slug/{slug}', 'Teams\TeamsController@findBySlug');
Route::get('teams/{id}/designs', 'Designs\DesignController@getForTeam');

//search designs
Route::get('search/designs','Designs\DesignController@search');
Route::get('search/designers','User\UserController@search');


//Routes for authenticated users only

Route::group(['middleware' => ['auth:api']],function(){
    Route::post('logout','Auth\LoginController@logout');
    Route::put('settings/profile', 'User\SettingsController@updateProfile');
    Route::put('settings/password', 'User\SettingsController@updatePassword');

    //Upload Designs
    Route::post('designs','Designs\UploadController@upload');
    Route::put('designs/{id}','Designs\DesignController@update');
    Route::get('designs/{id}/byUser','Designs\DesignController@userOwnsDesign');
    Route::delete('designs/{id}','Designs\DesignController@destroy');

    //likes and unlikes
    Route::post('designs/{id}/like','Designs\DesignController@like');
    Route::get('designs/{id}/liked','Designs\DesignController@checkIfUserHasLiked');

    //comments
    Route::post('designs/{id}/comments','Designs\CommentController@store');
    Route::put('comments/{id}','Designs\CommentController@update');
    Route::delete('comments/{id}','Designs\CommentController@destroy');

    //teams
    Route::post('teams', 'Teams\TeamsController@store');
    Route::get('teams/{id}', 'Teams\TeamsController@findById');
    Route::get('teams', 'Teams\TeamsController@index');
    Route::get('members/teams', 'Teams\TeamsController@fetchUserTeams');
    Route::put('teams/{id}', 'Teams\TeamsController@update');
    Route::delete('teams/{id}', 'Teams\TeamsController@destroy');
    Route::delete('teams/{team_id}/users/{user_id}', 'Teams\TeamsController@removeFromTeam');


    //invitations
    Route::post('invitations/{teamId}','Teams\InvitationsController@invite');
    Route::post('invitations/{id}/resend','Teams\InvitationsController@resend');
    Route::post('invitations/{id}/respond','Teams\InvitationsController@respond');
    Route::delete('invitations/{id}','Teams\InvitationsController@destroy');

    //chats
    Route::post('chats', 'Chats\ChatController@sendMessage');
    Route::get('chats', 'Chats\ChatController@getUserChats');
    Route::get('chats/{id}/messages', 'Chats\ChatController@getChatMessages');
    Route::put('chats/{id}/markAsRead', 'Chats\ChatController@markAsRead');
    Route::delete('messages/{id}', 'Chats\ChatController@destroyMessage');

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





