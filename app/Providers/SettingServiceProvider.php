<?php

namespace App\Providers;

use Illuminate\Support\Facades\Schema;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\DB;

class SettingServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        try {
            if (DB::connection()->getDatabaseName()) {
                if (Schema::hasTable('settings')) {
                    $setting = \Helper::getSetting();
                    config()->set('setting', $setting);
                }
            }
        } catch (\Exception $e) {
            // Silently fail during build/deployment when database is not available
            // This allows config:cache to work during build phase
        }
    }
}
