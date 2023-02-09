<template>
    <div id="root">
        <div class="home-btn d-none d-sm-block"><a class="text-dark" href="/"><i class="fas fa-home h2"></i></a></div>
        <div class="account-pages my-5 pt-sm-5">
            <div class="container">
                <div class="justify-content-center row">
                    <div class="col-md-7 col-lg-6 col-xl-6">
                       <div class="card">
                            <div class="card-body">
                                <div v-if="status == 'loading'">
                                    <br/>
                                    <h2 class="text-center text-info"><i class="bx bx-loader-circle"></i></h2>
                                    <h4 class="text-center text-info">Verifying Acount</h4>
                                    <p class="text-center">This may take few seconds to complete, Please wait..</p>
                                    <br/>
                                </div>

                                <div v-if="status == 'verified'">
                                    <br/>
                                    <h2 class="text-center  text-success"><i class="bx bx-check-circle"></i></h2>
                                    <h4 class="text-center text-success">Your Account has been verified</h4>
                                    <p class="text-center">We are redirecting you to the dashboard, Please wait..</p>
                                    <br/>
                                </div>
                                
                                <div v-if="status == 'error'">
                                    <br/>
                                    <h2 class="text-center text-danger"><i class="bx bx-x-circle"></i></h2>
                                    <h4 class="text-center text-danger">Verification Failed</h4>
                                    <p v-if="reason == 'Email Taken'" class="text-center">An error occur while verifying your account, The email has been email taken.</p>
                                    <p v-else class="text-center">An error occur while verifying your account, this could be due to invalid token or your account has already been verified.</p>
                                    <br/>
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
    name: 'verification',
    props: ['properties'],
    data: function () {
        return {
            status: 'loading',
            reason: '',
        }
    },
    components: {
    
    },
    methods: {
        authenticate: function (token) {
            var scope = this
 
            scope.axios
            .get(window.API_URL + '/auth/email-change-verification/' + token, {})
            .then(response => {
                var data = response.data
                if (data.success) {
                    scope.status = 'verified'
                    setTimeout(function(){
                        scope.$store.dispatch('authenticate',{ token: data.token, redirect: '/dashboard?alert=email-changed' })
                    },1500);
                    
                } else {
                    scope.status = 'error'
                    scope.reason = data.reason
                }
            })
            .catch(function (error) {
                scope.status = 'error'
            })
        }
    },
    mounted() {
        var scope = this
        var token = scope.$route.params.token

        setTimeout(function(){
           scope.authenticate(token)
        },1000);
    }
}
</script>

<style>
    .logo-link { min-width:120px; }
</style>