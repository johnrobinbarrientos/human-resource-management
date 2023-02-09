<template>
<div>
    <div class="page-title-box d-flex align-items-center justify-content-between">
        <h4 class="mb-0 font-size-18">Company Employers</h4>
        <div class="page-title-right">
            <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Users</a></li>
                    <li class="active breadcrumb-item" aria-current="page">
                        <a href="javascript:void(0);">Employers List</a>
                    </li>
                </ol>
            </nav>
        </div>
    </div>

    <div v-show="selected == 'list'" class="card">
        <div class="card-body">
            <div style="margin-bottom: 17px;">
                <div class="row">
                    <div class="col-lg-4">
                        <input @keyup="search()" v-model="keyword" type="text" class="form-control" placeholder="Search Job Employers...">
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
                            <button @click="deleteSelectedUsers()" class="btn btn-primary waves-effect waves-light btn btn-primary mr-2" v-if="selected_users.length > 0">Delete</button>
                            <button @click="OPEN_MODAL('#modalUserForm');" class="btn btn-primary waves-effect waves-light btn btn-primary">Add User</button>
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
                            <th scope="col" style="width: 70px;"></th>
                            <th scope="col">Name</th>
                            <th>Company</th>
                            <th scope="col">Email</th>
                            <th scope="col">Phone</th>
                            <th scope="col">Is Company Admin</th>
                            <th scope="col">Type</th>
                            <th scope="col" class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(user, index) in users" :key="index">
                            <template v-if="user.type != 'Candidate'">
                                <td>
                                    <div style="padding-left:30px; padding-bottom:20px;">
                                        <input @click="toggleSelectUser(user)" class="form-check-input" type="checkbox" :id="'select-user-' + user.id" :checked="isUserSelected(user)">
                                    </div>
                                </td>
                                <td>
                                    <div class="avatar-xs"><span class="avatar-title rounded-circle">{{ user.first_name.charAt(0) }}</span></div>
                                </td>
                                <td>
                                    <h5 class="font-size-14 mb-1"><a class="text-dark">{{ user.first_name }} {{ user.last_name }}</a></h5>
                                </td>
                                <td><span v-if="user.company">{{ user.company.name }}</span></td>
                                <td>{{ user.email }}</td>
                                <td>{{ user.phone }}</td>
                                <td v-if="user.is_company_admin == 1">Yes</td>
                                <td v-else>No</td>
                                <td>
                                    <!-- <div>
                                        <a v-if="user.type == 'Employer' && user.is_company_admin == true" class="badge badge-secondary font-size-11 m-1" href="javascript:void(0);">{{ user.type }} Admin</a>
                                        <a v-else class="badge badge-primary font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                                    </div> -->
                                    <div>
                                        <a class="badge badge-primary font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                                    </div>
                                </td>
                                <td width="160">
                                    <div class="d-flex justify-content-center">
                                        <a href="javascript:void(0);" @click="OPEN_MODAL('#modalUserForm'); setData(user);" class="btn btn-warning btn-sm pr-act-btn mr-2" title="Edit">
                                            <i class="bx bx-edit"></i>Edit
                                        </a>                            
                                        <a href="javascript:void(0);" @click="remove(user.id)" class="btn btn-danger btn-sm pr-act-btn" title="Trash">
                                            <i class="bx bxs-trash"></i>Remove
                                        </a>
                                    </div>
                                </td>
                            </template>
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
                    <input type="text" class="form-control" placeholder="Search Employers...">
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
                        <button @click="deleteSelectedUsers()" class="btn btn-primary waves-effect waves-light btn btn-primary mr-2" v-if="selected_users.length > 0">Delete</button>
                        <button @click="OPEN_MODAL('#modalUserForm');" class="btn btn-primary waves-effect waves-light btn btn-primary">Add User</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
		    <div v-for="(user, index) in users" :key="index" class="col-lg-2">
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
                            <a v-if="user.type == 'Employer' && user.is_company_admin == true" class="badge badge-warning font-size-11 m-1"  style="background: var(--primus-orange)" href="javascript:void(0);">{{ user.type }} Admin</a>
                            <a v-else class="badge badge-warning font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                        </div>
                    </div>
                    <div class="bg-transparent border-top card-footer">
                        <div class="contact-links d-flex font-size-20">
                            <div class="flex-fill">
                                <a href="javascript:void(0);" @click="OPEN_MODAL('#modalUserForm'); setData(user);" title="Edit"><i class="fas fa-pencil-alt"></i></a>
                            </div>
                            <div style="display:none;" class="flex-fill">
                                <a href="javascript:void(0);" @click="OPEN_MODAL('#modalUserNote'); setData(user);" title="Note"><i class="fas fa-clipboard"></i></a>
                            </div>
                            <div class="flex-fill">
                                <a href="javascript:void(0);" @click="remove(user.id)" title="Trash"><i class="bx bxs-trash"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>

	<!-- Modal JOB CATEGORIES Form -->
    <div class="modal fade" tabindex="-1" id="modalUserForm">
        <div class="modal-dialog modal-md " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <h5 v-if="user.type === 'Admin'" class="modal-title">New User</h5>
                    <h5 v-else class="modal-title">New Employer for <span style="color: var(--primus-orange)">{{ user.company.name }}</span></h5> -->

                    <h5 v-if="!formdata.id" class="modal-title">New User</h5>
                    <h5 v-else class="modal-title">Edit User</h5>

                    <a href="javascript:void(0)" @click="CLOSE_MODAL('#modalUserForm'); resetFormData();" class="close" data-dismiss="modal" aria-label="Close">
                        <i class="bx bx-x"></i>
                    </a>
                </div>
                <div class="modal-body">
                    <div class="alert alert-danger alert-icon" v-if="formdata.error">
                        <i class="bx bx-error"></i> <strong>Error</strong>! 
                        {{ formdata.error }}
                    </div>
                    <form action="#" class="form-validate is-alter">
                        <div class="row">
                            <div class="col-md-12 col-12">
                                <div class="form-group">
                                    <label class="form-label" for="item-group">Select Company</label>
                                    <multiselect  v-model="selected_company" :options="options_company" track-by="id" label="text" :allow-empty="false" deselect-label="Selected" selectLabel="Select">
                                        <span slot="noResult">No Results</span>
                                    </multiselect>
                                </div>
                            </div>

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

                            <div class="col-md-12 col-12">
                                <div class="form-group">
                                    <label class="form-label" for="item-group">Phone</label>
                                    <vue-phone-number-input ref="ref_phone" v-model="formdata.phone" default-country-code="CA" :only-countries="['CA', 'US']"/>
                                    <!-- {{ formdata.phone }} -->
                                </div>
                            </div>


                            <div class="col-md-12 col-12">
                                <div class="form-group">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" v-model="formdata.is_company_admin" :true-value="1" :false-value="0" class="custom-control-input" id="customControlInline">
                                        <label class="custom-control-label" for="customControlInline">Is Company Admin</label>
                                    </div>
                                </div>
                            </div>




                            <!-- <template v-if="user.type === 'Admin'">
                                <div class="col-md-12 col-12">
                                    <div class="form-group">
                                        <div style="border: 1px solid #ddd; border-radius: 5px; padding: 15px;">
                                                <div v-show="showCheckbox">
                                                    <label class="form-label" for="item-group">Is New Company ?</label>
                                                    <input v-model="new_company" @click="formdata.company_name = ''" type="checkbox">
                                                    <div class="pb-3"></div>
                                                </div>
                                                <div v-show="new_company">
                                                    <input v-model="formdata.company_name" class="form-control form-control-lg" type="text" placeholder="Company Name">
                                                </div>
                                                <div v-show="!new_company">
                                                    <label v-if="showCheckbox" class="form-label" for="item-group">Select Company</label>
                                                    <label v-else class="form-label" for="item-group">Company: </label>
                                                    <select class="company-id"></select>
                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </template> -->

                        </div>
                    </form>
                </div>
                <div class="modal-footer bg-light">
                    <button v-if="formdata.id === null" @click="save()" type="submit" class="btn btn-lg btn-primary">Save</button>
                    <button v-else @click="update()" type="submit" class="btn btn-lg btn-primary">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" tabindex="-1" id="modalUserNote">
        <div class="pr-note-wrap">
            <div class="pr-note">
                <div class="note-header">
                    <span>NOTE:</span>
                    <div class="d-flex align-items-center">
                        <a href="javascript:void(0);" @click="CLOSE_MODAL('#modalUserNote'); resetFormData()" title="Close" class="btn btn-sm d-flex align-items-center btn-outline-danger mr-2"><i class="fas fa-times mr-1"></i> Cancel</a>
                        <a href="javascript:void(0);" @click="CLOSE_MODAL('#modalUserNote'); saveNote()" title="Save" class="btn btn-sm d-flex align-items-center btn-outline-primary" ><i class="far fa-save mr-1"></i> Save</a>
                    </div>
                </div>
                <div class="note-body"><textarea class="" cols="30" rows="10" v-model="formdata.note"></textarea></div>
            </div>
        </div>
    </div>
</div>
</template>


<script>

export default {
    name: 'employer-admins',
    props: ['properties'],
    data: function () {
        return {
            // new_company: true,

            selected_company: null,
            options_company: [],

            showCheckbox: true,
            formdata: {
                id: null,
                first_name: '',
                last_name: '',
                email: '',
                password: '',
                password2: '',
                type: 'Employer',
                is_verified : true,
                phone: '',
                country_code: '',
                company_name: '',
                company_id: null,
                is_company_admin: 1,

                success: null,
                error: null,
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
            selected_users: [],
            keyword: '',
            timer: null,
        }
    },
    components: { },
    computed: {
        user: function () {
            var scope = this
            return scope.$store.getters.getAuthenticatedUser
        },
    },
    methods: {
        getCompanies: function () {
           var scope = this

            scope.GET('companies').then(res => {
                res.rows.forEach(function (data) {

                    scope.options_company.push({
                        id: data.id,
                        text: data.name
                    })
                })

                if(scope.options_company.length > 0){
                    scope.selected_company = scope.options_company[0]
                }
                
            })

        },
        resetFormData: function() {
            var scope = this
            scope.formdata.id = null
            scope.formdata.first_name = ''
            scope.formdata.last_name = ''
            scope.formdata.email = ''
            scope.formdata.password = ''
            scope.formdata.password2 = ''
            scope.formdata.type = 'Employer'
            scope.formdata.phone = ''

            scope.formdata.company_name = ''
            scope.formdata.company_id = null
            scope.formdata.is_company_admin = 1

            scope.formdata.success = null
            scope.formdata.error = null

            // $('.company-id').html('');
            // $(".company-id").attr("disabled", false)
            // scope.showCheckbox = true
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
            })
            .then((result) => {
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
        setData: function (data) {
            var scope = this
            const clone = JSON.parse(JSON.stringify(data));
            scope.formdata = clone

            scope.options_company.forEach(function (data) {
                if (data.id == scope.formdata.company_id){
                    scope.selected_company = data
                }
            
            })

            // scope.$set(scope.formdata, 'error', null)
            // scope.$set(scope.formdata, 'type', 'Employer')
            // scope.$set(scope.formdata, 'password', '')
            // scope.$set(scope.formdata, 'password2', '')
            // scope.$set(scope.formdata, 'company_id', null)
            // scope.$set(scope.formdata, 'is_company_admin', true)

            // scope.new_company = false
            // $('.company-id').html('');
            // var company_name = []

            // var newOption = new Option(data.company.name , data.company.id , true, true);
            // $(".company-id").append(newOption).trigger('change');
            // $(".company-id").attr("disabled", true)
            // scope.showCheckbox = false
        },
        save: function () {
            var scope = this
            scope.formdata.error = null

            // var company_id = $('.company-id').val()

            scope.formdata.country_code = scope.$refs.ref_phone.countryCode
            scope.formdata.company_id = (scope.selected_company == null) ? null : scope.selected_company.id

            
            // // if 'company admin'
            // if(scope.user.type === 'Employer' && scope.user.is_company_admin)
            // {
            //     scope.formdata.company_id = scope.user.company.id
            //     scope.formdata.is_company_admin = false
            // }
            // // then else if 'super admin'
            // else if(scope.formdata.company_name === '')
            // {
            //     scope.formdata.company_id = company_id
            //     scope.formdata.is_company_admin = false
            // }

            scope.POST('users',scope.formdata).then(res => {
                if (res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Created',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.users.push(res.data)
                        scope.resetFormData()
                        scope.CLOSE_MODAL('#modalUserForm')
                        scope.getList()
                    })
                }else{
                    return scope.formdata.error = res.message
                }

                
            })
        },
        saveNote: function () {
            var scope = this
            scope.formdata.error = null
            var response = scope.POST('users/' + scope.formdata.id + '/note', scope.formdata).then(res => {
                if (!res.success) {
                   return scope.formdata.error = res.message
                }
 
                scope.getList()
                scope.resetFormData();
                scope.CLOSE_MODAL('#modalUserNote');
                
            })       
        },
        update: function () {
            var scope = this
            scope.formdata.error = null
            scope.formdata.success = null

            scope.formdata.country_code = scope.$refs.ref_phone.countryCode
            scope.formdata.company_id = (scope.selected_company == null) ? null : scope.selected_company.id

            scope.PUT('users/' + scope.formdata.id + '/profile', scope.formdata).then(res => {
                // if (!res.success) {
                //     return scope.formdata.error = res.message
                    
                // }
                if (res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Updated',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.getList()
                        scope.CLOSE_MODAL('#modalUserForm')
                    })
                } else {
                    alert('ERROR:' + res.code)
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

            scope.GET('users?type=Employer&keyword=' + scope.keyword + '&page=' + scope.pagination.page + '&take=' + scope.pagination.take).then(res => {
                scope.users = res.rows

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
        scope.getCompanies()

        // only Admin can search companies
        // if(scope.user.type === 'Admin') {
        //     $('.company-id').select2({
        //         ajax: {
        //             url: '/api/companies/search?type=Employer&text=company',
        //             dataType: 'json',
        //             delay: 300,
        //             processResults: function (data) {
        //                 return {
        //                     results: data.rows
        //                 };
        //             }
        //         }
        //     })
        // }
    }
}
</script>
<style scoped>
.avatar-xs {
    height: 1.5rem;
    width: 1.5rem;
    margin: 0 auto;
}
</style>