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
                                        <h4 class="text-primary"><strong>Forgot Password?</strong></h4>
                                        <p>Please fill in the required details below to retrieve your account.</p>

                                    </div>
                                </div>
                                <div class="col-5 align-self-end col">
                                    <img :src="vector" alt="" class="img-fluid">
                                </div>
                            </div>
                        </div>
                        <div v-if="!credentials.token" class="pt-4 card-body">
                            <div class="p-2">
                                <div class="alert alert-danger alert-icon" v-if="credentials.response.status == 'error'">
                                    <i class="bx bx-error"></i> <strong>Error</strong>! 
                                    {{ credentials.response.message }}
                                </div>
                                <div class="alert alert-success alert-icon" v-if="credentials.response.status == 'success'">
                                    <i class="bx bx-success"></i> <strong>Success</strong>! 
                                    {{ credentials.response.message }}
                                </div>
                                <form v-on:submit.prevent="submit()" novalidate="" action="#" method="get" class="form-horizontal av-invalid">
                                <div class="form-group">
                                    <div class="form-group">
                                        <label for="email" class="">Email</label>
                                        <input  v-model="credentials.email" name="email" placeholder="Enter email" required="" id="email" type="email" class="form-control is-untouched is-pristine av-invalid form-control" value="">
                                    </div>
                                </div>
                                <div class="mt-3"><button class="btn btn-primary btn-block waves-effect waves-light" type="submit">Submit</button></div>
                                <div class="mt-4 text-center"><a class="text-muted" href="/register"><i class="mdi mdi-account-plus mr-1"></i> Dont have an account? <span style="color: var(--primus-orange)">Register here</span></a></div>
                                </form>
                            </div>
                        </div>
                        <div v-else class="pt-4 card-body">
                            <div class="p-2">
                                <div class="alert alert-danger alert-icon" v-if="credentials.response.status == 'error'">
                                    <i class="bx bx-error"></i> <strong>Error</strong>! 
                                    {{ credentials.response.message }}
                                </div>
                                <div class="alert alert-success alert-icon" v-if="credentials.response.status == 'success'">
                                    <i class="bx bx-success"></i> <strong>Success</strong>! 
                                    {{ credentials.response.message }}
                                </div>
                                <form v-on:submit.prevent="resetPassword()" novalidate="" action="#" method="get" class="form-horizontal av-invalid">
                                <div class="form-group">
                                    <div class="form-group">
                                        <label for="email" class="">Password</label>
                                        <input  v-model="credentials.password" name="password" placeholder="New Password" required="" id="password" type="password" class="form-control is-untouched is-pristine av-invalid form-control" value="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-group">
                                        <label for="email" class="">Re-Type Password</label>
                                        <input  v-model="credentials.password2" name="password2" placeholder="Confirm New Password" required="" id="password2" type="password" class="form-control is-untouched is-pristine av-invalid form-control" value="">
                                    </div>
                                </div>
                                <div class="mt-3"><button class="btn btn-primary btn-block waves-effect waves-light" type="submit">Submit</button></div>
                                <div class="mt-4 text-center"><a class="text-muted" href="/register"><i class="mdi mdi-account-plus mr-1"></i> Dont have an account? <span style="color: var(--primus-orange)">Register here</span></a></div>
                                </form>
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
            credentials: {
                token: '',
                password: '',
                password2: '',
                email: '',
                response: {
                    status: '',
                    message: ''
                },
            },
            redirect: null,
            logo,
            icon,
            vector
        }
    },
    components: {
    
    },
    methods: {
        submit: function () {
            var scope = this
            scope.credentials.response.status = ''
            scope.axios
            .post(window.API_URL + '/forgot-password', scope.credentials)
            .then(response => {

                var data = response.data
                var code = response.status

                if (data.success) {
                   scope.credentials.response.status = 'success'
                   scope.credentials.response.message = data.message
                   scope.credentials.email = ''

                } else {
                    scope.credentials.response.status = 'error'
                    scope.credentials.response.message = data.message
                }

            })
            .catch(function (error) {
                var data = error.response.data
                var code = error.response.status

                scope.credentials.response.status = 'error'
                scope.credentials.response.message = data.message
            })
        },
        resetPassword: function () {
            var scope = this
            scope.credentials.response.status = ''
            scope.axios
            .post(window.API_URL + '/forgot-password-complete', scope.credentials)
            .then(response => {

                var data = response.data
                var code = response.status

                if (data.success) {
                   scope.credentials.response.status = 'success'
                   scope.credentials.response.message = data.message
                   scope.credentials.email = ''

                    setTimeout(function(){
                        scope.ROUTE({path: '/auth'});
                    },1200);

                } else {
                    scope.credentials.response.status = 'error'
                    scope.credentials.response.message = data.message
                }

            })
            .catch(function (error) {
                var data = error.response.data
                var code = error.response.status

                scope.credentials.response.status = 'error'
                scope.credentials.response.message = data.message
            })
        }
    },
    mounted() {
        var scope = this

        if (scope.$route.query.token) {
            scope.credentials.token = scope.$route.query.token
        }
    }
}
</script>

<style>
    .logo-link { min-width:120px; }
    a.text-muted:hover { text-decoration: underline !important; }
</style>