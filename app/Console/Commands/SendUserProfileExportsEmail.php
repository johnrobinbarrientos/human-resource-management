<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;


use App\Models\User; 
use App\Models\UserFile; 
use App\Models\UserResume; 
use App\Models\UserSkill; 
use App\Models\UserTicket; 

use App\Models\UserProfileExport; 
use App\Models\UserProfileExportItem; 


use App\Models\JobSubcategory; 
use App\Models\JobSubcategoryItem;

use Mail;
use App\Mail\SendMail;

use Illuminate\Support\Facades\Auth; 
use Illuminate\Support\Facades\Storage; 
use Illuminate\Support\Str;

use Spipu\Html2Pdf\Html2Pdf;


class SendUserProfileExportsEmail extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'mail:user-profile-exports';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'This command will send email containing the file';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $job_subcategories = JobSubcategory::all();
        $exports = UserProfileExport::where('status','=','pending')->get();
        
        foreach ($exports as $export) {
            $items = UserProfileExportItem::where('user_profile_export_id','=',$export->id)->get();
            $export->status = 'processing';
            $export->save();

            $exporter = User::find($export->user_id);

            Storage::disk('public')->makeDirectory('zips/'.$export->uuid);

            foreach ($items as $item) {
                $job_subcategories = JobSubcategory::all();

                $user = User::find($item->user_id);

                if (!$user) {
                    continue;
                }

                $html2pdf = new Html2Pdf();

                $skills = UserSkill::where('user_id','=',$user->id)->with('JobSubcategoryItem.jobType')->get();
                
                $job_subcategory_skills = [];
                foreach ($job_subcategories as $job_subcategory) {
                    $job_subcategory_skills[$job_subcategory->name] = [];

                    foreach ($skills as $skill) {
                        if ($job_subcategory->id == $skill->JobSubcategoryItem->job_subcategory_id) {
                            $job_subcategory_skills[$job_subcategory->name][] = $skill->JobSubcategoryItem->jobType->name;
                        }
                    }

                }

                $view = view('exports.resume');
                $view->user = $user;
                $view->job_subcategory_skills = $job_subcategory_skills;
                
                $folder = $user->first_name.'-'.$user->last_name;
                $folder = Str::slug($folder,'-');

            
                
                Storage::disk('public')->makeDirectory('zips/'.$export->uuid.'/'.$folder);

                $html2pdf->writeHTML($view);
                $html2pdf->output(storage_path('app/public/zips/'.$export->uuid.'/'.$folder.'/profile.pdf'),'F');

                $files = UserFile::where('user_id','=',$user->id)->get();

                foreach ($files as $file) {

                    if ($file->type == 'ticket') {
                        
                        if (file_exists(storage_path('app/public/tickets/'.$file->name))) {
                            $this->info('packing '.$file->name.'...');
                            copy(storage_path('app/public/tickets/'.$file->name), storage_path('app/public/zips/'.$export->uuid.'/'.$folder.'/'.$file->name));
                        }
                        
                    } else if ($file->type == 'resume') {
                        
                        if (file_exists(storage_path('app/public/resumes/'.$file->name))) {
                            $this->info('packing '.$file->name.'...');
                            copy(storage_path('app/public/resumes/'.$file->name), storage_path('app/public/zips/'.$export->uuid.'/'.$folder.'/'.$file->name));
                        }
                    }
                        
                }

                // only execute on linux
                if (strtoupper(substr(PHP_OS, 0, 3)) !== 'WIN') {
                    exec('cd '.storage_path('app/public/zips').' && zip -r '.$export->uuid.'.zip "'.$export->uuid.'"');
                }

                $this->info($user->first_name.'\'s profile is ready for be exported...');
            }


            $data = [ 'APP_URL' => getenv("APP_URL"), 'subject' => 'Exported User Profiles',  'user' => $user, 'export' => $export, 'template' => 'user-profile-export'];
            Mail::to($exporter->email)->queue(new SendMail($data));

            $export->status = 'completed';
            $export->save();


        }
    }

    // compress all files in the source directory to destination directory 
    static private function create_zip($files = array(), $dest = '', $overwrite = false) {
        if (file_exists($dest) && !$overwrite) {
            return false;
        }
        if (($files)) {
            $zip = new ZipArchive();
            if ($zip->open($dest, $overwrite ? ZIPARCHIVE::OVERWRITE : ZIPARCHIVE::CREATE) !== true) {
                return false;
            }
            foreach ($files as $file) {
                $zip->addFile($file, $file);
            }
            $zip->close();
            return file_exists($dest);
        } else {
            return false;
        }
    }
    
    static private function addzip($source, $destination) {
        $files_to_zip = glob($source . '/*');
        create_zip($files_to_zip, $destination);
        echo "done";
    }
}
