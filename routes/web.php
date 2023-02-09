<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|

Route::get('/', 'PagesController@home');
Route::get('/find-work', 'PagesController@findWork');
Route::get('/find-workers', 'PagesController@findWorkers');
Route::get('/about-us', 'PagesController@aboutUs');
Route::get('/contact-us', 'PagesController@contactUs');
Route::post('/contact-us/send', 'PagesController@contactUsSend');

Route::get('/job/{id}', 'PagesController@browseJob');
Route::get('/browse-jobs', 'PagesController@browseJobs');
Route::get('/browse-categories', 'PagesController@browseCategories');
Route::get('/submit-resume', 'PagesController@submitResume');

Route::get('/test/mail', 'TestController@mailConfirmation');
Route::get('/test/aaa', 'TestController@aaa');
Route::get('/register')->name('login');
*/
Route::get('/{any}', 'SpaController@index')->where('any', '.*');

