<template>
    <div id="root">
        <div class="home-btn d-none d-sm-block"><a class="text-dark" href="/"><i class="fas fa-home h2"></i></a></div>
        <div class="account-pages my-5 pt-sm-5">
            <div class="container">
                <div class="justify-content-center row">
                    <div class="col-md-7 col-lg-7 col-xl-7">
                    <div class="overflow-hidden card">
                        <div style="padding:65px 40px; text-align:center;">
                            <i style="font-size:55px;" class="text-success bx bx-envelope"></i>
                            <h3 style="margin-top:20px; margin-bottom:20px;"  class="text-center">Verify your Email Address</h3>
                            <p class="text-center">
                                Thank you joining PrimusWorkforce, To start using the platform, please check your inbox and verify your email address <strong>{{ email }}</strong>.
                            </p>
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
            email: '',
            logo,
            icon,
            vector
        }
    },
    components: {
    
    },
    methods: {
        confirm: function () {
            
        }
    },
    mounted() {
        var scope = this
        scope.email = this.$route.query.email
    }
}
</script>

<style>
    .logo-link { min-width:120px; }
</style>