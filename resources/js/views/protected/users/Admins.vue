<template>
<div>
    <div class="page-title-box d-flex align-items-center justify-content-between">
        <h4 class="mb-0 font-size-18">Administrators</h4>
        <div class="page-title-right">
            <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Users</a></li>
                    <li class="active breadcrumb-item" aria-current="page">
                        <a href="javascript:void(0);">Administrators List</a>
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
                        <input @keyup="search()" v-model="keyword" type="text" class="form-control" placeholder="Search Administrators...">
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
                            <th scope="col" width="34"></th>
                            <th scope="col">Name</th>
                            <th>Company</th>
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
                            <td width="34">
                                <div class="avatar-xs"><span class="avatar-title rounded-circle">{{ user.first_name.charAt(0) }}</span></div>
                            </td>
                            <td>
                                <h5 class="font-size-14 mb-1"><a class="text-dark">{{ user.first_name }} {{ user.last_name }}</a></h5>
                            </td>
                            <td><span v-if="user.company">{{ user.company.name }}</span></td>
                            <td>{{ user.email }}</td>
                            <td>{{ user.phone }}</td>
                            <td>
                                <div>
        				            <a v-if="user.type == 'Employer' && user.is_company_admin == true" class="badge badge-secondary font-size-11 m-1" href="javascript:void(0);">{{ user.type }} Admin</a>
        				            <a v-else class="badge badge-primary font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
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
                    <input type="text" class="form-control" placeholder="Search Administrators...">
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
                            <a v-if="user.type == 'Admin'" class="badge badge-primary font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                            <a v-if="user.type == 'Employer'" class="badge badge-success font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                            <a v-if="user.type == 'Candidate'" class="badge badge-warning font-size-11 m-1" href="javascript:void(0);">{{ user.type }}</a>
                        </div>
                    </div>
                    <div class="bg-transparent border-top card-footer">
                        <div class="contact-links d-flex font-size-20">
                            <div class="flex-fill">
                                <a href="javascript:void(0);" @click="OPEN_MODAL('#modalUserForm'); setData(user);" title="Edit"><i class="fas fa-pencil-alt"></i></a>
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
                    <h5 class="modal-title">New User</h5>
                    <a href="javascript:void(0)"  @click="CLOSE_MODAL('#modalUserForm'); resetFormData();" class="close" data-dismiss="modal" aria-label="Close">
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
                                        <label class="form-label" for="item-group">New Password</label>
                                        <input v-model="formdata.password" class="form-control form-control-lg" type="password" placeholder="Password">
                                    </div>
                                </div>  
                                <div class="col-md-6 col-12">
                                    <div class="form-group">
                                        <label class="form-label" for="item-group">Confirm New Password</label>
                                        <input v-model="formdata.password2" class="form-control form-control-lg" type="password" placeholder="Re-type Password">
                                    </div>
                                </div>
                            </template>

                            <!-- <div class="col-md-12 col-12">
                                <div class="form-group">
                                    <label class="form-label" for="item-group">Phone</label>
                                    <input v-model="formdata.phone" class="form-control form-control-lg" type="text" placeholder="Phone Number">
                                </div>
                            </div>  -->

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
                <div class="modal-footer bg-light">
                    <button v-if="formdata.id === null" @click="save()" type="submit" class="btn btn-lg btn-primary">Save</button>
                    <button v-else @click="update()" type="submit" class="btn btn-lg btn-primary">Save Changes</button>
                </div>
            </div>
        </div>
    </div>
</div>
</template>


<script>
    export default {
    name: 'user-candidates',
    props: ['properties'],
    data: function () {
        return {
            formdata: {
                id: null,
                username: '',
                first_name: '',
                last_name: '',
                email: '',
                password: '',
                password2: '',
                type: 'Admin',
                phone: '',
                country_code: '',
                error: null
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
    components: {
    
    },
    methods: {
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
        resetFormData: function() {
            var scope = this
            scope.formdata.id = null
            scope.formdata.first_name = ''
            scope.formdata.last_name = ''
            scope.formdata.email = ''
            scope.formdata.password = ''
            scope.formdata.password2 = ''
            scope.formdata.type = 'Admin'
            scope.formdata.phone = ''
            scope.formdata.error = null
        },
        setData: function (data) {
            var scope = this
            const clone = JSON.parse(JSON.stringify(data));
            scope.formdata = clone

            scope.$set(scope.formdata, 'error', null)
            scope.$set(scope.formdata, 'type', 'Admin')
            scope.$set(scope.formdata, 'password', '')
            scope.$set(scope.formdata, 'password2', '')

            scope.formdata.id = data.id
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
                        scope.users.push(res.data);
                        scope.resetFormData();
                        scope.CLOSE_MODAL('#modalUserForm');
                    })
                }else{
                    scope.formdata.error = res.message
                    return
                }
                
            })
        },
        update: function ()
        {
            var scope = this

            scope.formdata.error = null
            scope.formdata.success = null

            scope.formdata.country_code = scope.$refs.ref_phone.countryCode

            //scope.formdata_password.error = null
            //scope.formdata_password.success = null

            scope.PUT('users/' + scope.formdata.id + '/profile', scope.formdata).then(res => {
                if(res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Updated',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.formdata.success = res.message
                        scope.getList()
                        scope.CLOSE_MODAL('#modalUserForm')
                    })
                }else{
                    return scope.formdata.error = res.message
                }

            })
            
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

            scope.GET('users?type=Admin&keyword=' + scope.keyword + '&page=' + scope.pagination.page + '&take=' + scope.pagination.take).then(res => {
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
        scope.getList();
    }
}
</script>
<style scoped>
.badge {
    padding: .25em .4em;
}
</style>