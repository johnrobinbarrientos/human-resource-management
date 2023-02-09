<template>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-flex align-items-center justify-content-between">
                        <h4 class="mb-0 font-size-18">Profile</h4>
                        <div class="page-title-right">
                            <nav class="" aria-label="breadcrumb">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="/profile">Dashboard</a></li>
                                    <li class="active breadcrumb-item" aria-current="page"><a href="/profile">Profile</a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-2">
                                <div class="card">
                                    <div class="card-body" style="padding: 10px;">
                                        <div class="d-block text-center">
                                            <div class="">
                                                <img id="avatar-preview" @click="browseFile('#avatar-browser')" :src="avatar" class="avatar-md rounded-circle img-thumbnail mb-3" style="cursor:pointer; height: 150px; width: 150px;">
                                                <input @change="previewFile()" style="position:fixed; top:-100px; left:-100px; opacity:0;" id="avatar-browser" type="file">
                                            </div>
                                            <div class="align-self-center media-body">
                                                <div class="text-muted">
                                                    <h5 class="font-weight-bold"> {{ user.first_name }} {{ user.last_name }}</h5>
                                                    <p class="mb-1"> {{ user.email }} </p>
                                                    <p v-if="user.phone" class="mb-0"> {{ user.phone }} </p>
                                                    <p v-else class="mb-0"> Phone #: <span style="font-style: italic;color: darkgrey; font-size: 12px;">Not Available</span> </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </div>
                        <div class="col-lg-10">
                            <div class="row">
                                <div class="col-lg-4 col-sm-12" v-bind:class="{ 'col-lg-6' : user.type!=='Employer' }">
                                    <div class="card mb-0">
                                        <form v-on:submit.prevent="updateProfile()" novalidate="" action="#" method="get" class="form-horizontal av-valid">
                                            <div class="card-header p-3">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <h4 class="card-title mb-0">Profile Details</h4>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="alert alert-danger alert-icon" v-if="formdata.error">
                                                    <i class="bx bx-error"></i> <strong>Error</strong>! 
                                                    {{ formdata.error }}
                                                </div>
                                                <div class="alert alert-success alert-icon" v-if="formdata.success">
                                                    <i class='bx bxs-check-shield'></i> <strong>Success</strong>! 
                                                    {{ formdata.success }}
                                                </div>
                                                <div class="form-group mb-0">

                                                    <div class="row" style="margin-bottom: 10px">
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="d-flex align-items-center h-100">
                                                                <label class="mb-0" for="firstName">First Name:</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-10 col-sm-12">                        
                                                            <input
                                                                placeholder="Enter First Name"
                                                                type="text"
                                                                class="form-control mb-0"
                                                                id="firstName"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata.first_name"
                                                            />
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-bottom: 10px">
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="d-flex align-items-center h-100">
                                                                <label class="mb-0" for="LastName">Last Name:</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-10 col-sm-12">                        
                                                            <input
                                                                placeholder="Enter Last Name"
                                                                type="text"
                                                                class="form-control mb-0"
                                                                id="LastName"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata.last_name"
                                                            />
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-bottom: 10px">
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="d-flex align-items-center h-100">
                                                                <label class="mb-0" for="LastEmail">Email:</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-10 col-sm-12">                        
                                                            <input
                                                                placeholder="Enter Email"
                                                                type="text"
                                                                class="form-control mb-0"
                                                                id="LastEmail"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata.email"
                                                            />
                                                        </div>
                                                    </div>

                                                    <!-- <div class="row">
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="d-flex align-items-center h-100">
                                                                <label class="mb-0" for="phone">Phone:</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-10 col-sm-12">                        
                                                            <input
                                                                placeholder="Enter Tel / Phone No."
                                                                type="text"
                                                                class="form-control mb-0"
                                                                id="phone"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata.phone"
                                                            />
                                                        </div>
                                                    </div> -->

                                                    <div class="row">
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="d-flex align-items-center h-100">
                                                                <label class="mb-0" for="phone">Phone:</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-10 col-sm-12">
                                                            <vue-phone-number-input ref="ref_phone" v-model="formdata.phone" default-country-code="CA" :only-countries="['CA', 'US']"/>                  
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="card-footer">
                                                <div class="text-center"><button type="submit" class="btn btn-primary">Update Profile</button></div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div v-if="user.type === 'Employer'" class="col-lg-4 col-sm-12">
                                    <form v-on:submit.prevent="updateCompany()" novalidate="" action="#" method="get" class="form-horizontal av-valid h-100">
                                        <div class="card mb-0 h-100">
                                            <div class="card-header p-3">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <h4 class="card-title mb-0">Company Details</h4>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="alert alert-danger alert-icon" v-if="formdata_company.error">
                                                    <i class="bx bx-error"></i> <strong>Error</strong>! 
                                                    {{ formdata_company.error }}
                                                </div>
                                                <div class="alert alert-success alert-icon" v-if="formdata_company.success">
                                                    <i class='bx bxs-check-shield'></i> <strong>Success</strong>! 
                                                    {{ formdata_company.success }}
                                                </div>

                                                <div class="form-group">
                                                    <div class="row" style="margin-bottom: 10px">
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="d-flex align-items-center h-100">
                                                                <label class="mb-0" for="companyName">Name:</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-10 col-sm-12">                        
                                                            <input
                                                                placeholder="Enter Company Name"
                                                                type="text"
                                                                class="form-control mb-0"
                                                                id="companyName"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata_company.company_name"
                                                                :disabled="user.is_company_admin == false"
                                                            />
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-bottom: 10px">
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="d-flex align-items-center h-100">
                                                                <label class="mb-0" for="companyAddress">Address:</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-10 col-sm-12">                        
                                                            <input
                                                                placeholder="Enter Address"
                                                                type="text"
                                                                class="form-control mb-0"
                                                                id="companyAddress"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata_company.address"
                                                                :disabled="user.is_company_admin == false"
                                                            />
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-bottom: 10px">
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="d-flex align-items-center h-100">
                                                                <label class="mb-0" for="about">About:</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-10 col-sm-12">                        
                                                            <textarea
                                                                placeholder="Enter a desciption about your company"
                                                                type="text"
                                                                class="form-control mb-0"
                                                                id="about"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata_company.description"
                                                                style="min-height: 70px;"
                                                                :disabled="user.is_company_admin == false"
                                                            ></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                            </div>
                                            <div v-if="user.is_company_admin == true" class="card-footer">
                                                <div class="text-center"><button type="submit" class="btn btn-primary">Update Company</button></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-lg-4 col-sm-12" v-bind:class="{ 'col-lg-6' : user.type!=='Employer' }">
                                            <form v-on:submit.prevent="updatePassword()" novalidate="" action="#" method="get" class="form-horizontal av-valid h-100">
                                                <div class="card mb-0 h-100">
                                                    <div class="card-header p-3">
                                                        <div class="d-flex align-items-center justify-content-between">
                                                            <h4 class="card-title mb-0">Change Password</h4>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="alert alert-danger alert-icon" v-if="formdata_password.error">
                                                            <i class="bx bx-error"></i> <strong>Error</strong>! 
                                                            {{ formdata_password.error }}
                                                        </div>
                                                        <div class="alert alert-success alert-icon" v-if="formdata_password.success">
                                                            <i class='bx bxs-check-shield'></i> <strong>Success</strong>! 
                                                            {{ formdata_password.success }}
                                                        </div>
                                                        <div class="form-group">
                                                            <input
                                                                placeholder="Current Password"
                                                                type="password"
                                                                class="form-control"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata_password.current"
                                                            />
                                                            <input
                                                                placeholder="New Password"
                                                                type="password"
                                                                class="form-control"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata_password.new"
                                                            />
                                                            <input
                                                                placeholder="Confirm New Password"
                                                                type="password"
                                                                class="form-control"
                                                                autocomplete="off"
                                                                required
                                                                v-model="formdata_password.confirm_new"
                                                            />
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
                                                        <div class="text-center"><button type="submit" class="btn btn-primary">Update Password</button></div>
                                                    </div>
                                                </div>
                                            </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</template>

<script>
export default {
    name: 'profile',
    properties: ['properties'],
    data: function () {
        return {
            formdata: {
                id: null,
                first_name: '',
                last_name: '',
                email: '',
                phone: '',
                country_code: '',

                error: null,
                success: null,
            },
            formdata_company: {
                company_name: '',
                address: '',
                description: '',

                error: null,
                success: null,
            },
            formdata_password: {
                current: '',
                new: '',
                confirm_new: '',
                error: null,
                success: null,
            },
            avatar: '/images/worker-placeholder.jpg'
        }
    },
    methods: {
        updateProfile: function ()
        {
            var scope = this
            scope.formdata.error = null
            scope.formdata.success = null

            scope.formdata.country_code = scope.$refs.ref_phone.countryCode
            console.log('sulod')
            console.log(scope.formdata)

            scope.PUT('users/' + scope.user.id + '/profile', scope.formdata).then(res => {
                if(!res.success) {
                    return scope.formdata.error = res.message
                }
                scope.formdata.success = res.message

                // update user in computed
                scope.user.first_name = scope.formdata.first_name
                scope.user.last_name = scope.formdata.last_name
                scope.user.email = scope.formdata.email
                scope.user.phone = scope.formdata.phone
            })
        },

        updateCompany: function ()
        {
            var scope = this
            scope.formdata_company.error = null
            scope.formdata_company.success = null

            scope.PUT('users/' + scope.user.id + '/company', scope.formdata_company).then(res => {
                if(!res.success) {
                    return scope.formdata_company.error = res.message
                }
                scope.formdata_company.success = res.message
            })
        },

        updatePassword: function ()
        {
            var scope = this
            scope.formdata_password.error = null
            scope.formdata_password.success = null

            scope.PUT('users/' + scope.user.id + '/password', scope.formdata_password).then(res => {
                if(!res.success) {
                    return scope.formdata_password.error = res.message
                }
                scope.formdata_password.success = res.message
            })
        },
        browseFile: function(el) {
            var scope = this

            $(el).trigger('click');
        },
        previewFile: function(){
            var scope = this
            var file = $("#avatar-browser").get(0).files[0];
            
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
            formData.append('user_id', scope.user.id);

            scope.error = false
            
            $.ajax({
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total;
                            console.log(percentComplete);
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
                            console.log(percentComplete);
                            $('.progress').css({
                                width: percentComplete * 100 + '%'
                            });
                        }
                    }, false);
                    return xhr;
                },
                type: 'POST',
                url: "/api/users/"+ scope.user.id +"/avatar",
                enctype: 'multipart/form-data',
                processData: false,  // tell jQuery not to process the data
                contentType: false,  // tell jQuery not to set contentType
                 headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem('KX-PRIMUS')
                },
                data:  formData,
                success: function (res) {
                    if (res.success) {
                        scope.$store.dispatch('updateAvatar',{ avatar: res.url })
                        toastr["success"](res.message)
                    }
                    
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

    },
    computed: {
        user: function () {
            var scope = this
            return scope.$store.getters.getAuthenticatedUser
        }
    },
    mounted() {
        var scope = this
        scope.avatar = (scope.user.avatar) ? scope.user.avatar : scope.avatar

        scope.formdata.first_name = scope.user.first_name
        scope.formdata.last_name = scope.user.last_name
        scope.formdata.email = scope.user.email
        scope.formdata.phone = scope.user.phone
        
        setTimeout(function () {
            scope.$refs.ref_phone.countryCode = scope.user.country_code
        }, 500)


        // console.log('companyyyyyyyyy')
        // console.log(scope.user)

        scope.formdata_company.company_name = scope.user.company.name
        scope.formdata_company.address = scope.user.company.address
        scope.formdata_company.description = scope.user.company.description
    }
}
</script>

<style scoped>
.form-group input { margin-bottom: 10px }
.card-header {
    background-color: #fff;
    border-bottom: 1px solid #eee;
}
.card-footer {
    background-color: #fff;
    border-top: 1px solid #eee;
}

.form-control:disabled, .form-control[readonly] {
    background-color: #eee; }
</style>