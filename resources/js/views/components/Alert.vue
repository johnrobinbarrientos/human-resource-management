<template>
    <div>
        <div v-if="$route.query.alert == 'complete-profile' && user.type == 'Candidate'" class="alert alert-success">
            Welcome {{ user.first_name}}, Please complete your profile <a style="font-weight:600; color: #1b654a;" @click="ROUTE({path: '/resume'});" href="javascript:void(0);">here</a>.
        </div>
        <div v-if="$route.query.alert == 'email-changed' && user.type == 'Candidate'" class="alert alert-success">
            Your email has been successfully changed.
        </div>
    </div>
</template>



<script>
export default {
    name: 'alert',
    props: ['type'],
    data: function () {
        return {
        }
    },
    components: {
        
    },
    computed: {
        user: function () {
            return this.$store.getters.getAuthenticatedUser 
        }
    },
    methods: {
        
    },
    mounted() {
        
    }
}
</script>
