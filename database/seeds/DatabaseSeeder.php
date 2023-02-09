<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $company = new \App\Models\CompanyList();
        $company->company_name = 'ThinkOrion';
        $company->save();
        
       
        $user = new \App\Models\User();
        $user->company_id = $company->id;
        $user->first_name = 'Kenji';
        $user->last_name = 'Magto';
        $user->email = 'kenjimagto@gmail.com';
        $user->password = Hash::make('secret123');
        $user->phone = '09171234567';
        $user->save();
    }
}
