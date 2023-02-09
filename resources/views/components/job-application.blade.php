<script>
    Vue.component('job-application', {
        props: ['job_post_id'],
        data: function () {
            return {
                error: false,
                user: null,
                show_form: false,
                application_status: 'pending',
                application_message: '',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem('KX-PRIMUS')
                },
            }
        },
        methods: {
            getAuthenticateduser: function () {
                var scope = this
                $.ajax({
                    url: "/api/auth/check",
                    type: "GET",
                    headers: scope.headers,
                    success: function (response) {
                        if (response.success) {
                            scope.user = response.user
                        }
                    },
                    error: function(res) {
                        var response = res.responseJSON
                        response.code = res.status
                        
                        if (response.code == 401) {
                            localStorage.removeItem('KX-PRIMUS')
                        }
                    }
                });
            },
            showForm: function () {
                var scope = this
                scope.show_form = true
            },
            submitApplication: function() {
                var scope = this
                $.ajax({
                    url: '/api/jobs/posts/'+ scope.$props.job_post_id +'/applications',
                    type: "POST",
                    data: { message: scope.application_message },
                    headers: scope.headers,
                    success: function (response) {
                       scope.application_status = 'success'
                    },
                    error: function(res) {
                        scope.application_status = 'failed'
                    }
                });
            }
        },
        mounted() {
            var scope = this
            scope.getAuthenticateduser()
        },
        template: `
        <div id="user-menu" class="header-right">
            <template v-if="!user">
                <a :href="'/auth?r={{ url()->current() }}'" class="pr-btn-w-icon-2"><i class="las la-envelope"></i><span>Login to Send Message</span></a>
            </template>
            <template v-else>
                <div v-if="show_form">
                    <div v-if="application_status == 'success'" class="alert alert-success">
                        <strong>Success!</strong> Your Application has been submitted!
                    </div>
                    <div v-if="application_status == 'failed'" class="alert alert-danger">
                        <strong>Error!</strong> An error occur while processing...
                    </div>
                    <div v-if="application_status == 'pending'">
                        <strong>Message</strong>
                        <textarea v-model="application_message" class="form-control" rows="5"></textarea>
                        <div style="padding-top:20px; text-align:right;">
                            <a @click="submitApplication()" href="javascript:void(0);" class="pr-btn-w-icon-2">Submit</span></a>
                        </div>
                    </div>
                </div>
                <a v-else @click="showForm()" href="javascript:void(0);" class="pr-btn-w-icon-2"><i class="las la-envelope"></i><span>Apply for This Job</span></a>
            </template>
        </div>`
    })
</script>