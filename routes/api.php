<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
//Route::post('auth', 'API\UserController@login');
Route::get('/auth/verification/{token}','API\AuthController@verifyToken');
Route::get('/auth/email-change-verification/{token}','API\AuthController@changeEmailVerifyToken');
Route::post('/register', 'API\AuthController@register');
Route::post('/login', 'API\AuthController@login');
Route::post('/confirmation', 'API\AuthController@confirmation');

Route::post('/forgot-password','API\ForgotPasswordController@retrieve');
Route::post('/forgot-password-complete','API\ForgotPasswordController@complete');

Route::get('/users/search','API\UserController@search');
Route::get('/jobs/search', 'API\JobPostController@search');
Route::get('/companies/search','API\CompanyController@search');

Route::get('/personnel-requests/search','API\PersonnelRequestController@search');
Route::get('/job-types', 'API\JobTypeController@index');

Route::get('/test/email', 'API\UserResumeController@test');

Route::get('/user/{id}/skills','API\UserSkillController@index');


Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['prefix' => 'files'], function(){
    Route::get('/{id}/download', 'API\FileController@download');
});

Route::group(['prefix' => 'test'], function(){
    Route::get('/', function() {

        $coupon = sprintf('MLIVE %03d',990);  
        echo date('Y-m-d 00:00:00');
        echo '<br/>';
        echo date('Y-m-d 23:59:59');
    });
});

Route::group(['middleware' => ['auth:api'] ], function(){
    Route::get('/auth/check','API\AuthController@check');
    Route::get('/auth/revoke','API\AuthController@revoke');
    Route::get('/stats/counter','API\StatsController@counter');
    Route::get('/stats/employer-counter','API\StatsController@employerCounter');
    Route::get('/stats/activities','API\StatsController@activities');

    Route::group(['prefix' => 'companies'], function(){
        Route::get('/','API\CompanyController@index');
        Route::post('/','API\CompanyController@store');
        Route::get('company/{id}','API\CompanyController@getCompany');
        Route::put('/{id}','API\CompanyController@update');

        Route::get('/{company_id}/company','API\CompanyEmployeeController@getCompany');
        Route::get('/employees','API\CompanyEmployeeController@getEmployees');
        Route::post('/{company_id}/employees/{employee_id}','API\CompanyEmployeeController@removeOrRehireEmployee');
    });

   
    Route::group(['prefix' => 'jobs'], function(){

        Route::post('/request/create', 'API\JobPostController@createJobRequest');

        Route::get('/posts/recommendations', 'API\JobPostRecommendationController@index');
        Route::get('/posts/{id}/recommendations', 'API\JobPostRecommendationController@show');
        Route::post('/posts/{id}/recommendations', 'API\JobPostRecommendationController@save');
        Route::delete('/posts/{id}/recommendations', 'API\JobPostRecommendationController@delete');

        Route::post('/posts/{id}/recommendations/accept', 'API\JobPostRecommendationController@accept');
        Route::post('/posts/{id}/recommendations/decline', 'API\JobPostRecommendationController@decline');

        Route::post('/posts/{id}/recommendations/accept/{token}', 'API\JobPostRecommendationController@acceptByToken');
        Route::post('/posts/{id}/recommendations/decline/{token}', 'API\JobPostRecommendationController@declineByToken');

        Route::get('/posts/candidate-recommendations', 'API\JobPostCandidateRecommendationController@index');
        Route::get('/posts/{id}/candidate-recommendations', 'API\JobPostCandidateRecommendationController@show');
        Route::post('/posts/{id}/candidate-recommendations', 'API\JobPostCandidateRecommendationController@save');

        Route::post('/posts/{id}/candidate-recommendations/accept', 'API\JobPostCandidateRecommendationController@accept');
        Route::post('/posts/{id}/candidate-recommendations/decline', 'API\JobPostCandidateRecommendationController@decline');

        Route::post('/posts/{id}/candidate-recommendations/accept/{token}', 'API\JobPostCandidateRecommendationController@acceptByToken');
        Route::post('/posts/{id}/candidate-recommendations/decline/{token}', 'API\JobPostCandidateRecommendationController@declineByToken');


        Route::get('/posts', 'API\JobPostController@index');
        Route::post('/posts', 'API\JobPostController@store');
        Route::put('/posts', 'API\JobPostController@update');

        Route::get('/posts/{id}', 'API\JobPostController@show');
        Route::delete('/posts/{id}', 'API\JobPostController@delete');

        Route::get('/posts/{id}/matches', 'API\JobPostMatchController@index');
        Route::get('/posts/{jobPostID}/matches/{userID}', 'API\JobPostMatchController@skills');

        Route::post('/posts/{id}/visibility', 'API\JobPostController@visibility');
    });

    Route::group(['prefix' => 'job-categories'], function(){
        Route::get('/', 'API\JobCategoryController@index');
        Route::post('/', 'API\JobCategoryController@store');
        Route::put('/', 'API\JobCategoryController@update');
        Route::delete('/{id}', 'API\JobCategoryController@delete');
    });

    Route::group(['prefix' => 'job-subcategories'], function(){
        Route::get('/', 'API\JobSubcategoryController@index');
        Route::post('/', 'API\JobSubcategoryController@store');

        Route::get('/{subcategoryID}/job-types', 'API\JobSubcategoryController@jobTypes');
        Route::post('/{subcategoryID}/job-types', 'API\JobSubcategoryController@jobTypeStore');
        Route::put('/', 'API\JobSubcategoryController@update');
        Route::delete('/{id}', 'API\JobSubcategoryController@delete');
    });

    Route::group(['prefix' => 'job-subcategory-items'], function(){
        Route::get('/', 'API\JobSubcategoryItemController@index');
    });

    Route::group(['prefix' => 'job-types'], function(){
        Route::post('/', 'API\JobTypeController@store');
        Route::put('/', 'API\JobTypeController@update');
        Route::delete('/{id}', 'API\JobTypeController@delete');
    });

    Route::group(['prefix' => 'users'], function(){
        Route::put('/candidate/inline','API\UserController@updateCandidateProfile');

        Route::get('/','API\UserController@index');
        Route::post('/','API\UserController@store');
        Route::get('/{id}/profile','API\UserController@getProfile');
        Route::put('/{id}/profile','API\UserController@updateProfile');
        Route::post('/{id}/avatar','API\UserController@uploadAvatar');
     
        Route::post('/{id}/skills','API\UserSkillController@update');

        Route::put('/{id}/password','API\UserController@updatePassword');
        Route::put('/{id}/company','API\UserController@updateCompany');
        Route::delete('/{id}', 'API\UserController@delete');
        
        Route::post('/resume', 'API\UserResumeController@save');
        Route::get('/resume/{id}', 'API\UserResumeController@show');
  
        Route::post('/resume/skill/{job_type_id}', 'API\UserResumeController@saveSkill');
        Route::delete('/resume/skill/{job_type_id}', 'API\UserResumeController@deleteSkill');

        Route::post('/resume/avatar', 'API\UserResumeController@uploadAvatar');
        Route::post('/resume/upload-resume', 'API\UserResumeController@uploadResume');
        Route::post('/resume/upload-tickets', 'API\UserResumeController@uploadTickets');
        Route::post('/resume/export', 'API\UserResumeController@exportResume');

        Route::delete('/resume/files/{file_id}', 'API\UserResumeController@deleteResumeFile');
        Route::delete('/resume/files/{ticket_id}/tickets', 'API\UserResumeController@deleteTicketsFile');

        Route::get('/{id}/ratings','API\UserRatingController@getUserRatings');
        Route::get('/{id}/ratings/{job_post_id}','API\UserRatingController@getUserJobRating');

        Route::post('/ratings','API\UserRatingController@store');
    });

    Route::group(['prefix' => 'note'], function(){ 
        Route::get('/{user_id}','API\NoteController@getNotes');
        Route::post('/{user_id}','API\NoteController@store');
        Route::put('/{note_id}','API\NoteController@update');
        Route::delete('/{note_id}','API\NoteController@delete');
    });

    Route::group(['prefix' => 'user/logs'], function(){ 
        Route::get('/','API\UserLogController@getLogs');
        Route::post('/','API\UserLogController@store');
        Route::put('/','API\UserLogController@update');
        Route::delete('/{log_id}','API\UserLogController@delete');
    });

    Route::group(['prefix' => 'candidate'], function(){
        Route::post('/message','API\UserCandidateController@sendCandidateMessage');
        Route::get('/message-history','API\UserCandidateController@getMessageHistory');

        Route::post('/import', 'API\CandidateImportController@store');
    });

    Route::group(['prefix' => 'personnel/request'], function(){
        Route::get('/','API\PersonnelRequestController@index');
        Route::get('/{id}','API\PersonnelRequestController@show');
        Route::post('/','API\PersonnelRequestController@store');
        Route::post('/send-request','API\PersonnelRequestController@sendRequest');
        Route::put('/{request_id}','API\PersonnelRequestController@update');
        Route::delete('/{request_id}','API\PersonnelRequestController@delete');
        Route::post('/{request_id}/restore','API\PersonnelRequestController@restore');
    });

    Route::group(['prefix' => 'mails'], function(){

        Route::get('/','API\MessageCenterController@index');
        Route::post('/','API\MessageCenterController@store');
        Route::put('/{mail_id}', 'API\MessageCenterController@update');
        Route::delete('/{mail_id}', 'API\MessageCenterController@delete');

    });

    Route::group(['prefix' => 'messages'], function(){
        // RECEIVER
        Route::get('/{user_id}','API\MessageController@getUserMessages');

        // SENDER
        Route::post('/','API\MessageController@store');
        Route::put('/', 'API\MessageController@update');
    });

    Route::group(['prefix' => 'message_replies'], function(){
        // RECEIVER
        Route::get('/{message_id}','API\MessageReplyController@getReplies');

        // SENDER
        Route::post('/','API\MessageReplyController@store');
    });


    Route::group(['prefix' => 'twilio'], function(){
        Route::get('/call/{user_id}','API\TwilioController@call');

        Route::get('/events','API\TwilioController@events');
    });

    Route::get('/menus', 'API\MenuController@index');

});
