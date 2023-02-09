<template>
<div>
    <div v-if="page_status == 404">
        <Page404></Page404>
    </div>
    <div v-else class="row">
        <div class="col-lg-12" :class="{ 'col-lg-12': fullscreen, 'col-lg-8': !fullscreen, 'col-lg-12' : auth.type == 'Candidate' }">
            <div style="border:3px solid #efefef;" class="card">
            <div class="card-body">
                <div style="padding:10px 0px; text-align:center;">
                    
                    <img id="avatar-preview" @click="browseFile('#avatar-browser')" :src="avatar" v-bind:class="{'editable' : editable }">
                    <input @change="previewFile()" style="position:fixed; top:-100px; left:-100px; opacity:0;" id="avatar-browser" type="file">

                    <h4 style="margin-top:10px;">{{ user.first_name }} {{ user.last_name }}</h4>
                    <span v-if="user.company && user.company.id" class="badge badge-success mb-3" style="font-size: 13px; font-weight: bold">Hired By: {{ user.company.name }}</span>
                </div>

                <AdminOptions v-if="show_adminOptions" :properties="{ candidate_id: user_id }"></AdminOptions>
                
               
                <div class="prim-tab-header">
                    <div @click="changeTab('personal-information')" :class="{'active': tab == 'personal-information'}" class="prim-tab-button">Personal Information</div>
                    <div @click="changeTab('resume')" :class="{'active': tab == 'resume'}" class="prim-tab-button">Resume</div>
                    <div @click="changeTab('attachements')" :class="{'active': tab == 'attachements'}" class="prim-tab-button">Attachments</div>
                    <div @click="changeTab('core-competencies')" :class="{'active': tab == 'core-competencies'}" class="prim-tab-button">Core Competencies</div>
                    <div @click="changeTab('ratings')" :class="{'active': tab == 'ratings'}" class="prim-tab-button">Ratings</div>
                </div>
                <div class="prim-tab-content">

                    <div v-show="tab == 'personal-information'" class="prim-tab-content">
                        <div  v-if="inline_group_response == 'success'" class="alert alert-success">
                            <strong>Success!</strong> User details has been successfully updated...
                        </div>
                        <div  v-if="inline_group_response == 'error'"  class="alert alert-danger">
                            <strong>Error!</strong> 
                            <span v-if="inline_group_response_message != ''">{{ inline_group_response_message }}</span>
                            <span v-else>An error occur while updating...</span>
                        </div>

                        <div class="table-responsive">
                            <table class="table-nowrap mb-0 table" v-bind:class="{' table-hover' : editable}">
                                <tbody>
                                <tr>
                                    <th width="140" scope="row">Full Name :</th>
                                    <td class="inline-edit" v-bind:class="{'editing' : inline_groups.fullname.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('fullname', inline_groups.fullname)" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-if="!inline_groups.fullname.editing">{{ user.first_name }} {{ user.last_name }}</span>
                                        <div v-else>
                                            <input class="form-control" type="text" v-model="inline_groups.fullname.data.first_name">
                                            <input class="form-control" type="text" v-model="inline_groups.fullname.data.last_name">
                                            <div class="actions">
                                                <button @click="saveInline('fullname',inline_groups.fullname)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                                <button @click="toggleInlineEdit('fullname',inline_groups.fullname)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="140" scope="row">Mobile :</th>
                                    <td class="inline-edit" v-bind:class="{'editing' : inline_groups.phone.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('phone', inline_groups.phone);" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-if="!inline_groups.phone.editing">{{ user.phone }}</span>
                                        <div v-else>
                                            <vue-phone-number-input ref="ref_phone" v-model="inline_groups.phone.data.phone" default-country-code="CA" :only-countries="['CA', 'US']"/>
                                            <div class="actions">
                                                <button @click="saveInline('phone',inline_groups.phone)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                                <button @click="toggleInlineEdit('phone',inline_groups.phone)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="140" scope="row">Email Address :</th>
                                    <td class="inline-edit" v-bind:class="{'editing' : inline_groups.email.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('email', inline_groups.email)" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-if="!inline_groups.email.editing">{{ user.email }}</span>
                                        <div v-else>
                                            <div style="margin-top:3px; margin-bottom:3px; font-size:12px; line-height:12px; white-space:normal;">
                                                If you change this, we will send you an email at your new address to confirm it. The new address will not become active until confirmed.
                                            </div>

                                            <input class="form-control" type="text" v-model="inline_groups.email.data.email" :disabled="inline_groups.email.data.new_email != ''">
                                            <div v-if="inline_groups.email.data.new_email && inline_groups.email.data.new_email != ''" style="background:#efefef; padding:3px 5px; border-left:3px solid green; font-size:12px; line-height:12px;  white-space:normal;">
                                                There is a pending change of your email to <strong>{{ inline_groups.email.data.new_email }}</strong>
                                            </div>

                                            <div class="actions">
                                                <button @click="saveInline('email',inline_groups.email)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                                <button @click="toggleInlineEdit('email',inline_groups.email)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                            </div>
                                        </div>
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <th width="140" scope="row">Available to Work:</th>

                                    <td class="inline-edit" v-bind:class="{'editing' : inline_groups.available_to_work.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('available_to_work', inline_groups.available_to_work)" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-if="!inline_groups.available_to_work.editing">
                                            <span v-if="user.is_available==1">Yes</span>
                                            <span v-else>No</span>
                                        </span>
                                        <div v-else>
                                            <input type="radio" value="1" v-model="inline_groups.available_to_work.data.is_available"> Yes
                                            <input type="radio" value="0" v-model="inline_groups.available_to_work.data.is_available"> No
                                            <div class="actions">
                                                <button @click="saveInline('available_to_work',inline_groups.available_to_work)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                                <button @click="toggleInlineEdit('available_to_work',inline_groups.available_to_work)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="140" scope="row">Do you have a personal vehicle:</th>

                                    <td class="inline-edit" v-bind:class="{'editing' : inline_groups.personal_vehicle.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('personal_vehicle', inline_groups.personal_vehicle)" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-if="!inline_groups.personal_vehicle.editing">
                                            <span v-if="user.is_personal_vehicle_available==1">Yes</span>
                                            <span v-else>No</span>
                                        </span>
                                        <div v-else>
                                            <input type="radio" value="1" v-model="inline_groups.personal_vehicle.data.is_personal_vehicle_available"> Yes
                                            <input type="radio" value="0" v-model="inline_groups.personal_vehicle.data.is_personal_vehicle_available"> No
                                            <div class="actions">
                                                <button @click="saveInline('personal_vehicle',inline_groups.personal_vehicle)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                                <button @click="toggleInlineEdit('personal_vehicle',inline_groups.personal_vehicle)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="140" scope="row">Date of Birth :</th>
                                    <td class="inline-edit" v-bind:class="{'editing' : inline_groups.date_of_birth.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('date_of_birth', inline_groups.date_of_birth)" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-if="!inline_groups.date_of_birth.editing">{{ user.date_of_birth }}</span>
                                        <div v-else>
                                            <input class="form-control" type="date" v-model="inline_groups.date_of_birth.data.date_of_birth">
                                            <div class="actions">
                                                <button @click="saveInline('date_of_birth',inline_groups.date_of_birth)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                                <button @click="toggleInlineEdit('date_of_birth',inline_groups.date_of_birth)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="140" scope="row">Date Available :</th>
                                    <td class="inline-edit" v-bind:class="{'editing' : inline_groups.date_available.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('date_available', inline_groups.date_available)" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-if="!inline_groups.date_available.editing">{{ user.date_available }}</span>
                                        <div v-else>
                                            <input class="form-control" type="date" v-model="inline_groups.date_available.data.date_available">
                                            <div class="actions">
                                                <button @click="saveInline('date_available',inline_groups.date_available)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                                <button @click="toggleInlineEdit('date_available',inline_groups.date_available)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="140" scope="row">Which city do you live in? :</th>
                                    <td class="inline-edit" v-bind:class="{'editing' : inline_groups.location.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('location', inline_groups.location)" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-if="!inline_groups.location.editing">{{ user.location }}</span>
                                        <div v-else>
                                            <input class="form-control" type="text" v-model="inline_groups.location.data.location">
                                            <div class="actions">
                                                <button @click="saveInline('location',inline_groups.location)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                                <button @click="toggleInlineEdit('location',inline_groups.location)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th style="vertical-align: top;" width="140" scope="row">Tell me something about yourself :</th>
                                    <td style="white-space: normal;" class="inline-edit" v-bind:class="{'editing' : inline_groups.content.editing}">
                                        <div v-if="editable" @click="toggleInlineEdit('content', inline_groups.content)" class="icon-pencil"><i class="bx bx-pencil"></i></div>

                                        <span v-show="!inline_groups.content.editing">{{ user.content }}</span>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <div v-show="inline_groups.content.editing">
                                <textarea id="summernote22" class="form-control" v-model="inline_groups.content.data.content" placeholder="Please share everything about yourself here"></textarea>
                                
                                <div style="padding-top:10px; text-align:right;" class="actions">
                                    <button @click="saveInline('content',inline_groups.content)" class="btn btn-primary btn-sm waves-effect waves-light" role="button">Save</button>
                                    <button @click="toggleInlineEdit('content',inline_groups.content)" class="btn btn-light btn-sm waves-effect waves-light" role="button">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-show="tab == 'resume'" class="prim-tab-content">
                        <div  v-if="upload_resume_response == 'success'" class="alert alert-success">
                            <strong>Success!</strong> Resume has been successfully uploaded
                        </div>
                        <div  v-if="upload_resume_response == 'error'" class="alert alert-danger">
                            <strong>Error!</strong> 
                            <span v-if="upload_resume_response_message != ''">{{ upload_resume_response_message }}</span>
                            <span v-else>An error occur while updating...</span>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="table table-nowrap table-centered table-hover mb-0 table">
                                <tbody>
                                <tr>
                                    <td style="width: 45px;">
                                        <div class="avatar-sm"><span class="avatar-title rounded-circle bg-soft-primary font-size-24"><i class="bx bxs-file-doc"></i></span></div>
                                    </td>
                                    <td>
                                        <div v-if="file_resume" @click="browseFile('#file-resume-browser')">
                                            <h5 class="font-size-14 mb-1"><a class="text-dark" href="javascript:void(0);">
                                                Resume: {{ file_resume.original_name }}</a>
                                                <input @change="startUploadResume()" style="position:fixed; top:-100px; left:-100px; opacity:0;" id="file-resume-browser" type="file">
                                            </h5>
                                            <small>{{ humanFileSize(file_resume.size) }}</small>
                                        </div>
                                        <div v-if="!file_resume" @click="browseFile('#file-resume-browser')">
                                            <div v-if="auth.type !== 'Employer'">
                                                <h5 class="font-size-14 mb-1">
                                                    <a class="text-dark" href="javascript:void(0);">Attach your Resume (Optional)</a>
                                                    <input @change="startUploadResume()" style="position:fixed; top:-100px; left:-100px; opacity:0;" id="file-resume-browser" type="file">
                                                </h5>
                                                <small>Click to Upload</small>
                                            </div>
                                            <div v-else>
                                                No Resume Added Yet.
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div v-if="file_resume" class="text-right">
                                            <a  class="text-dark" :href="'/api/files/' + file_resume.id + '/download'" target="_blank"><i class="bx bx-download h3 m-0"></i></a>
                                            &nbsp;
                                            <a v-if="auth.type !== 'Employer'" @click="deleteResumeFile(file_resume.id)" class="text-dark" href="javascript:void(0)"><i class="bx bx-x h3 m-0"></i></a>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div v-show="tab == 'attachements'" class="prim-tab-content">
                        <!-- <button type="button" @click="showrecord(auth.type)">click me</button> -->
                        <div class="row">
                            <div class="col-sm-12 col-lg-6 offset-lg-6">
                                    <div style="text-align:right;">
                                    <div style="display:inline-block; background:#f58220; padding:2px 10px; padding-bottom:5px; margin-bottom:10px; color:#fff; cursor:pointer; border-radius:3px;" v-if="editable"  @click="browseFile('#file-tickets-browser')">
                                        <h5 class="font-size-14 mb-1">
                                            <input @change="browseTickets()" style="position:fixed; top:-100px; left:-100px; opacity:0;" id="file-tickets-browser" type="file" name="files[]" multiple="multiple">
                                        </h5>
                                        <small>Upload a Ticket</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                
                                <div class="file-tickets-temp-wrapper">
                                    

                                    <div class="file-ticket-temp-single" v-for="file_ticket_temp,index in file_tickets_temp" :key="index">
                                        <div class="remove" @click="removeTempTicket(file_ticket_temp.uuid)" v-if="file_ticket_temp.status == 'default' || file_ticket_temp.status == 'error'">
                                            <i class="bx bx-trash"></i>
                                        </div>

                                        <div v-if="file_ticket_temp.status == 'success'" class="alert alert-success">
                                            <span v-if="file_ticket_temp.message != ''">{{ file_ticket_temp.message }}</span>
                                            <span v-else>Upload Complete!</span>
                                        </div>
                                        <div v-if="file_ticket_temp.status == 'error'" class="alert alert-danger">
                                            <span v-if="file_ticket_temp.message != ''">{{ file_ticket_temp.message }}</span>
                                            <span v-else>Upload Complete!</span>
                                        </div>
                                        
                                        <div class="file-name" style="">
                                            File Name: {{ file_ticket_temp.file.name }} {{ file_ticket_temp.status }}
                                        </div>

                                        <div class="inputs">
                                            <div class="file-size" style="">
                                                <span>File Size</span>
                                                <div class="file-size-value">{{ humanFileSize(file_ticket_temp.size) }}</div>
                                            </div>
                                            <div class="ticket-type">
                                                <span>Ticket Type</span>
                                                <select v-model="file_ticket_temp.ticket_type" class="ticket-type-input">
                                                    <option value="">Ticket Type</option>
                                                    <option value="First Aid">First Aid</option>
                                                    <option value="H2S Alive">H2S Alive</option>
                                                    <option value="CSTS">CSTS</option>
                                                    <option value="Confined Space">Confined Space</option>
                                                    <option value="Ground Disturbance">Ground Disturbance</option>
                                                    <option value="Fall Arrest/Protection">Fall Arrest/Protection</option>
                                                    <option value="CSO">CSO</option>
                                                    <option value="WHMIS">WHMIS</option>
                                                    <option value="Driver’s License">Driver’s License</option>
                                                    <option value="Driver’s Abstract">Driver’s Abstract</option>
                                                    <option value="Wildlife Awareness/Bear Awareness">Wildlife Awareness/Bear Awareness</option>
                                                    <option value="APR/RPE">APR/RPE</option>
                                                </select>
                                            </div>
                                            <div class="expiry-date" style="padding:5px;">
                                                <span>Expiry Date</span>
                                                <input v-model="file_ticket_temp.expiry_date" class="expiry-date-input form-control" type="date">
                                            </div>
                                            
                                        </div>

                                        <div v-if="file_ticket_temp.status == 'uploading'" style="margin-top:5px; display:block !important;" class="file-tickets-progress">
                                            <div class="file-tickets-progress-percentage" v-bind:style="{'width' : file_ticket_temp.progress + '%'}"></div>
                                        </div>

                                        
                                        
                                    </div>

                                    <div v-if="file_tickets_temp && file_tickets_temp.length > 0" style="padding:5px;">
                                        <button @click="startUploadTickets()" type="button" class="btn btn-block btn-primary">Start Upload</button>
                                    </div>
                                    
        
                                </div>

                                <div class="table-responsive"  v-if="file_tickets &&  file_tickets.length > 0">
                                    
                                    <table class="table table-nowrap table-centered table-hover mb-0 table">
                                        <tbody>
                                            <tr v-for="(file,type) in file_tickets" :key="'file-' + file.id">
                                                <td style="width: 45px;">
                                                    <div class="avatar-sm"><span class="avatar-title rounded-circle bg-soft-primary font-size-24"><i class="bx bxs-file-doc"></i></span></div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <h5 class="font-size-14 mb-1"><a class="text-dark" href="javascript:void(0);">
                                                            Ticket: {{ file.original_name }}</a>
                                                        </h5>
                                                        <small>{{ humanFileSize(file.size) }}</small>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div  class="text-right">
                                                        <a class="text-dark" :href="'/api/files/' + file.id + '/download'" target="_blank"><i class="bx bx-download h3 m-0"></i></a>
                                                        &nbsp;
                                                        <a v-if="auth.type != 'Employer'" @click="deleteTicketFile(file.id,type)" class="text-dark" href="javascript:void(0)"><i class="bx bx-x h3 m-0"></i></a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div v-else style="border:1px solod #efefef; background:#fafafa; text-align:center; padding:40px 10px;">
                                    No Tickets has been uploaded yet.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-show="tab == 'core-competencies'" class="prim-tab-content">

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="alert alert-info"> 
                                    Please select all that apply.
                                </div>
                                
                
                                <div id="accordion">
                                    <div v-if="skills.status != 'default'" v-bind:class="{'alert-success' : skills.status == 'success', 'alert-danger' : skills.status == 'error'}" class="alert">
                                        {{ skills.status_message }}
                                    </div>

                                    <div class="core-competencies">
                                        <template v-for="(subcategory, index) in subcategories" >
                                        
                                            <div :key="'collapse-' + index" class="core-competencies-single" v-bind:class="{'open': core_competencies_open ==  subcategory.name}">
                                                <div @click="openCoreCompetencieGroup(subcategory.name)" class="core-competencies-button">
                                                    {{ subcategory.name }}
                                                    <i class="mdi mdi-arrow-up-drop-circle"></i>
                                                    <i class="mdi mdi-arrow-down-drop-circle"></i>
                                                </div>

                                                <div class="core-competencies-options">
                                                    <div class="row">
                                                        <div v-for="(type, index) in subcategory.job_types" :key="'type-' + index"  class="col-12 col-sm-6 col-md-4 col-lg-3">
                                                            <div class="form-check mb-3">
                                                                <input
                                                                    @click="toggleSkill(type.id)"
                                                                    class="form-check-input"
                                                                    type="checkbox" value=""
                                                                    :id="'type-' + index"
                                                                    :checked="isSkillSelected(type.id)"
                                                                    :disabled="editable == 0"
                                                                >
                                                                <label class="form-check-label" :for="'type-' + index">
                                                                    {{ type.job_type.name }}
                                                                </label>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </template>
                                    </div>

                                
                                    <br/>
                                    <div class="text-center">
                                        <button @click="saveSkills()" class="waves-effect waves-light btn btn-primary">Save Changes</button>
                                    </div>
                                </div>
                        
                            </div>
                        </div>
                    </div>
                    <div v-show="tab == 'ratings'" class="prim-tab-content">
                        <RatingsList :properties="{ user_id: user_id }" :key="'ratings-' + user_id"></RatingsList>
                    </div>
                </div>

              
            </div>
            </div>
        </div>
    </div>
</div>
</template>


<style>
.inline-edit { position:relative; cursor:pointer; }
.inline-edit .form-control {margin-bottom:5px; }
.inline-edit .icon-pencil { display:none; position:absolute; top:0px; right:10px; font-size:18px; }
.inline-edit:hover:not(.editing) .icon-pencil { display:inline-block; }

.inline-edit .actions { text-align:right; padding:10px 5px; }

img.editable { cursor:pointer; } 
#avatar-preview {  width:120px; height:120px; border:1px solid #efefef; padding:5px; border-radius:50%; }

.file-tickets-status { display:none; }
.file-tickets-progress { display:none; background:#ccc; width:100%; height:8px; position:relative; }
.file-tickets-progress .file-tickets-progress-percentage { position:absolute; width:0%; background:#33ce5a; height:8px; }

.file-tickets-temp-wrapper { background:#fafafa; border:1px solid #efefef; margin-bottom:10px; }
.file-tickets-temp-wrapper .file-ticket-temp-single { border-bottom:1px solid #efefef; padding:10px; padding-right:80px; position:relative; }
.file-tickets-temp-wrapper .file-ticket-temp-single .remove { cursor:pointer; position:absolute; top:1px; right:1px; width:30px; height:30px; line-height:30px; text-align:center; color:#fff; border:1px solid #efefef; background:#e7504e;   }
.file-tickets-temp-wrapper .file-ticket-temp-single .file-name { height:40px; line-height:40px; font-weight:600; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs { display:flex; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs { display:flex; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs .file-size { padding:5px; width:95px; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs .file-size-value { height:32px; line-height:32px; font-weight:600; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs .ticket-type { padding:5px; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs .ticket-type-input { height:32px; width:100%; border:1px solid #ccc; padding:3px 5px; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs .ticket-type-input { height:32px; width:100%; border:1px solid #ccc; padding:3px 5px; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs .expiry-date { padding:5px; }
.file-tickets-temp-wrapper .file-ticket-temp-single .inputs .expiry-date-input { border-radius:0px; border:1px solid #ccc; padding:3px 5px; }
                                        

.core-competencies-single  { margin-bottom:5px; }
.core-competencies-single .core-competencies-button {  cursor:pointer; font-weight:600; position:relative; padding:10px;  background:#f6f6f6; border-radius:3px; }
.core-competencies-single .core-competencies-button i {  font-size:20px; color:#8e8e8e; position:absolute; top:6px; right:10px; }

.core-competencies-single .core-competencies-button i.mdi-arrow-down-drop-circle { display:inline-block; }
.core-competencies-single .core-competencies-button i.mdi-arrow-up-drop-circle { display:none; }

.core-competencies-single.open .core-competencies-button i.mdi-arrow-down-drop-circle { display:none; }
.core-competencies-single.open .core-competencies-button i.mdi-arrow-up-drop-circle { display:inline-block; }

.core-competencies-single .core-competencies-button:hover { background:#efefef;  }
.core-competencies-single .core-competencies-options { display:none; padding: 15px; border: 1px solid #efefef; }
.core-competencies-single.open .core-competencies-options { display:block;  }
</style>
<script>
import Page404 from '../../layouts/Page404'
import AdminOptions from './adminOptions/Main'
import RatingsList from '../ratings/List'

export default {
    name: 'resume-details',
    props: ['properties'],
     data: function () {
        return {
            page_status: 200,
            error: false,
            fullscreen: false,
            subcategories: [],
            tab: 'personal-information',
            core_competencies_open: 'Class 1 / 3 – Drivers / Operators',
            skills: {
                status: 'default', // default = hide the alert, success = show the success alert, error = show the error alert
                status_message: '',
                data: []
            },
            show_adminOptions: false,
            avatar: '/images/worker-placeholder.jpg',
            file_resume: null,
            file_tickets: [],
            file_tickets_temp: [],
            resume: {
                date_available: '',
                location: '',
                content: '',
            },
            user: {
                first_name: '',
                last_name: '',
                email: '',
                phone: '',
            },
            user_id: null,
            inline_group_response: '',
            inline_group_response_message: '',
            upload_resume_response: '',
            upload_resume_response_message: '',
            inline_groups : {
                fullname: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        first_name: '',
                        last_name: '',
                    }
                },
                phone: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        phone: '',
                        country_code: '',
                    }
                },
                email: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        email: '',
                        new_email: '',
                    }
                },
                location: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        location: '',
                    }
                },
                available_to_work: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        is_available: 1,
                    }
                },
                personal_vehicle: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        is_personal_vehicle_available: 0,
                    }
                },
                date_available: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        date_available: '',
                    }
                },
                date_of_birth: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        date_of_birth: '',
                    }
                },
                content: {
                    url: 'users/candidate/inline',
                    editing: false,
                    data: {
                        content: '',
                    }
                },

            },
            headers: {
                'X-Requested-With': 'XMLHttpRequest',
                'Authorization': 'Bearer ' + localStorage.getItem('KX-PRIMUS')
            },
        }
    },
    computed: {
        auth: function () {
            return this.$store.getters.getAuthenticatedUser
        },
        editable: function () {
            var scope = this
            if (scope.auth && scope.auth.id == scope.user_id || scope.auth.type == 'Admin') {
                return true
            }else if (scope.auth.type == 'Employer') {
                return false
            }else {
                return false
            }
        }
    },
    watch: {
        inline_groups: {
            deep: true,
            handler() {
                var scope = this
                if(scope.inline_groups.phone.editing){
                    setTimeout(function () {
                        scope.$refs.ref_phone.countryCode = scope.user.country_code
                    }, 500)
                }
            }
        }
    },
    components: {
        Page404,
        AdminOptions,
        RatingsList,
    },
    methods: {
        // showrecord: function (user) {
        //     var scope = this
        //     console.log('tesssst')
        //     console.log(user)
        // },
        openCoreCompetencieGroup: function (name) {
            this.core_competencies_open = name
        },
        isSkillSelected: function (id) {
            var scope = this
            return scope.skills.data.includes(id);
        },
        toggleSkill: function (id) {
            var scope = this

            var index = scope.skills.data.indexOf(id)
            if (index !== -1) {
                var index = scope.skills.data.indexOf(id)
                scope.skills.data.splice(index,1)
            } else {
                scope.skills.data.push(id)
            }
            
            
        },
        saveSkills: function () {
            var scope = this
            scope.POST('users/'+ scope.user_id +'/skills', {skills: scope.skills.data}).then(res => {
                if(res.success) {
                    scope.skills.status = 'success'
                    scope.skills.status_message = res.message
                } else {
                    scope.skills.status = 'error'
                    scope.skills.status_message = res.message
                }
                
                setTimeout(function(){ scope.skills.status = 'default' },1500);
            })
        },
        humanFileSize: function(size) {
            var i = Math.floor( Math.log(size) / Math.log(1024) );

            if (!size || isNaN(size)) { return 0 + 'B'}
            return ( size / Math.pow(1024, i) ).toFixed(2) * 1 + ' ' + ['B', 'kB', 'MB', 'GB', 'TB'][i];
        },
        downloadFile: function (file_id) {
            var scope = this
            var response = scope.GET('files/' + file_id + '/download',{}).then(res => {
                // console.log(res)
            })
        },
        getSubcategories: function () {
            var scope = this
            scope.subcategories = []
            var response = scope.GET('job-subcategories',scope.formdata).then(res => {
                scope.subcategories = res.rows
            })

        },
        changeTab: function (tab) {
            this.tab = tab
        },
        toggleInlineEdit: function (group,inline_group) {
            var scope = this
            inline_group.editing = !inline_group.editing

            if (group == 'fullname') {
                inline_group.data.first_name = scope.user.first_name
                inline_group.data.last_name = scope.user.last_name
            } else if (group == 'phone') {
                inline_group.data.phone = scope.user.phone
                inline_group.data.country_code = scope.user.country_code
            } else if (group == 'email') {
                inline_group.data.email = scope.user.email 
                inline_group.data.new_email = scope.user.new_email 
            } else if (group == 'location') {
                inline_group.data.location = scope.user.location
            } else if (group == 'available_to_work') {
                inline_group.data.is_available = scope.user.is_available
            } else if (group == 'personal_vehicle') {
                inline_group.data.is_personal_vehicle_available = scope.user.is_personal_vehicle_available
            } else if (group == 'date_of_birth') {
                inline_group.data.date_of_birth = scope.user.date_of_birth
            } else if (group == 'date_available') {
                inline_group.data.date_available = scope.user.date_available
            } else if (group == 'content') {
                inline_group.data.content = scope.user.content
            }
        },
        saveInline: function(group, inline_group) {
            var scope = this

            console.log('suloood')
            
            if (group == 'phone' && !scope.$refs.ref_phone.isValid) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'warning',
                        title: 'Invalid Phone Number',
                        showConfirmButton: false,
                        timer: 1500
                    })
                return;
            }

            if (group == 'phone') {
                scope.inline_groups.phone.data.country_code = scope.$refs.ref_phone.countryCode
            }
            

            var data = inline_group.data
            var url = inline_group.url

            data.field = group


            data.user_id = scope.user_id
            scope.PUT(url, data).then(res => {

                if (res.success) {
                        scope.user = res.data
                        scope.toggleInlineEdit(group,inline_group)
                        scope.inline_group_response = 'success'
                } else {
                    scope.inline_group_response = 'error'
                    scope.inline_group_response_message = res.message
                }

                setTimeout(function(){
                    scope.inline_group_response = ''
                    scope.inline_group_response_message = ''
                },1200);
            })
        },
        previewFile: function(){
            var scope = this
            var file = $("#avatar-browser").get(0).files[0];

            if (!scope.editable) {
                return
            }
            
            if(file){
                var reader = new FileReader();
                reader.onload = function(){
                    $("#avatar-preview").attr("src", reader.result);
                }
                reader.readAsDataURL(file);
                scope.startUploadAvatar(file);
            }
        },
        startUploadAvatar: function (file) {
            var scope = this
            var avatar = file

        
            var formData = new FormData();
            formData.append('file', avatar);
            formData.append('user_id', scope.user_id);

            scope.error = false
            
            $.ajax({
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            $('.progress').css({
                                width: percentComplete * 100 + '%'
                            });
                            if (percentComplete === 1) {
                                $('.progress').addClass('hide');
                            }
                        }
                    }, false);
                    xhr.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            $('.progress').css({
                                width: percentComplete * 100 + '%'
                            });
                        }
                    }, false);
                    return xhr;
                },
                type: 'POST',
                url: "/api/users/resume/avatar",
                enctype: 'multipart/form-data',
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                headers: scope.headers,
                data:  formData,
                success: function (res) {
                    toastr["success"](res.message)
                },
                error: function(res) {
                    
                    var response = res.responseJSON
                    response.code = res.status
            
                    scope.error = response.message
                    toastr["error"](response.message)

                    $('html, body').animate({
                        scrollTop: $(document).find("#resume-error").offset().top - 70
                    }, 500);
                }
            });
        },
        startUploadResume: function () {
            var scope = this
            
            var file = $("#file-resume-browser").get(0).files[0];
            if(!file){ return; }
            
            var reader = new FileReader();
            
            $(".file-resume-placeholder").html('Uploading ' + file.name);
            
            var formData = new FormData();
            formData.append('file', file);
            formData.append('user_id', scope.user_id);
         
            scope.upload_resume_response = ''

            $.ajax({
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            $('.progress').css({
                                width: percentComplete * 100 + '%'
                            });
                            if (percentComplete === 1) {
                                $('.progress').addClass('hide');
                            }
                        }
                    }, false);
                    xhr.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            $('.progress').css({
                                width: percentComplete * 100 + '%'
                            });
                        }
                    }, false);
                    return xhr;
                },
                type: 'POST',
                url: "/api/users/resume/upload-resume",
                enctype: 'multipart/form-data',
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                headers: scope.headers,
                data:  formData,
                success: function (response ) {
                    $(".file-resume-placeholder").html('Resume: ' + file.name);
                    scope.file_resume = response.data
                    scope.upload_resume_response = 'success'
                },
                error: function(res) {
                    
                    var response = res.responseJSON
                    response.code = res.status
  
                    scope.upload_resume_response = 'error'
                    scope.upload_resume_response_message = response.message
                }
            });
        },
        browseTickets: function () {
            var scope = this
            $.each($("#file-tickets-browser")[0].files, function (key, file){
                scope.file_tickets_temp.push({file: file, ticket_type: '', expiry_date: '', status:'default', message: '', progress: 0, uuid: scope.UNIQUE() });
            });  
            return
        },
        removeTempTicket: function (uuid) {
            var scope = this
            for (let i = 0; i < scope.file_tickets_temp.length; i++) {
                var ticket = scope.file_tickets_temp[i]
                if (ticket.uuid == uuid) {
                    scope.file_tickets_temp.splice(i,1)
                    break;
                }
            }
           
        },
        startUploadTickets: function () {
            var scope = this
            for (let i = 0; i < scope.file_tickets_temp.length; i++) {
                var ticket = scope.file_tickets_temp[i]
                scope.processTicketUpload(ticket);    
            }
        },
        processTicketUpload: function (ticket) {
            var scope = this

            var formData = new FormData();
            formData.append('user_id',scope.user_id);
            formData.append('file',ticket.file);
            formData.append('ticket_type',ticket.ticket_type);
            formData.append('expiry_date',ticket.expiry_date);

            ticket.status = 'uploading'
            // console.log(ticket.status)
            // console.log(ticket.ticket_type)
            $.ajax({
                xhr: function() {
                    var xhr = new window.XMLHttpRequest();

                    xhr.upload.addEventListener("progress", function(evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = (evt.loaded / evt.total) * 100;
                            var progress = Math.ceil(percentComplete);
                            ticket.progress = progress
                            // console.log(progress)
                        }
                    }, false);
                    return xhr;
                },
                type: 'POST',
                url: "/api/users/resume/upload-tickets",
                enctype: 'multipart/form-data',
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                headers: scope.headers,
                data:  formData,
                success: function (res) {

                    ticket.status = 'success'
                    ticket.message = res.message
                    scope.file_tickets.push(res.data);

                    setTimeout(function(){
                        scope.removeTempTicket(ticket.uuid)
                    },2000);
                },
                error: function(res) {
                    var response = res.responseJSON
                    ticket.status = 'error'
                    ticket.message = response.message
                    // var response = res.responseJSON
                    // response.code = res.status
                    // scope.error = response.message
                }
            });
        },
        browseFile: function(el) {
            var scope = this
            
            if (!scope.editable) {
                return
            }
            $(el).trigger('click');
        },
        getProfile: function () {
            var scope = this

            scope.GET('users/' + scope.user_id + '/profile?tickets=yes').then(res => {
                if(!res.success) {
                    return scope.error = res.message
                }

                
                scope.user = res.data
                scope.avatar = (res.data.avatar) ? res.data.avatar : '/images/worker-placeholder.jpg',
                scope.file_tickets = res.tickets
            })
        },
        getProfileSkills: function () {
            var scope = this

            scope.GET('user/' + scope.user_id + '/skills').then(res => {
                
                if(!res.success) {
                    return scope.error = res.message
                }

                res.rows.forEach(function (data) {
                    scope.skills.data.push(data.job_subcategory_item_id)
                })

            })
        },
        deleteTicketFile: function(fileID,index){
            var scope = this
            window.swal.fire({
                title: 'Are you sure?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.value) {
                    scope.DELETE('users/resume/files/' + fileID + '/tickets', {user_id: scope.user_id}).then(res => {
                        if (res.success) {
                            scope.file_tickets.splice(index,1)
                        } else {
                            alert('Error while deleting...')
                        }
                    }) 
                    
                }                              
            })
            
        },
        deleteResumeFile: function(fileID,index){
            var scope = this
             window.swal.fire({
                title: 'Are you sure?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.value) {
                    scope.DELETE('users/resume/files/' + fileID, {user_id: scope.user_id}).then(res => {
                        if (res.success) {
                             scope.file_resume = null
                        } else {
                            alert('Error while deleting...')
                        }
                       
                    })
                }                              
            })
        },
    },
    mounted() {
        var scope = this

        var userID = (scope.properties && scope.properties.candidate_id) ? scope.properties.candidate_id : scope.auth.id

        scope.fullscreen = (scope.properties && scope.properties.fullscreen) ? scope.properties.fullscreen : false
        scope.show_adminOptions = (scope.properties && scope.properties.show_adminOptions) ? scope.properties.show_adminOptions : false

        scope.user_id = userID
        scope.getSubcategories()
        scope.getProfile()
        scope.getProfileSkills()

        $('#summernote').summernote({height: 150})
    }
}
</script>