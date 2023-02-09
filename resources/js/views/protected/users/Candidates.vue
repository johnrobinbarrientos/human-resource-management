<template>
<div>
    <div class="page-title-box d-flex align-items-center justify-content-between">
        <h4 class="mb-0 font-size-18">Candidates</h4>
        <div class="page-title-right">
            <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Users</a></li>
                    <li class="active breadcrumb-item" aria-current="page">
                        <a href="javascript:void(0);">Candidates List</a>
                    </li>
                </ol>
            </nav>
        </div>
    </div>


    <div class="alert alert-success alert-icon" v-if="formdata.success">
        <i class='bx bxs-check-shield'></i> <strong>Success</strong>!
        <span v-html="formdata.success"></span>
    </div>

    <div style="display:none;" class="alert alert-danger alert-icon">
        <i class="bx bx-error"></i> <strong>Error</strong>!
        <hr class="mt-1 mb-2">
        <div v-for="(error, index) in formdata.error" :key="index">
            <p v-html="error" class="mb-1"></p>
        </div>
    </div> 
    
    <div v-show="selected == 'list'" class="card">
        <div class="card-body">
            <div style="margin-bottom: 17px;">
                <div class="row">
                    <div class="col-lg-4">
                        <input @keyup="search()" v-model="keyword" type="text" class="form-control" placeholder="Search Candidates...">
                    </div>
                    <div class="col-lg-8 text-right">
                        
                        <div class="d-flex justify-content-end">
                            <select v-model="pagination.take" @change="getList()" class="form-control per-page" >
                                <option :value="15">15</option>
                                <option :value="50">50</option>
                                <option :value="75">75</option>
                                <option :value="100">100</option>
                            </select>
                            <div class="pr-custom-select mr-2">
                                <select v-model="selected">
                                    <option value="list">List View</option>
                                    <option value="grid">Grid View</option>
                                </select>
                            </div>
                            <button @click="startExport()" class="btn btn-primary waves-effect waves-light btn btn-primary mr-2" v-if="selected_users.length > 0">Export</button>
                            <button @click="createMessage()" class="btn btn-primary waves-effect waves-light btn btn-primary mr-2" v-if="selected_users.length > 0">Send Message</button>
                            <button @click="browseFile('#file-import-browser')" class="btn btn-primary mr-2">Import</button>
                            <input @change="startImport()" class="d-none" id="file-import-browser" type="file">
                            <button @click="deleteSelectedUsers()" class="btn btn-primary waves-effect waves-light btn btn-primary mr-2" v-if="selected_users.length > 0">Delete</button>
                            <button @click="OPEN_MODAL('#modalUserForm');" class="btn btn-primary waves-effect waves-light btn btn-primary mr-2">Add User</button>
                            <div style="position:relative; display:inline-block;">
                                <button @click="toggleTableFilter()" class="btn btn-primary">
                                    <i class="fas fa-filter"></i>
                                </button>
                                <div v-if="filter_options" style="position:absolute; top:35px; right:0px; background:#fff; border:1px solid #efefef; width:300px; min-height:200px; padding:10px; text-align:left;">
                                    <div class="form-group">
                                        <label style="font-weight:600; margin-bottom:3px;">Availability</label>
                                        <select class="form-control" @change="getList()" v-model="selected_is_available">
                                            <option value="">Select All</option>
                                            <option value="yes">Available</option>
                                            <option value="no">Not Avaiable</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label style="font-weight:600; margin-bottom:3px;">Personal Vehicle</label>
                                        <select class="form-control" @change="getList()" v-model="selected_personal_vehicle">
                                            <option value="">Select All</option>
                                            <option value="yes">Yes</option>
                                            <option value="no">No</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label style="font-weight:600; margin-bottom:3px;">Job Type</label>
                                        <select class="form-control" @change="getList()" v-model="selected_job_categories">
                                            <option value="">Select All</option>
                                            <option v-for="category in options_job_categories" :value="category.id"  :key="'option-' + category.id ">{{ category.text }}</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="table-responsive">
                <table class="table-centered table-nowrap table-hover table mb-0">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col" style="width: 40px;">
                                <div style="padding-left:30px; padding-bottom:20px;">
                                    <input class="form-check-input" type="checkbox" :id="'select-user-0'" @change="selectAllUsers($event)">
                                </div>
                            </th>
                            <th scope="col" style="width: 20px;">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Phone</th>
                            <th scope="col">Type</th>
                            <th scope="col" class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(user, index) in users" :key="index">
                            <td>
                                <div style="padding-left:30px; padding-bottom:20px;">
                                    <input @click="toggleSelectUser(user)" class="form-check-input" type="checkbox" :id="'select-user-' + user.id" :checked="isUserSelected(user)">
                                </div>
                            </td>
                            <td>
                                <div class="avatar-xs"><span class="avatar-title rounded-circle">{{ user.first_name.charAt(0) }}</span></div>
                            </td>
                            <td>
                                <h5 style="cursor:pointer;" @click="setData(user); OPEN_MODAL('#modalUserForm');" class="font-size-14 mb-1"><a class="text-dark">{{ user.first_name }} {{ user.last_name }}</a></h5>
                            </td>
                            <td>{{ user.email }}</td>
                            <td>{{ user.phone }}</td>
                            <td>
                                <div>
                                    <a v-if="user.type == 'Admin'" class="badge badge-primary font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
        				            <a v-if="user.type == 'Employer'" class="badge badge-success font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
        				            <a v-if="user.type == 'Candidate'" class="badge badge-secondary font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                                </div>
                            </td>
                            <td width="160">
                                <div class="d-flex justify-content-center">
                                    <a href="javascript:void(0);" @click="OPEN_MODAL('#modalUserForm'); setData(user);" class="btn btn-warning btn-sm pr-act-btn mr-2" title="Edit">
                                        <i class="bx bx-edit"></i>Edit
                                    </a>                            
                                    <a href="javascript:void(0);" @click="remove(user.id)" class="btn btn-danger btn-sm pr-act-btn" title="Trash">
                                        <i class="bx bxs-trash"></i>Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div style="padding:10px; padding-top:20px; padding-bottom:0px;">
                Showing {{  pagination.offset + 1  }} to {{ (pagination.count > pagination.page * pagination.take ? pagination.take : pagination.count) }} of  {{  pagination.count }} entries
            </div>
            <nav v-if="pagination.count > 1" class="pagination pagination-rounded justify-content-center mt-4" aria-label="pagination">
                <ul class="pagination">
                    <li @click="paginate('prev')"  v-bind:class="{'disabled' :  pagination.page <= 1}"  class="page-item" >
                        <a href="javascript:void(0)" class="page-link" aria-label="Previous">
                            <span aria-hidden="true">‹</span><span class="sr-only">Previous</span>
                        </a>
                    </li>

                    <template v-if="pagination.min > 1">
                        <li @click="paginate(1)" :key="page" class="page-item">
                            <a href="javascript:void(0)" class="page-link"> 1</a>
                        </li>

                        <li>
                            <a href="javascript:void(0)" class="page-link"> ...</a>
                        </li>
                    </template>

                    <template  v-for="page in  pagination.pages">
                    <li @click="paginate(page)" :key="page" class="page-item" v-bind:class="{'active' : page ===  pagination.page}">
                        <a  v-if="page >= pagination.min && page <= pagination.max " href="javascript:void(0)" class="page-link">
                            {{ page }}
                        </a>
                    </li>
                    </template>
                    
                    <li @click="paginate('next')" v-bind:class="{'disabled' :  pagination.page >=  pagination.pages}" class="page-item">
                        <a href="javascript:void(0)" class="page-link" aria-label="Next"><span aria-hidden="true">›</span><span class="sr-only">Next</span></a>
                    </li>
                </ul>
            </nav>

        </div>
    </div>

	<div v-show="selected == 'grid'">
        <div style="margin-bottom: 17px; padding: 10px; background: #ddd;">
            <div class="row">
                <div class="col-lg-4">
                    <input type="text" class="form-control" placeholder="Search Candidates...">
                </div>
                <div class="col-lg-8 text-right">
                    <div class="d-flex justify-content-end">
                        <select v-model="pagination.take" @change="getList()" class="form-control per-page" >
                            <option :value="15">15</option>
                            <option :value="50">50</option>
                            <option :value="75">75</option>
                            <option :value="100">100</option>
                        </select>
                        <div class="pr-custom-select mr-2" style="background: #fff;">
                            <select v-model="selected">
                                <option value="list">List View</option>
                                <option value="grid">Grid View</option>
                            </select>
                        </div>
                        <button @click="browseFile('#file-resume-browser')" class="btn btn-primary mr-2">Import</button>
                        <button @click="deleteSelectedUsers()" class="btn btn-primary waves-effect waves-light btn btn-primary mr-2" v-if="selected_users.length > 0">Delete</button>
                        <button @click="OPEN_MODAL('#modalUserForm');" class="btn btn-primary waves-effect waves-light btn btn-primary">Add User</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div v-for="(user, index) in users" :key="index" class="col-lg-3">
                <div class="text-center card">
                    <div class="card-body">
                        <div class="avatar-sm mx-auto mb-4">
                            <span class="avatar-title rounded-circle bg-soft-primary text-white font-size-16" style="text-transform:uppercase;">
                                {{ user.first_name.charAt(0) }}
                            </span>
                        </div>
                        <h5 class="font-size-15">
                        <a class="text-dark" href="javascript:void(0);">{{ user.first_name }} {{ user.last_name }}</a></h5>
                        <p class="text-muted">{{ user.email }}</p>
                        <div>
                            <a v-if="user.type == 'Admin'" class="badge badge-primary font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                            <a v-if="user.type == 'Employer'" class="badge badge-success font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                            <a v-if="user.type == 'Candidate'" class="badge badge-warning font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                        </div>
                    </div>
                    <div class="bg-transparent border-top card-footer">
                        <div class="contact-links d-flex font-size-20">
                            <!-- <div class="flex-fill">
                                <a data-toggle="tooltip" data-placement="top" title="View Resume"  href="javascript:void(0);" @click="ROUTE({path: '/resume/' + user.id })"><i class="bx bxs-user-rectangle"></i></a>
                            </div> -->
                            <div style="display:none;" class="flex-fill">
                                <!-- <a :href="'tel:'+user.phone" title="Call"><i class="fas fa-phone-alt"></i></a> -->
                                <a href="javascript:void(0);" @click="call(user)" title="Call"><i class="fas fa-phone-alt"></i></a>
                            </div>
                            <div class="flex-fill">
                                <a id="profile1" href="javascript:void(0);" @click="OPEN_MODAL('#modalUserForm'); setData(user);" title="Edit"><i class="fas fa-pencil-alt"></i></a>
                            </div>
                            <div style="display:none;" class="flex-fill">
                                <a id="profile1" href="javascript:void(0);" @click="OPEN_MODAL('#modalUserNote'); setData(user);" title="Edit"><i class="fas fa-clipboard"></i></a>
                            </div>
                            <div class="flex-fill">
                                <a id="project1" href="javascript:void(0);" @click="remove(user.id)" title="Trash"><i class="bx bxs-trash"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>

	<!-- Modal CATEGORIES Form -->
    <div class="modal fade" tabindex="-1" id="modalUserForm">
        <div class="modal-dialog modal-md " role="document" style="max-width: 750px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Candidate Resume</h5>
                    <a v-if="formdata.id" href="javascript:void(0)" @click="CLOSE_MODAL('#modalUserForm'); resetFormData(); getList();" class="close" data-dismiss="modal" aria-label="Close">
                        <i class="bx bx-x"></i>
                    </a>
                    <a v-else href="javascript:void(0)" @click="CLOSE_MODAL('#modalUserForm'); resetFormData();" class="close" data-dismiss="modal" aria-label="Close">
                        <i class="bx bx-x"></i>
                    </a>
                </div>
                <div class="modal-body">
                    <template v-if="formdata.id"> 
                        <Resume :properties="{ candidate_id: formdata.id, fullscreen: true, show_adminOptions: true }" :key="'resume-' + formdata.id"></Resume> 
                    </template>
                    <template v-else>
                        <div class="alert alert-danger alert-icon" v-if="formdata.error">
                            <i class="bx bx-error"></i> <strong>Error</strong>! 
                            {{ formdata.error }}
                        </div>

                        <div class="alert alert-success alert-icon" v-if="formdata.success">
                            <i class="bx bx-error"></i> <strong>success</strong>! 
                            {{ formdata.success }}
                        </div>

                        <div id="progrss-wizard" class="twitter-bs-wizard">
                            <ul class="twitter-bs-wizard-nav nav-justified nav nav-pills">
                                <li class="nav-item">
                                    <a class="active nav-link"><span class="step-number mr-2">01</span>Basic Details</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link"><span class="step-number mr-2">02</span><span>Edit Resume</span></a>
                                </li>
                            </ul>
                            <div class="tab-content twitter-bs-wizard-tab-content">
                                <div class="tab-pane active">
                                    <form action="#" class="form-validate is-alter">
                                        <div class="row">
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <label class="form-label" for="item-group">Email Address</label>
                                                    <input v-model="formdata.email" class="form-control form-control-lg" type="email" placeholder="Email Address">
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label class="form-label" for="item-group">First Name</label>
                                                    <input v-model="formdata.first_name" class="form-control form-control-lg" type="text" placeholder="First Name">
                                                </div>
                                            </div>  
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label class="form-label" for="item-group">Last Name</label>
                                                    <input v-model="formdata.last_name" class="form-control form-control-lg" type="text" placeholder="Last Name">
                                                </div>
                                            </div>
                                            <template v-if="formdata.id === null">
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="form-label" for="item-group">Password</label>
                                                        <input v-model="formdata.password" class="form-control form-control-lg" type="password" placeholder="Password">
                                                    </div>
                                                </div>  
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="form-label" for="item-group">Confirm Password</label>
                                                        <input v-model="formdata.password2" class="form-control form-control-lg" type="password" placeholder="Re-type Password">
                                                    </div>
                                                </div>
                                            </template>
                                            <!-- <div class="col-md-12 col-12">
                                                    <div class="form-group">
                                                        <label class="form-label" for="item-group">Phone</label>
                                                        <input v-model="formdata.phone" class="form-control form-control-lg" type="text" placeholder="Phone Number">
                                                    </div> 
                                                </div>-->
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <vue-phone-number-input ref="ref_phone" v-model="formdata.phone" default-country-code="CA" :only-countries="['CA', 'US']"/>
                                                    {{ formdata.phone }}
                                                </div>
                                                <!-- <button type="button" @click="test()"></button> -->
                                            </div>

                                        </div>                                    
                                    </form>
                                </div>
                                <div class="tab-pane">
                                    <Resume :properties="{ candidate_id: formdata.id, fullscreen: true, show_adminOptions: true }" :key="'resume-' + formdata.id"></Resume>
                                </div>  

                            </div>
                            <ul class="pager wizard twitter-bs-wizard-pager-link" style="margin-left: -20px; margin-right: -20px; margin-top: 20px; padding-left: 20px; padding-right: 20px; border-top: 1px solid #eff2f7;">
                                <li class="next"><a href="javascript:void(0);" @click="formTabPaginate('next')">Next</a></li>
                            </ul>
                        </div>

                    </template>
                </div>
                <!-- <div v-if="formdata.id" class="modal-footer bg-light">
                    <button v-if="formdata.id === null" @click="save()" type="submit" class="btn btn-lg btn-primary d-flex align-items-center">Next <i style="font-size: 13px; margin-left: 6px;" class="fas fa-chevron-right"></i></button>
                    <button v-else @click="update()" type="submit" class="btn btn-lg btn-primary">Save Changes</button>
                </div> -->
            </div>
        </div>
    </div>

    <div class="modal fade" tabindex="-1" id="modalUserNote">
        <div class="pr-note-wrap">
            <div class="pr-note">
                <div class="note-header">
                    <span>NOTE:</span>
                    <div class="d-flex align-items-center">
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modalUserNote'); resetFormData()" title="Close" class="btn btn-sm d-flex align-items-center btn-outline-danger mr-2"><i class="fas fa-times mr-1"></i> Cancel</a>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modalUserNote'); saveNote()" title="Save" class="btn btn-sm d-flex align-items-center btn-outline-primary" ><i class="far fa-save mr-1"></i> Save</a>
                    </div>
                </div>
                <div class="note-body"><textarea class="" cols="30" rows="10" v-model="formdata.note"></textarea></div>
            </div>
        </div>
    </div>

    <PopupForm ref="popupForm"></PopupForm>
</div>
</template>


<script>
    import Resume from '../../protected/resume/Details'
    import PopupForm from '../message-center/PopupForm'
    

    export default {
    name: 'user-candidates',
    props: ['properties'],
    data: function () {
        return {
            filter_options: false,
            yourValue:'',
            formdata: {
                id: null,
                first_name: '',
                last_name: '',
                email: '',
                phone: '',
                country_code: '',
                note: '',
                is_verified : true,
                
                error: null,
                success: null,
            },
            pagination: {
                loading: true,
                page: 1,
                take: 15,
                count: 1,
                offset: 0,
                pages: 0,
                min: 0,
                max: 0,
                show: 5
            },
            
            users: [],
            selected: 'list',
            tab_counter: 1,
            candidate_id: null,
            selected_users: [],
            headers: {
                'X-Requested-With': 'XMLHttpRequest',
                'Authorization': 'Bearer ' + localStorage.getItem('KX-PRIMUS')
            },
            keyword: '',
            timer: null,
            selected_is_available: '',
            selected_personal_vehicle: '',
            selected_job_categories: '',
            options_job_categories: [],
        }
    },
    components: {
        Resume,
        PopupForm,
    },
    methods: {
        toggleTableFilter: function () {
            var scope = this
            scope.filter_options= !scope.filter_options
        },
        
        getJobCategories: function () {
           var scope = this
            scope.GET('job-subcategory-items').then(res => {
                // console.log(res.rows)
                res.rows.forEach(function (data) {

                    scope.options_job_categories.push({
                        id: data.id,
                        text: data.job_type.name
                    })
                
                })

                //$(".form-select-item-group").select2({data: scope.options_item_group});
                //scope.selected_item_group = scope.options_item_group[0].id
            })
        },
        startExport: function () {
            var scope = this
            scope.formdata.error = null
            scope.POST('users/resume/export', { users: scope.selected_users }).then(res => {
                if (!res.success) {
                    alert(res.message)
                    return scope.formdata.error = res.message
                }
                alert(res.message)
                scope.getList()
                scope.resetFormData();
                scope.CLOSE_MODAL('#modalUserNote');
            }) 
        },
        createMessage: function(mail) {
            var scope = this

            var mail = {};
            mail.id =  null
            mail.subject =  ''
            mail.message =  ''
            mail.is_sms =  'yes'
            mail.is_email =  'yes'
            mail.recipients =  scope.selected_users
            mail.has_mail_recipient_details =  false

            window.swal.fire({
                title: 'Are you sure you want to send message to select candidates?',
                text: 'You won\'t be able to revert this',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Continue',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if(result.value) {
                    scope.$refs.popupForm.setData(mail)
                    scope.OPEN_MODAL('#modal-mail');
                   
                }
            })
        },
        isUserSelected: function(user) {
            var scope = this

            var found = scope.selected_users.find((row) => {
                return row.id === user.id;
            });

            if (!found) {
                return false;
            } 

            return true
        },
        selectAllUsers: function($event) {
            var scope = this

            if($event.target.checked) {
                for (let i = 0; i < scope.users.length; i++) {
                    var current = scope.users[i]
                    scope.selected_users.push(current)
                }
            } else {
                scope.selected_users = []
            }
        },
        toggleSelectUser: function(user) {
            var scope = this
            if (!scope.isUserSelected(user)) {
                scope.selected_users.push(user);
                return
            } 
            var index = scope.selected_users.findIndex(x => x.id === user.id);
            // var index = scope.selected_users.indexOf(user.id)
            scope.selected_users.splice(index,1)
            return
        },
        deleteSelectedUsers: function(){
            var scope = this
            window.swal.fire({
                title: 'Are you sure?',
                text: 'You won\'t be able to revert this',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                for(var i=0; scope.selected_users.length > i;i++){
                    var user = scope.selected_users[i]
                    var  id = user['id']


                    scope.DELETE('users/' + id).then(res => {
                        if (res.success) {
                            scope.getList();
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })
                }
            })


        },
        formTabPaginate: function(param) {
            var scope = this
            var next_limit = 2
            var prev_limit = 1
            
            // default value of tab
            $(`.tab-content .tab-pane:nth-child(${scope.tab_counter})`).addClass('active')

            // paginate
            if(param === 'next') {

                if(this.tab_counter === 1) {
                    if(!scope.save()) { return }
                }

                // if last page of form request, hide next button
                if(scope.tab_counter === next_limit - 1){
                    $('li.next a').css('visibility','hidden')
                }

                // if counter equals limit, STAY do not paginate
                if(scope.tab_counter === next_limit) { return }


                scope.tab_counter++
                // console.log('next', scope.tab_counter)
            }
            else if(param === 'prev')
            {

                //if not last page of form request, show next button
                if(scope.tab_counter !== next_limit - 1){
                    $('li.next a').css('visibility','visible')
                }

                if(scope.tab_counter === prev_limit) {
                   return
                }
                // set error empty because sometimes they click prev but error dsplay stays
                scope.formdata.error = ''

                scope.tab_counter--
                // console.log('prev', this.tab_counter)
            }

            // tab
            $('.tab-content .tab-pane').removeClass('active')
            $(`.tab-content .tab-pane:nth-child(${scope.tab_counter})`).addClass('active')

            // tab number circle above
            $('#progrss-wizard .nav-pills li.nav-item a').removeClass('active')
            $(`#progrss-wizard .nav-pills li.nav-item:nth-child(${scope.tab_counter}) a`).addClass('active')
        },

        resetFormData: function() {
            var scope = this
            scope.formdata.id = null
            scope.formdata.first_name = ''
            scope.formdata.last_name = ''
            scope.formdata.email = ''
            scope.formdata.password = ''
            scope.formdata.password2 = ''
            scope.formdata.type = 'Candidate'
            scope.formdata.phone = ''
            scope.formdata.note = ''

            scope.formdata.success = null
            scope.formdata.error = null
        },
        setData: function (data) {
            var scope = this
            const clone = JSON.parse(JSON.stringify(data));
            scope.formdata = clone

            scope.$set(scope.formdata, 'error', null)
            scope.$set(scope.formdata, 'type', 'Candidate')
            scope.$set(scope.formdata, 'password', '')
            scope.$set(scope.formdata, 'password2', '')
        },
        save: function () {
            var scope = this
            scope.formdata.error = null

            scope.formdata.country_code = scope.$refs.ref_phone.countryCode

            scope.POST('users',scope.formdata).then(res => {
                if (res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Created',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.formdata.success = res.message
                        scope.users.push(res.data)
                        scope.resetFormData()
                        
                        //scope.$router.push({path: '/resume/' + res.data.id })
                        scope.formdata.id = res.data.id
                        return true
                    })
                }
                else{
                    scope.formdata.error = res.message
                    return false
                }

            })
        },
        saveNote: function () {
            var scope = this
            scope.formdata.error = null
            scope.POST('users/' + scope.formdata.id + '/note', scope.formdata).then(res => {
                if (!res.success) {
                    alert(res.message)
                    return scope.formdata.error = res.message
                }
                alert(res.message)
                scope.getList()
                scope.resetFormData();
                scope.CLOSE_MODAL('#modalUserNote');
            })       
        },
        update: function ()
        {
            var scope = this
            scope.formdata.error = null
            scope.formdata.success = null

            scope.PUT('users/' + scope.formdata.id + '/profile', scope.formdata).then(res => {
                if(res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Updated',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        //alert(res.message)
                        scope.formdata.success = res.message
                        scope.getList()
                        scope.CLOSE_MODAL('#modalUserForm')
                    })
                }else{
                    return scope.formdata.error = res.message
                }
                
            })
            
            
        },
        remove: function (id) {
            var scope = this

            window.swal.fire({
                title: 'Are you sure?',
                text: 'You won\'t be able to revert this',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.value) {
                    scope.DELETE('users/' + id).then(res => {
                        if (res.success) {
                            scope.getList();
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })        
                }                              
            })
        },
        call: function (user) {
            var scope = this
            scope.formdata.error = null
            var response = scope.GET('twilio/call/' + user.id,{}).then(res => {
                if (res.success) {
                    alert(res.message)
                }
            })
        },
        browseFile: function(el) {
            $(el).trigger('click');
        },
        startUploadResume: function () {
            var scope = this
            
            var file = $("#file-resume-browser").get(0).files[0];
            if(!file){ return; }
            
            var reader = new FileReader();
            
            $(".file-resume-placeholder").html('Uploading ' + file.name);
            
            var formData = new FormData();
            formData.append('file', file);
         
            scope.error = false
            $('#file-resume-browser').val('')

            $.ajax({
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            // console.log(percentComplete);
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
                            // console.log(percentComplete);
                            $('.progress').css({
                                width: percentComplete * 100 + '%'
                            });
                        }
                    }, false);
                    return xhr;
                },
                type: 'POST',
                url: "/api/candidate/import",
                enctype: 'multipart/form-data',
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                headers: scope.headers,
                data:  formData,
                success: function (res) {
                    let errors = []
                    
                    if (res.imported) {
                        scope.getList()
                    }

                    if (res.errors.null_values.length) {
                        for (var row of res.errors.null_values) {
                            errors.push(`
                            <strong>Row ${row}</strong> not added.
                            <small style="font-size: 12px;">
                                <i>Name, Email</i> and <i>Password</i>
                            </small>fields must be filled.`)
                        }
                        scope.formdata.error = errors
                    }
                    if (res.errors.existing_emails.length) {
                        for (var row of res.errors.existing_emails) {
                            errors.push(`
                            <strong>Row ${row.row}</strong> not added.
                            Email <small style="font-size: 12px;"><i>${row.email}</i></small>
                            has already been taken.`)
                        }
                        scope.formdata.error = errors
                    }

                    scope.formdata.success = 'Total: <strong>' + (res.imported == null ? 0 : res.imported) + '</strong> Candidates has been imported.'
                },
                error: function(res) {
                    scope.formdata.error = "Something went wrong"
                }
            });
        },
        startImport: function () {
            var scope = this
            
            var file = $("#file-resume-browser").get(0).files[0];
            if(!file){ return; }
            
            var reader = new FileReader();
            
            $(".file-resume-placeholder").html('Uploading ' + file.name);
            
            var formData = new FormData();
            formData.append('file', file);
         
            scope.error = false
            $('#file-resume-browser').val('')

            $.ajax({
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            // console.log(percentComplete);
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
                            // console.log(percentComplete);
                            $('.progress').css({
                                width: percentComplete * 100 + '%'
                            });
                        }
                    }, false);
                    return xhr;
                },
                type: 'POST',
                url: "/api/candidate/import",
                enctype: 'multipart/form-data',
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                headers: scope.headers,
                data:  formData,
                success: function (res) {
                    let errors = []
                    
                    if (res.imported) {
                        scope.getList()
                    }

                    if (res.errors.null_values.length) {
                        for (var row of res.errors.null_values) {
                            errors.push(`
                            <strong>Row ${row}</strong> not added.
                            <small style="font-size: 12px;">
                                <i>Name, Email</i> and <i>Password</i>
                            </small>fields must be filled.`)
                        }
                        scope.formdata.error = errors
                    }
                    if (res.errors.existing_emails.length) {
                        for (var row of res.errors.existing_emails) {
                            errors.push(`
                            <strong>Row ${row.row}</strong> not added.
                            Email <small style="font-size: 12px;"><i>${row.email}</i></small>
                            has already been taken.`)
                        }
                        scope.formdata.error = errors
                    }

                    scope.formdata.success = 'Total: <strong>' + (res.imported == null ? 0 : res.imported) + '</strong> Candidates has been imported.'
                },
                error: function(res) {
                    scope.formdata.error = "Something went wrong"
                }
            });
        },

        paginate: function(page) {
            var scope = this
        
            if (page === 'prev') {
                scope.pagination.page = scope.pagination.page - 1
            } else if (page === 'next') {
                scope.pagination.page = scope.pagination.page  + 1
            } else {
                scope.pagination.page = page
            }

            if (scope.pagination.page < 1) {
                scope.pagination.page = 1
                scope.getList()
                return
            } else  if (scope.pagination.page > scope.pagination.pages) {
                scope.pagination.page =  scope.pagination.pages
                scope.getList()
                return
            }

            scope.getList()
        },
        getList: function () {
            var scope = this
            scope.pagination.loading = true

            var params = {
                availability: scope.selected_is_available,
                personal_vehicle: scope.selected_personal_vehicle,
                job_category: scope.selected_job_categories,
            }

            var str = jQuery.param( params );

            scope.GET('users?type=Candidate&keyword=' + scope.keyword + '&page=' + scope.pagination.page + '&take=' + scope.pagination.take + '&' + str).then(res => {
                scope.users = res.rows

                console.log('useeerrs')
                console.log(scope.users)

                scope.pagination.count = res.count
                scope.pagination.offset = ((scope.pagination.page - 1 ) * scope.pagination.take)

                // number of pages to paginate based on number of result count
                scope.pagination.pages = Math.ceil(scope.pagination.count / scope.pagination.take)

                scope.pagination.min = (scope.pagination.page > scope.pagination.show) ? scope.pagination.page - scope.pagination.show : 1;
                var max = (scope.pagination.page + scope.pagination.show)
                scope.pagination.max = (max < scope.pagination.pages) ? max : scope.pagination.pages
                scope.pagination.loading = false
            })
        }, 
        search() {  
            var scope = this
            if (scope.timer) {
                clearTimeout(this.timer);
                scope.timer = null;
            }
            scope.timer = setTimeout(() => {
                scope.getList();
            }, 500);
        }
    },
    mounted() {
        var scope = this
        scope.getList()
        scope.getJobCategories()
        scope.formTabPaginate()
    }
}
</script>

<style>
.table-filter { background:#f9f9f9; border:1px solid #d7d8e0; padding:0px; margin-bottom: 8px; }
.table-filter-row { display:flex; justify-content: space-evenly; }
.select-wrap { background:#e5e5ed; padding-right: 5px; border-right:1px solid #d7d8e0; width: 100%; }
.select-wrap select { padding:5px; padding-top: 6px; background:transparent; border:none; width:100%; font-size: 12px; }
.badge { font-size: 11px; }

</style>
