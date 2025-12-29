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
            // Check if we can connect to the database
            DB::connection()->getPdo();
            
            // Check if database name is available (connection is established)
            $databaseName = DB::connection()->getDatabaseName();
            
            if ($databaseName && Schema::hasTable('settings')) {
                $setting = \Helper::getSetting();
                if ($setting) {
                    config()->set('setting', $setting);
                }
            }
        } catch (\PDOException $e) {
            // Database connection not available - this is normal during build/deployment
            // Silently fail to allow the application to boot
        } catch (\Exception $e) {
            // Any other exception - log but don't fail
            // This allows the application to start even if settings can't be loaded
        }
    }
}
