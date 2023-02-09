<?php
namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Mail;
use App\Models\MailReceiver;

use App\Models\Company;
use App\Models\PersonnelRequest;
use App\Models\PersonnelRequestRequiredPersonnel;
use App\Models\PersonnelRequiredTicket;
use App\Models\PersonnelDrugAndAlcoholTest;
use App\Models\PersonnelOperatorRequirement;
use App\Models\PersonnelDetails;
use App\Models\PersonnelDetailsCompetencies;
use App\Models\User;
use Auth;

use App\Jobs\QueueCreatePersonnelRequestEmail;

use Illuminate\Support\Str;

class PersonnelRequestController extends Controller
{

    public function search()
    {
        $keyword = request()->q;


        if (empty($keyword)) {
            $requests = PersonnelRequest::where('request_id','LIKE','%'.$keyword.'%')->orderBy('id','DESC')->orderBy('request_id','ASC')->take(3)->with('company')->get();
            $requests->push((object)['id' => 0, 'text' => 'None', 'request_id' => 'None']);
        } else {
            $requests = PersonnelRequest::where('request_id','LIKE','%'.$keyword.'%')->with('company')->get();
        }


        foreach ($requests as $request) {
            $request->text = $request->request_id;
        }



        return response()->json(['success' => 1, 'rows' => $requests], 200);
    }

    public function index() {

        // Ensure that only employer and admin can access
        $user = Auth::user();
        $keyword = request()->keyword;
        $show = request()->show;

        if($user->type !== 'Employer' && $user->type !== 'Admin' ) {
            return response()->json(['success' => 0, 'message' => 'Oops! Something went wrong..'],500);
        }

        if($user->type == 'Admin')
        {
            $requests = PersonnelRequest::with('company')->with('jobs')->orderBy('created_at','desc');

            if (!empty($keyword)) {
                $requests = $requests->where(function($query) use ($keyword) {
                    $query->where('request_id','like','%'.$keyword.'%')
                        ->orWhere('job_location','like','%'.$keyword.'%')
                        ->orWhere('site_location','like','%'.$keyword.'%');
                });
            }

            if (!empty($show) && $show == 'with-job') {
                $requests = $requests->has('jobs');
            }

            if (!empty($show) && $show == 'without-job') {
                $requests = $requests->doesnthave('jobs');
            }

            if (!empty($show) && $show == 'archive') {
                $requests = $requests->onlyTrashed();
            }



            /* pagination start */
            $count = $requests->count();
            $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
            $page = (is_numeric(request()->page)) ? request()->page : 1;
            $offset = (($page - 1 ) * $take);

            $requests = $requests->take($take);
            $requests = $requests->offset($offset);
            $requests = $requests->get();
            /* pagination end */


            foreach($requests as $request){
                $request->personnel = PersonnelRequestRequiredPersonnel::where('personnel_request_id', $request->id)
                ->with('requiredTicket')
                ->with('drugAndAlcoholTest')
                ->with('PersonnelDetails')
                ->with('operatorRequirement')->get();


                foreach($request->personnel as $key_personnel => $person){
                    
                    if(isset($request->personnel[$key_personnel])) { 
                        
                        foreach($request->personnel[$key_personnel]['PersonnelDetails'] as $key_details => $details){
                            
                            $skills = [];

                            if(isset($request->personnel[$key_personnel]['PersonnelDetails'][$key_details])) {
                               
                                $skills_query  = PersonnelDetailsCompetencies::select('job_type_id')
                                ->where('personnel_detail_id', '=', $request->personnel[$key_personnel]['PersonnelDetails'][$key_details]['id'])
                                ->Where('personnel_request_id','=',$request->id)->get()->makeHidden('attribute')->toArray();

                                foreach($skills_query as $skill){
                                    $skills[] = $skill['job_type_id'];
                                }

                                $details['skills'] = $skills;

                                $request->personnel[$key_personnel]['PersonnelDetails'][$key_details]['skills']= $details['skills'];
                                continue;
                                
                            }
                        }
                    }
                }

            }
        }
        else if($user->type == 'Employer')
        {
            $requests = PersonnelRequest::with('company')->with('jobs')->where('company_id','=',$user->company_id)->orderBy('created_at','desc');

            /* pagination start */
            $count = $requests->count();
            $take = (is_numeric(request()->take) && request()->take <= 300) ? request()->take : 20;
            $page = (is_numeric(request()->page)) ? request()->page : 1;
            $offset = (($page - 1 ) * $take);

            $requests = $requests->take($take);
            $requests = $requests->offset($offset);
            $requests = $requests->get();
            /* pagination end */

            foreach($requests as $request){
                $request->personnel = PersonnelRequestRequiredPersonnel::where('personnel_request_id','=',$request->id)
                ->with('requiredTicket')
                ->with('drugAndAlcoholTest')
                ->with('operatorRequirement')
                ->with('PersonnelDetails')
                ->get();

                foreach($request->personnel as $key_personnel => $person){
                    
                    if(isset($request->personnel[$key_personnel])) { 
                        
                        foreach($request->personnel[$key_personnel]['PersonnelDetails'] as $key_details => $details){
                            
                            $skills = [];

                            if(isset($request->personnel[$key_personnel]['PersonnelDetails'][$key_details])) {
                               
                                $skills_query  = PersonnelDetailsCompetencies::select('job_type_id')
                                ->where('personnel_detail_id', '=', $request->personnel[$key_personnel]['PersonnelDetails'][$key_details]['id'])
                                ->Where('personnel_request_id','=',$request->id)->get()->makeHidden('attribute')->toArray();

                                foreach($skills_query as $skill){
                                    $skills[] = $skill['job_type_id'];
                                }

                                $details['skills'] = $skills;

                                $request->personnel[$key_personnel]['PersonnelDetails'][$key_details]['skills']= $details['skills'];
                                continue;
                                
                            }
                        }
                    }
                }

            }
        }

        return response()->json(['success' => 1, 'data' => $requests, 'count' => $count],200);
    }

    public function show($id) 
    {
        $user = Auth::user();
        
        $request = PersonnelRequest::where('id','=',$id)->with('company')->with('jobs')->first();
        $request->personnel = PersonnelRequestRequiredPersonnel::where('personnel_request_id','=',$id)
                ->with('requiredTicket')
                ->with('drugAndAlcoholTest')
                ->with('operatorRequirement')
                ->with('PersonnelDetails')
                ->get();

        foreach($request->personnel as $key_personnel => $person){
            
            if(isset($request->personnel[$key_personnel])) { 
                
                foreach($request->personnel[$key_personnel]['PersonnelDetails'] as $key_details => $details){
                    
                    $skills = [];

                    if(isset($request->personnel[$key_personnel]['PersonnelDetails'][$key_details])) {
                        
                        $skills_query  = PersonnelDetailsCompetencies::select('job_type_id')
                        ->where('personnel_detail_id', '=', $request->personnel[$key_personnel]['PersonnelDetails'][$key_details]['id'])
                        ->Where('personnel_request_id','=',$request->id)->get()->makeHidden('attribute')->toArray();

                        foreach($skills_query as $skill){
                            $skills[] = $skill['job_type_id'];
                        }

                        $details['skills'] = $skills;

                        $request->personnel[$key_personnel]['PersonnelDetails'][$key_details]['skills']= $details['skills'];
                        continue;
                        
                    }
                }
            }
        }

        return response()->json(['success' => 1, 'data' => $request],200);
    }

    public function sendRequest()
    {
        $recipients = request()->recipients;
        $recipients = (is_array($recipients)) ? $recipients : [];

        // send email to ADMIN and Candidate (employer accepted the job recommendation)
        QueueCreatePersonnelRequestEmail::dispatch($recipients);

        return response()->json(['success' => 1, 'message' => "'Request' message sent successfully"], 200);
    }


    public function store() {
        # Ensure that only employer and admin can save
        $user = Auth::user();

        if($user->type !== 'Employer' && $user->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops! Something went wrong..'],500);
        }

        $company = Company::find(request()->company_id);

        if (!$company) {
            return response()->json(['success' => 0, 'message' => 'Please select a company.'], 500);
        }


        $po_date = date('Ymd');
        $po_slug = Str::slug($company->name, "-");
        $po_slug = strtoupper($po_slug);

        $count = PersonnelRequest::where('company_id','=',request()->company_id)->where('created_at','>=',date('Y-m-d 00:00:00'))->where('created_at','<=',date('Y-m-d 23:59:59'))->count();
        $count++;

        $po_seq = sprintf('%03d',$count);

        $request_id = $po_date.'-'.$po_slug.'-'.$po_seq;

        # new personnel request
        $request = new PersonnelRequest();
        $request->company_id = request()->company_id;
        $request->date = request()->date;
        $request->request_id = $request_id;
        $request->job_location = request()->job_location;
        $request->site_location = request()->site_location;
        $request->estimated_start_date = request()->estimated_start_date;
        $request->estimated_end_date = request()->estimated_end_date;
        $request->save();

        foreach(request()->personnel as $person)
        {
            if(!isset($person['type'])) { continue; }
            $this->storeData($request, $person);
        }

        $personnel_request = array();
        // $personnel_request[] = $request;
        // $personnel_request[] = $required_personnel;
        // $personnel_request[] = $required_ticket;
        // $personnel_request[] = $drug_and_alcohol_test;
        // if(isset($personnel_operator)) {
        //     $personnel_request[] = $personnel_operator;
        // }

        return response()->json(['success' => 1, 'data' => $personnel_request, 'message' => 'Request Added!'], 200);
    }

    public function update($request_id) {

        // Ensure that only employer can save
        $user = Auth::user();
        if($user->type !== 'Employer' && $user->type !== 'Admin') {
            return response()->json(['success' => 0, 'message' => 'Oops! Something went wrong..'],500);
        }


        # update personnel request
        $request = PersonnelRequest::find($request_id);
        $request->id = $request_id;
        $request->company_id = request()->company_id;
        $request->date = request()->date;
        $request->job_location = request()->job_location;
        $request->site_location = request()->site_location;
        $request->estimated_start_date = request()->estimated_start_date;
        $request->estimated_end_date = request()->estimated_end_date;
        $request->save();


        foreach(request()->personnel as $person)
        {
            if(!isset($person['type'])) { continue; }

            $this->storeData($request, $person);

            $personnel_request = array();

        }

        return response()->json(['success' => 1, 'data' => $personnel_request, 'message' => 'Request Updated!'], 200);
    }

    public function delete($request_id) {
        // ensures if the type id exist
        $request = PersonnelRequest::find($request_id);
        //$required_personnel = PersonnelRequestRequiredPersonnel::where('personnel_request_id','=',$request_id)->first();
        //$required_ticket = PersonnelRequestRequiredTicket::where('personnel_request_id','=',$request_id)->first();
        //$drug_and_alcohol_test = PersonnelRequestDrugAndAlcoholTest::where('personnel_request_id','=',$request_id)->first();

        if (!$request) {
            return response()->json(['success' => 0, 'message' => 'Could not find request!'], 500);
        }

        $request->delete();
        //$required_personnel->delete();
        //$required_ticket->delete();
        //$drug_and_alcohol_test->delete();

        return response()->json(['success' => 1, 'message' => 'Successfully removed.'], 200);
    }

    public function restore($request_id) {
        // ensures if the type id exist
        $request = PersonnelRequest::withTrashed()->find($request_id);

        //$required_personnel = PersonnelRequestRequiredPersonnel::where('personnel_request_id','=',$request_id)->first();
        //$required_ticket = PersonnelRequestRequiredTicket::where('personnel_request_id','=',$request_id)->first();
        //$drug_and_alcohol_test = PersonnelRequestDrugAndAlcoholTest::where('personnel_request_id','=',$request_id)->first();

        if (!$request) {
            return response()->json(['success' => 0, 'message' => 'Could not find request!'], 500);
        }

        $request->restore();
        //$required_personnel->delete();
        //$required_ticket->delete();
        //$drug_and_alcohol_test->delete();

        return response()->json(['success' => 1, 'message' => 'Successfully Restored.'], 200);
    }


    public function upload(Request $request)
    {
        $file = $request->file('file');
        $ext = $file->extension();
        $original_name = $file->getClientOriginalName();
        $size = $file->getSize();

        $personnel_request_id = request()->personnel_request_id;
        $personnel_type = request()->type;

        if ($ext != 'pdf' && $ext != 'doc' && $ext != 'docx' && $ext != 'txt') {
            return response()->json(['success' => 0, 'message' => 'You have choosen an invalid file "'.$ext.'", please use the following: .doc, .docx, .pdf, .txt'],500);
        }

        $user = Auth::user();

        $name = 'personnel-request-'.$user->id.'-'.time();
        $name = $name.'.'.$ext;

        $new = new UserFile;
        $new->user_id = $user->id;
        $new->type = 'personnel-requests';
        $new->name = $name;
        $new->original_name = $original_name;
        $new->size = $size;
        $new->save();

        $path = 'personnel-requests';
        $file->storeAs($path, $name,['disk' => 'public']);

        $peronnel_required = PersonnelRequestRequiredPersonnel::where('personnel_request_id','=',$personnel_request_id)->where('type','=',$type)->first();
        $peronnel_required = (!$peronnel_required) ? new PersonnelRequestRequiredPersonnel : $peronnel_required;

        $peronnel_required->file_id = $new->id;
        $peronnel_required->save();

        return response()->json(['success' => 1, 'message' => 'Personnel Request File has been successfully uploaded', 'data' => $new, 'url' => asset('storage/'.$path.'/'.$name)],200);
    }

    public function storeData($request, $person)
    {
        # new required personnel
        $required_personnel = new PersonnelRequestRequiredPersonnel();
        if (isset($person['id'])) {
            $required_personnel = PersonnelRequestRequiredPersonnel::where('personnel_request_id','=',$request->id)->where('id', '=', $person['id'])->first();
        }
        $required_personnel->personnel_request_id = $request->id;
        $required_personnel->type = $person['type'];
        $required_personnel->scope_of_work = $person['scope_of_work'];
        $required_personnel->shift_duration = $person['shift_duration'];
        $required_personnel->percentage_of_people_on_day_shift = $person['percentage_of_people_on_day_shift'];
        $required_personnel->hours_of_orientation_on_site = $person['hours_of_orientation_on_site'];
        $required_personnel->hours_of_orientation_online = $person['hours_of_orientation_online'];
        $required_personnel->accomodation = $person['accomodation'];
        $required_personnel->pre_employments = $person['pre_employments'];
        $required_personnel->work_conditions = $person['work_conditions'];
        $required_personnel->specialized_PPE = $person['specialized_PPE'];
        $required_personnel->save();

        # new personnel operator requirement (for 'operator' personnel types only)
        if($person['type'] === 'operators')
        {
            $personnel_operator = new PersonnelOperatorRequirement();
            if (isset($person['id'])) {
                $personnel_operator = PersonnelOperatorRequirement::where('required_personnel_id','=', $required_personnel->id)->first();
            }
            $personnel_operator->required_personnel_id = $required_personnel->id;
            $personnel_operator->license_class =  $person['operator_requirement']['license_class'];
            $personnel_operator->driver_abstract = $person['operator_requirement']['driver_abstract'];
            $personnel_operator->demerit_points_acceptable = $person['operator_requirement']['demerit_points_acceptable'];
            $personnel_operator->driver_requirements = json_encode($person['operator_requirement']['driver_requirements']);
            $personnel_operator->hours_of_service = $person['operator_requirement']['hours_of_service'];
            $personnel_operator->is_off_road_needed = $person['operator_requirement']['is_off_road_needed'];
            $personnel_operator->is_chain_up_needed = $person['operator_requirement']['is_chain_up_needed'];
            $personnel_operator->mountain_experience = $person['operator_requirement']['mountain_experience'];
            $personnel_operator->radio_calling_experience = $person['operator_requirement']['radio_calling_experience'];
            $personnel_operator->dispatch_apps_for_smartphone_required = $person['operator_requirement']['dispatch_apps_for_smartphone_required'];
            $personnel_operator->transmission_type = json_encode($person['operator_requirement']['transmission_type']);
            $personnel_operator->save();
        }

        # new personnel required tickets
        $required_ticket = new PersonnelRequiredTicket();
        if (isset($person['id'])) {
            $required_ticket = PersonnelRequiredTicket::where('required_personnel_id', '=', $required_personnel->id)->first();
        }
        $required_ticket->required_personnel_id = $required_personnel->id;
        $required_ticket->first_aid = $person['required_ticket']['first_aid'];
        $required_ticket->H2S_alive = $person['required_ticket']['H2S_alive'];
        $required_ticket->CSTS = $person['required_ticket']['CSTS'];
        $required_ticket->confined_space = $person['required_ticket']['confined_space'];
        $required_ticket->ground_disturbance = $person['required_ticket']['ground_disturbance'];
        $required_ticket->fall_arrest = $person['required_ticket']['fall_arrest'];
        $required_ticket->CSO = $person['required_ticket']['CSO'];
        // $required_ticket->other = $person['required_ticket']['other_ticket'];
        $required_ticket->whmis = $person['required_ticket']['whmis'];
        $required_ticket->save();

        #new personnel request details
        $x=0;



        foreach($person['personnel_details'] as $key_details => $details)
        {
            // var_dump($person['personnel_details']);
            // die();

            if (!isset($details['id'])) {
                $personnel_request_personnel_details = new PersonnelDetails();
                $personnel_request_personnel_details->required_personnel_id = $required_personnel->id;
                $personnel_request_personnel_details->job_title = $details['job_title'];
                $personnel_request_personnel_details->job_description = $details['job_description'];
                $personnel_request_personnel_details->quantity = $details['quantity'];
                $personnel_request_personnel_details->save();


                foreach($person['personnel_details'][$x]['skills'] as $skill){

                    $personnel_details_competencies = new PersonnelDetailsCompetencies();
                    $personnel_details_competencies->personnel_request_id = $request->id;
                    $personnel_details_competencies->personnel_detail_id = $personnel_request_personnel_details->id;
                    $personnel_details_competencies->job_type_id = $skill;
                    $personnel_details_competencies->save();
                }

                $x++;
                continue;
            }

            $personnel_request_personnel_details = PersonnelDetails::where('required_personnel_id', '=', $required_personnel->id)
                ->where('id', '=', $details['id'])
                ->first();
            $personnel_request_personnel_details->job_title = $details['job_title'];
            $personnel_request_personnel_details->job_description = $details['job_description'];
            $personnel_request_personnel_details->quantity = $details['quantity'];
            $personnel_request_personnel_details->save();


            // DELETE and ADD again need to refactor
            //$competencies = PersonnelDetailsCompetencies::where('personnel_detail_id', '=' , $details['id'])->delete();
           

            if (isset($person['personnel_details'][$key_details]['skills'])) {

                PersonnelDetailsCompetencies::where('personnel_detail_id','=',$details['id'])->whereNotIn('job_type_id',$person['personnel_details'][$key_details]['skills'])->delete();
                
                foreach($person['personnel_details'][$key_details]['skills'] as $skill){

                        $result = PersonnelDetailsCompetencies::where('personnel_detail_id', '=' , $details['id'])->where('job_type_id','=', $skill)->first();

                        // var_dump($result);
                        // die();
                        if ($result === null){
                            $personnel_details_competeny = new PersonnelDetailsCompetencies();
                            $personnel_details_competeny->personnel_request_id = $request->id;
                            $personnel_details_competeny->personnel_detail_id = $personnel_request_personnel_details->id;
                            $personnel_details_competeny->job_type_id = $skill;
                            $personnel_details_competeny->save();
                        }

                }
            }

            

        }


        # new personnel drug and alcohol test
        $drug_and_alcohol_test = new PersonnelDrugAndAlcoholTest();
        if (isset($person['id'])) {
            $drug_and_alcohol_test = PersonnelDrugAndAlcoholTest::where('required_personnel_id', '=', $required_personnel->id)->first();
        }
        $drug_and_alcohol_test->required_personnel_id = $required_personnel->id;
        $drug_and_alcohol_test->test = $person['drug_and_alcohol_test']['test'];
        $drug_and_alcohol_test->is_cannabis_swap_acceptable = $person['drug_and_alcohol_test']['is_cannabis_swap_acceptable'];
        $drug_and_alcohol_test->how_recent = $person['drug_and_alcohol_test']['how_recent'];
        $drug_and_alcohol_test->mask_fit_requirements = $person['drug_and_alcohol_test']['mask_fit_requirements'];
        $drug_and_alcohol_test->can_lift_more_than_sixty_pounds = $person['drug_and_alcohol_test']['can_lift_more_than_sixty_pounds'];
        $drug_and_alcohol_test->save();
    }

}