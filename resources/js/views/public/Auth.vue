<template>
    <div id="root">
        <div class="home-btn d-none d-sm-block"><a class="text-dark" href="https://primusworkforce.com/"><i class="fas fa-home h2"></i></a></div>
        <div class="account-pages my-5 pt-sm-5">
            <div class="container">
                <div class="justify-content-center row">
                    <div class="col-md-7 col-lg-6 col-xl-6">
                    <div class="overflow-hidden card">
                        <div class="bg-soft-primary">
                            <div class="row">
                                <div class="col-7 col">
                                    <div class="text-primary p-4">
                                        <h4 class="text-primary"><strong>Sign In</strong></h4>
                                        <p>Sign in to continue to <strong><a style="color:#fff;" href="https://primusworkforce.com/">Primus Workforce</a></strong>.</p>
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
                        <div class="pt-4 card-body">
                            <div class="p-2">
                                <div class="alert alert-danger alert-icon" v-if="credentials.error">
                                    <i class="bx bx-error"></i> <strong>Error</strong>! 
                                    {{ credentials.error }}
                                </div>
                                <form v-on:submit.prevent="authenticate()" novalidate="" action="#" method="get" class="form-horizontal av-invalid">
                                <div class="form-group">
                                    <div class="form-group">
                                        <label for="email" class="">Email</label>
                                        <input  v-model="credentials.email" name="email" placeholder="Enter email" required="" id="email" type="email" class="form-control is-untouched is-pristine av-invalid form-control" value="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-group">
                                        <label for="password" class="">Password</label>
                                        <input  v-model="credentials.password" name="password" required="" placeholder="Enter Password" id="password" type="password" class="is-untouched is-pristine av-invalid form-control" value="">
                                    </div>
                                </div>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="customControlInline">
                                    <label class="custom-control-label" for="customControlInline">Remember me</label>
                                </div>
                                <div class="mt-3"><button class="btn btn-primary btn-block waves-effect waves-light" type="submit">Log In</button></div>
                                <div class="mt-4 text-center"><a class="text-muted" href="/register"><i class="mdi mdi-account-plus mr-1"></i> Dont have an account? <span style="color: var(--primus-orange)">Register here</span></a></div>

                                <div class="mt-2 text-center"><a class="text-muted" href="/forgot-password"><i class="mdi mdi-lock mr-1"></i> Forgot your password?</a></div>
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
            credentials: {
                email: '',
                password: '',
                error: null
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
        authenticate: function () {
            var scope = this
            scope.credentials.error = null
            scope.axios
            .post(window.API_URL + '/login', scope.credentials)
            .then(response => {
                var data = response.data
                
                if (data.success) {
                    scope.$store.dispatch('authenticate',{ token: data.token, redirect: scope.redirect })
                }
            })
            .catch(function (error) {
                var data = error.response.data
                var code = error.response.status
                scope.credentials.error = 'Authentication Failed, ' + data.message
            })
        }
    },
    mounted() {
        var scope = this

        if (scope.$route.query.redirect) {
            scope.credentials.error = ' Please login to your account to continue...'
            scope.redirect  = scope.$route.query.redirect
        }
    }
}
</script>

<style>
    .logo-link { min-width:120px; }
    a.text-muted:hover { text-decoration: underline !important; }
</style>