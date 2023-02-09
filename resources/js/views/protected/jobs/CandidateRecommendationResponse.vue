<template>
    <div v-if="ready">  
        <div class="container">
            <div class="col-md-6 col-12 offset-md-3">
                 <div class="card">
                    <div class="card-body">
                        <div v-if="status == 'loading'">
                            <br/>
                            <h2 class="text-center text-info"><i class="bx bx-loader-circle"></i></h2>
                            <h4 class="text-center text-info">Processing</h4>
                            <p class="text-center">This may take few seconds to complete, Please wait..</p>
                            <br/>
                        </div>
                        <div v-if="status == 'accepted'">
                            <br/>
                            <h2 class="text-center text-success"><i class="bx bx-check-circle"></i></h2>
                            <h4 class="text-center text-success">Candidate Hired</h4>
                            <p class="text-center">You have hired <strong>{{ recommendation.user.first_name }}</strong>, Thank you!</p>
                            <br/>
                        </div>
                        <div v-if="status == 'declined'">
                            <br/>
                            <h2 class="text-center text-warning"><i class="bx bx-x-circle"></i></h2>
                            <h4 class="text-center text-warning">Job Declined</h4>
                            <p class="text-center">You have declined the <strong>{{ recommendation.user.first_name }}</strong>, Thank you for your response!</p>
                            <br/>
                        </div>
                         <div v-if="status == 'error'">
                            <br/>
                            <h2 class="text-center text-danger"><i class="bx bx-x-circle"></i></h2>
                            <h4 class="text-center text-danger">Error</h4>
                            <p class="text-center">An error occur while processing...</p>
                            <br/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'job-candidate-recommendation-response',
    props: ['properties'],
    data: function () {
        return {
            ready: true,
            status: 'loading',
            action: null,
            job_post_id: null,
            token: null,
            recommendation: null,
        }
    },
    computed: {
        user: function () {
            return this.$store.getters.getAuthenticatedUser 
        },
    },
    components: {
        
    },
    methods: {
        accept: function () {
            var scope = this
            var job_post_id = scope.job_post_id
            var token = scope.token
            
            scope.POST('jobs/posts/'+ job_post_id +'/candidate-recommendations/accept/' + token).then(res => {
                if (res.success) {
                    scope.recommendation = res.data
                    scope.status = 'accepted'
                } else {
                    scope.status = 'error'
                }
            })   
        },
        decline: function () {
            var scope = this
            var job_post_id = scope.job_post_id
            var token = scope.token
            
            scope.POST('jobs/posts/'+ job_post_id +'/candidate-recommendations/decline/' + token).then(res => {
                if (res.success) {
                    scope.recommendation = res.data
                    scope.status = 'declined'
                } else {
                   scope.status = 'error'
                }
            })   
        },
    },
    mounted() {
        var scope = this
        scope.action =  (scope.$route.params.action && (scope.$route.params.action == 'accept' || scope.$route.params.action == 'decline')) ? scope.$route.params.action : null;
        scope.job_post_id =  (scope.$route.params.jobPostID) ? scope.$route.params.jobPostID : null;
        scope.token =  (scope.$route.params.token) ? scope.$route.params.token : null;

        if (!scope.action || !scope.job_post_id || !scope.token) {
            scope.status = 'error'
            return;
        }

        setTimeout(function(){
             if (scope.action == 'accept') {
                scope.accept();
            } else if (scope.action == 'decline') {
                scope.decline(); 
            } else {
                scope.status = 'error'
            }
        },1000);

    }
        
}
</script>