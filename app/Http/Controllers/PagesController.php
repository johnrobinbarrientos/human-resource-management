<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;

use Mail;
use App\Mail\TestEmail;


use App\Models\JobCategory;
use App\Models\JobPostCategory;
use App\Models\JobPost;

use Curl\Curl;
use Klaviyo\Klaviyo as Klaviyo;
use Klaviyo\Model\ProfileModel as KlaviyoProfile;

class PagesController extends Controller
{
    public function home()
    {
       return $view = view('pages.index');
    }

    public function findWorkers()
    {
       return $view = view('pages.find-workers');
    }

    public function findWork()
    {
        $category = (isset($_GET['cat']) && $_GET['cat'] != '') ? $_GET['cat'] :  '';
        
        if (!empty($category)) {
            $job_category = JobCategory::where('name','=',$category)->first();

            $job_post_ids = JobPostCategory::where('job_category_id','=',$job_category->id)->pluck('job_post_id')->toArray();
            $jobs = JobPost::whereIn('id',$job_post_ids)->get();
        } else {
            $jobs = JobPost::all();
        }
       return $view = view('pages.find-work')->with('jobs', $jobs);
    }

    public function browseJobs()
    {
        $category = (isset($_GET['cat']) && $_GET['cat'] != '') ? $_GET['cat'] :  '';
        
        if (!empty($category)) {
            $job_category = JobCategory::where('name','=',$category)->first();

            $job_post_ids = JobPostCategory::where('job_category_id','=',$job_category->id)->pluck('job_post_id')->toArray();
            $jobs = JobPost::whereIn('id',$job_post_ids)->get();
        } else {
            $jobs = JobPost::all();
        }
        
        return view('pages.browse-jobs')->with('jobs', $jobs);
    }

    public function browseJob($id)
    {
      $job = JobPost::find($id);
      $job_post_category_ids = JobPostCategory::where('job_post_id','=',$job->id)->pluck('job_category_id')->toArray();
      $job->categories = JobCategory::whereIn('id',$job_post_category_ids)->get();

      return view('pages.browse-job')->with('job', $job);
    }

    public function browseCategories()
    {
        $categories = JobCategory::all();
       
        foreach ($categories as $category) {
            $category->jobs = JobPostCategory::where('job_category_id','=',$category->id)->count();
        }

        $view = view('pages.browse-categories');
        $view->categories = $categories;

        return $view;
    }


    public function aboutUs()
    {
       return $view = view('pages.about-us');
    }

    public function contactUs()
    {
       return $view = view('pages.contact-us');
    }

    public function contactUsSend()
    {
        $email = request()->email;
        $first_name = request()->first_name;
        $message = request()->message;

        if (empty($email) || empty($message) || empty($first_name)) {
            return response()->json(['success' => 0, 'message' => 'error!'],500);
        }

        $payload = [];
        $client = new Klaviyo(env('KLAVIYO_PRIVATE_KEY'),env('KLAVIYO_PUBLIC_KEY'));

        $profile = ['$email' => $email, '$first_name' => $first_name, '$message' => $message];
        $payload[] =  new KlaviyoProfile($profile);

        $client->lists->addMembersToList( 'Wp6Mup', $payload);

        return response()->json(['success' => 1, 'message' => 'sent!'],200);
    }


}