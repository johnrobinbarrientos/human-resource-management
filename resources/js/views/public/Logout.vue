<template>
    <div id="root">
        <div class="home-btn d-none d-sm-block"><a class="text-dark" href="/"><i class="fas fa-home h2"></i></a></div>
        <div class="account-pages my-5 pt-sm-5">
            <div class="container">
                <div class="justify-content-center row">
                    <div class="col-md-7 col-lg-6 col-xl-5">
                    <div class="overflow-hidden card">
                        <div class="bg-soft-primary">
                            <div class="row">
                                <div class="col-7 col">
                                    <div class="text-primary p-4">
                                        <h4 class="text-primary"><strong>Sign In</strong></h4>
                                        <p>Sign in to continue to <strong>Suite</strong>.</p>
                                    </div>
                                </div>
                                <div class="col-5 align-self-end col">
                                    <img :src="vector" alt="" class="img-fluid">
                                </div>
                            </div>
                        </div>
                        <div class="pt-0 card-body">
                            <div>
                                <a href="/">
                                    <div class="avatar-md profile-user-wid mb-4"><span class="avatar-title rounded-circle bg-light"><img :src="icon" alt="" class="rounded-circle" height="34"></span></div>
                                </a>
                            </div>
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
                                <div class="mt-4 text-center"><a class="text-muted" href="/pages-forgot-pwd"><i class="mdi mdi-lock mr-1"></i> Forgot your password?</a></div>
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
                email: '',
                password: '',
                error: null
            },
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
                    scope.$store.dispatch('authenticate',{ token: data.token })
                }
            })
            .catch(function (error) {
                var data = error.response.data
                var code = error.response.status
                scope.credentials.error = 'Authentication Failed, Please check your username or password..'
            })
        }
    },
    mounted() {
        
    }
}
</script>

<style>
    .logo-link { min-width:120px; }
</style>