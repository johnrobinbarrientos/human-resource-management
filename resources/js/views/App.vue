<template>
    <div>
        <div v-if="authenticated" id="layout-wrapper">
            <Header></Header>
            <SideBar></SideBar>
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <Alert></Alert>
                        <router-view></router-view>
                    </div>
                </div>
            </div>
            <footer class="footer">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12">2021 © PRIMUS WORKFORCE</div>
                    </div>
                </div>
            </footer>
        </div>
        <div v-else>
            <router-view></router-view>
        </div>
    </div>
</template>

<script>
    import SideBar from './layouts/SideBar'
    import Header from './layouts/Header'
    import Alert from './components/Alert'
    import logo from '../assets/themes/images/logo.png';

    export default {
    name: 'home',
    props: ['properties'],
    data: function () {
        return {
            logo,
            page_status: 200,
            skills: [],
            show_adminOptions: false,
            avatar: '/images/worker-placeholder.jpg',
            file_resume: null,
            file_tickets: null,
            resume: {
                date_available: '',
                location: '',
                content: '',
            },
        }
    },
    computed: {
        authenticated: function () {
            return this.$store.getters.isAuthenticated
        },
        auth: function () {
            return this.$store.getters.getAuthenticatedUser
        },

    },
    components: {
        SideBar,
        Header,
        Alert
    },
    methods: {
        authenticate: function () {
           
        },

        getResume: function () {
            var scope = this

            scope.skills = []
            var response = scope.GET("users/resume/no-thread").then(response => {
                if (response.success) {
                    scope.resume = response.data
                    scope.avatar = ( response.data.avatar) ? response.data.avatar : scope.avatar
                    scope.file_resume = ( response.data.file_resume) ? response.data.file_resume : null
                    scope.file_tickets = ( response.data.file_tickets) ? response.data.file_tickets : null
                    scope.skills =  response.data.skills
                }

                scope.page_status = response.code

            })
        },

    }

    ,
    mounted() {
        var scope = this

        if (this.$route.meta.protected) {
            this.$store.dispatch('checkAuthenticated',{ test: 'test' })
            this.$store.dispatch('getMenus',{})
        }
    }
}
</script>

<style>
</style>