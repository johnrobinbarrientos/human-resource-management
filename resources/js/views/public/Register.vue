<template>
    <div id="root">
        <div class="home-btn d-none d-sm-block"><a class="text-dark" href="/"><i class="fas fa-home h2"></i></a></div>
        <div class="account-pages my-5 pt-sm-5">
            <div class="container">
                <div class="justify-content-center row">
                    <div class="col-md-7 col-lg-6 col-xl-6">
                    <div class="overflow-hidden card">
                        <div class="bg-soft-primary">
                            <div class="row">
                                <div class="col-7 col">
                                    <div class="text-primary p-4">
                                        <h4 class="text-primary"><strong>Register</strong></h4>
                                        <p>Create an account at <strong><a style="color:#fff; cursor:poitner;" href="https://primusworkforce.com/">Primus Workforce</a></strong>.</p>
                                        <div style="padding: 10px; border-radius: 50%; background: #fff; display: inline-block;">
                                            <span class="avatar-title rounded-circle bg-light" style="justify-content: left; background-color: #fff !important;">
                                                <a style="color:#fff; cursor:poitner;" href="https://primusworkforce.com/">
                                                    <img :src="icon" style="background: #fff;" alt="" class="rounded-circle" height="34">
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5 align-self-end col">
                                    <img :src="vector" alt="" class="img-fluid">
                                </div>
                            </div>
                        </div>
                        <div class="pt-5 card-body">
                            <div class="p-2" style="padding-top: 0 !important;">
                                <label for="email" class="text-center d-block" style="font-size: 16px; margin-bottom: 20px; font-weight: 600;">Register As</label>
                                <div class="pr-tab-group register-tab-group">
                                    <button @click="toggleRegisterType('Candidate')" v-bind:class="{ active : candidate }" class="btn btn-primary waves-effect waves-light">CANDIDATE</button>
                                    <button @click="toggleRegisterType('Employer')" v-bind:class="{ active : !candidate }" class="btn btn-primary waves-effect waves-light">EMPLOYER</button>
                                </div>
                               
                                <div class="alert alert-danger alert-icon" v-if="formdata.error">
                                    <i class="bx bx-error"></i> <strong>Oops</strong>! 
                                    {{ formdata.error }}
                                </div>
                                <form v-on:submit.prevent="authenticate()" novalidate="" action="#" method="get" class="form-horizontal av-invalid">
                                <div class="form-group">
                                    <div class="form-group">
                                        <label for="email" class="">Email</label>
                                        <input  v-model="formdata.email" name="email" placeholder="Enter email" required="" id="email" type="email" class="form-control is-untouched is-pristine av-invalid form-control" value="">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <div class="form-group">
                                                <label for="password" class="">Password</label>
                                                <input  v-model="formdata.password" name="password" required="" placeholder="Enter Password" id="password" type="password" class="is-untouched is-pristine av-invalid form-control" value="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <div class="form-group">
                                                <label for="password" class="">Confirm Password</label>
                                                <input  v-model="formdata.password2" name="password2" required="" placeholder="Re-Type Password" id="password2" type="password" class="is-untouched is-pristine av-invalid form-control" value="">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div  v-if="formdata.type === 'Employer'" class="form-group">
                                        <label for="companyName" class="">Company Name</label>
                                        <input v-model="formdata.company_name" placeholder="Your Company Name" required="" id="companyName" type="text" class="form-control is-untouched is-pristine av-invalid form-control">
                                </div>

                                <div class="form-group">
                                    <div class="form-group">
                                        <label for="email" class="">First Name</label>
                                        <input  v-model="formdata.first_name" name="firstname" placeholder="Your First Name" required="" id="firstname" type="text" class="form-control is-untouched is-pristine av-invalid form-control" value="">
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <div class="form-group">
                                        <label for="email" class="">Last Name</label>
                                        <input v-model="formdata.last_name" name="lastname" placeholder="Your Last Name" required="" id="lastname" type="text" class="form-control is-untouched is-pristine av-invalid form-control" value="">
                                    </div>
                                </div>
                              

                                <div class="mt-4"><button class="btn btn-primary btn-block waves-effect waves-light" type="submit">Submit</button></div>
                                <div class="mt-4 text-center"><a class="text-muted" href="/auth"><i class="mdi mdi-lock mr-1"></i>Already have an account?</a></div>
                                </form>
                            </div>
                            <div style="margin-top:20px; border-top:1px solid #efefef; padding:5px; padding-top:15px; text-align:center;">
                                <a style="color:#333; cursor:poitner;" href="https://primusworkforce.com/"><i class="bx bx-home-circle"></i> Back to Home Page</a>
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
    import logo from '../../assets/themes/images/hexa-logo.png';
    import icon from '../../assets/themes/images/icon.png';
    import vector from '../../assets/themes/images/vector.png';

    export default {
    name: 'authentication',
    props: ['properties'],
    data: function () {
        return {
            formdata: {
                email: '',
                password: '',
                password2: '',
                first_name: '',
                last_name: '',
                type: 'Candidate',
                company_name: '',
                company_email: '',
                company_address: '',
                error: null
            },
            candidate: true,
            logo,
            icon,
            vector
        }
    },
    components: {
    
    },
    methods: {
        authenticate: function () {
            var scope = this
            scope.formdata.error = null
            scope.axios
            .post(window.API_URL + '/register', scope.formdata)
            .then(response => {
                var data = response.data
                if (data.success) {
                    //scope.$store.dispatch('authenticate',{ token: data.token })
                    location.href='/confirmation-required?email=' + scope.formdata.email
                }
            })
            .catch(function (error) {
                var data = error.response.data
                var code = error.response.status
                scope.formdata.error = data.message
            })
        },
        toggleRegisterType: function(type) {
            var scope = this
            scope.candidate = !scope.candidate
            scope.formdata.type = type
        }
    },
    mounted() {
        var scope = this
        if (scope.$route.query.tab && scope.$route.query.tab.toUpperCase() == 'EMPLOYER') {
            scope.toggleRegisterType('Employer')
        } else {
            scope.toggleRegisterType('Candidate')
        }
    }
}
</script>

<style>
    .logo-link { min-width:120px; }
</style>