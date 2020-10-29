<?php

namespace App\Providers;

use App\Models\Team;
use App\Models\Invitation;
use App\Models\Design;
use App\Models\Message;
use App\Policies\TeamPolicy;
use App\Policies\MessagePolicy;
use App\Policies\DesignPolicy;
use App\Policies\InvitationPolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        Team::class => TeamPolicy::class,
        Design::class => DesignPolicy::class,
        Invitation::class => InvitationPolicy::class,
        Message::class => MessagePolicy::class,
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        //
    }
}
