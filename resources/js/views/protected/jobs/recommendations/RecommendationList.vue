<template>
    <div v-if="ready">
        <div v-if="user.type == 'Employer'" class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table mb-0 table table-striped table-bordered">
                    <thead>
                        <tr>
                        <th>Worker Name</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <template v-if="recommendations.length">
                            <tr v-for="(recommendation, index) in recommendations" :key="index">
                                <td>{{ recommendation.user.first_name }} {{ recommendation.user.last_name }}</td>
                                    <td>{{ recommendation.job.type }}</td>
                                <td>
                                    <span v-if="recommendation.status == 'waiting_for_employer'" class="badge badge badge-soft-warning">Pending</span>
                                    <span v-else-if="recommendation.status == 'accepted_by_employer'" class="badge bg-success">Hired</span>
                                    <span v-else-if="recommendation.status == 'rejected_by_employer'" class="badge bg-danger">Rejected</span>
                                    <span v-else>{{ recommendation.status }}</span>
                                </td>
                                <td>
                                    <button data-toggle="tooltip" data-placement="top" title="View Resume"  href="javascript:void(0);" @click="OPEN_MODAL('#modalCandidateResume'); candidate_id = recommendation.user.id" style="border-radius:3px; padding:2px 10px; background:#333; color:#fff; font-size:10px; border:none;">
                                        <i class="bx bxs-user-rectangle"></i> View Resume
                                    </button>

                                    <button @click="OPEN_MODAL('#modal-view-job'); setData(recommendation.job_post_id)" style="border-radius:3px; padding:2px 10px; background:#333; color:#fff; font-size:10px; border:none;"><i class="bx bxs-user-rectangle"></i> View Job Details</button>


                                    <template v-if="recommendation.status == 'waiting_for_employer'">
                                        <button @click="acceptCandidate(recommendation)" style="border-radius:3px; padding:2px 10px; background:#1cb841; color:#fff; font-size:10px; border:none;">
                                            Accept 
                                        </button>

                                        <button @click="declineCandidate(recommendation)" style="border-radius:3px; padding:2px 10px; background:#888; color:#fff; font-size:10px; border:none;">
                                            Reject 
                                        </button>
                                    </template>
                                </td>
                            </tr>
                        </template>
                        <template v-else>
                            <div class="p-2">There are no recommendations from the admin at the moment.</div>
                        </template>
                    </tbody>
                    </table>
                </div>
            </div>
        </div>


        <div v-if="user.type == 'Candidate'" class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table mb-0 table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Type</th>
                            <th>Salary</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <template v-if="recommendations.length">
                            <tr v-for="(recommendation, index) in recommendations" :key="index">
                                <td>
                                    <strong>{{ recommendation.job.title }}</strong>
                                    <div v-if="recommendation.job.location">{{ recommendation.job.location }}</div>
                                </td>
                                <td>{{ recommendation.job.type }}</td>
                                <td>
                                    <span v-if="recommendation.job.min_hourly_rate || recommendation.job.max_hourly_rate">
                                        ${{ recommendation.job.min_hourly_rate }}/hr to ${{ recommendation.job.max_hourly_rate }}/hr
                                    </span>
                                    <span v-if="(recommendation.job.min_hourly_rate || recommendation.job.max_hourly_rate) && (recommendation.job.max_hourly_rate || recommendation.job.max_hourly_rate)">OR</span>
                                    <span v-if="recommendation.job.max_hourly_rate || recommendation.job.max_hourly_rate">
                                        ${{ recommendation.job.maximum_salary }} to ${{ recommendation.job.maximum_salary }}
                                    </span>
                                </td>
                                <td>
                                    <span v-if="recommendation.status == 'waiting_for_candidate'" class="badge badge-soft-warning">Pending</span>
                                    <span v-else-if="recommendation.status == 'accepted_by_candidate'" class="badge badge-soft-success">Applied</span>
                                    <span v-else-if="recommendation.status == 'rejected_by_candidate'" class="badge badge-soft-danger">Rejected</span>
                                    <span v-else-if="recommendation.status == 'waiting_for_employer'" class="badge bg-warning">Pending</span>
                                    <span v-else-if="recommendation.status == 'accepted_by_employer'" class="badge bg-success">Hired</span>
                                    <span v-else-if="recommendation.status == 'rejected_by_employer'" class="badge bg-danger">Closed</span>
                                    <span v-else>{{ recommendation.status }}</span>
                                </td>
                                <td>
                                    <button @click="OPEN_MODAL('#modal-view-job'); setData(recommendation.job_post_id)" style="border-radius:3px; padding:2px 10px; background:#333; color:#fff; font-size:10px; border:none;">
                                        View Job 
                                    </button>

                                    <template v-if="recommendation.status == 'waiting_for_candidate'">
                                        <button @click="acceptJob(recommendation)" style="border-radius:3px; padding:2px 10px; background:#1cb841; color:#fff; font-size:10px; border:none;">
                                            Apply 
                                        </button>

                                        <button @click="declineJob(recommendation)" style="border-radius:3px; padding:2px 10px; background:#888; color:#fff; font-size:10px; border:none;">
                                            Reject 
                                        </button>
                                    </template>
                                </td>
                            </tr>
                        </template>
                        <template v-else>
                            <div class="p-2">There are no recommendations from the admin at the moment.</div>
                        </template>
                    </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal Group Form -->
        <div class="modal fade" tabindex="-1" id="modal-application">
            <div class="modal-dialog modal-md " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 v-if="action == 'accept'" class="modal-title">Send Job Application</h5>
                        <h5 v-if="action == 'decline'" class="modal-title">Ignore Job</h5>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-application');" class="close" data-dismiss="modal" aria-label="Close">
                            <em class="bx bx-x"></em>
                        </a>
                    </div>
                    <div class="modal-body">
                        <form action="#" class="form-validate is-alter">

                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="form-group">
                                        <strong style="display:none;" class="form-label" for="application-message">Message</strong>
                                        <div style="margin-top:10px; display:none;" class="form-control-wrap">
                                            <textarea v-model="message" class="form-control" id="application-message" rows="4"></textarea>
                                        </div>

                                        <h4 style="text-align:center; margin-bottom:30px; margin-top:20px;">Thank you for applying the job, please schedule a call with us for further details.</h4>
                                        <!-- Calendly link widget begin -->
                                        <div class="text-center">
                                            <a class="btn btn-md btn-primary" href="javascript:void(0);" onclick="Calendly.initPopupWidget({url: 'https://calendly.com/thinkorion/meeting-orion'});return false;">
                                                <i class="bx bx-phone-call"></i> Schedule Call with Primus
                                            </a>
                                        </div>
                                        <!-- Calendly link widget end -->
                                    </div>
                                </div>
                                
                            </div>                                    
                            
                        </form>
                    </div>
                    <div class="modal-footer bg-light">
                        <button @click="CLOSE_MODAL('#modal-application')" type="button" class="waves-effect waves-light btn btn-outline-dark">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Candidate Resume Form -->
        <div class="modal fade" tabindex="-1" id="modalCandidateResume">
            <div class="modal-dialog modal-md " role="document" style="max-width: 750px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Candidate Resume</h5>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modalCandidateResume'); candidate_id = null" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="bx bx-x"></i>
                        </a>
                    </div>
                    <div class="modal-body">
                        <Resume :properties="{ candidate_id: candidate_id, fullscreen: true, adminMessaging: false }" :key="'resume-' + candidate_id"></Resume>
                    </div>
                </div>
            </div>
        </div>

        <!-- View job modal -->
        <div class="modal fade" tabindex="-1" id="modal-view-job">
            <div class="modal-dialog modal-md " role="document" style="max-width: 750px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Job Details</h5>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-view-job'); resetData()" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="bx bx-x"></i>
                        </a>
                    </div>
                    <div class="modal-body">
                        <strong class="d-block mb-1">Basic Details:</strong>
                        <div class="grey-container">
                            <strong>Company:</strong> {{ recommendation.company.name }}<br>
                            <strong>Job Title:</strong> {{ recommendation.title }}<br>
                            <strong>Location (optional):</strong> {{ recommendation.location }}<br>
                            <br>
                            <strong class="d-block mb-1">Description:</strong> 
                            <span v-html="recommendation.description"></span>
                        </div>

                        <strong class="d-block mb-1">Salary:</strong>
                        <div class="grey-container">
                            <div class="row">
                                <div class="col-md-6 col-12">
                                    <strong>Minimum Rate / Hour ($):</strong> {{ recommendation.min_hourly_rate }}
                                </div>
                                <div class="col-md-6 col-12">
                                    <strong>Minimum Salary ($):</strong> {{ recommendation.minimum_salary }}
                                </div>
                                <div class="col-md-6 col-12">
                                    <strong>Maximum Rate / Hour ($):</strong> {{ recommendation.max_hourly_rate }}
                                </div>
                                <div class="col-md-6 col-12">
                                    <strong>Maximum Salary ($):</strong> {{ recommendation.maximum_salary }}
                                </div>
                            </div>
                        </div>
                        
                        <strong class="d-block mb-2">Core Competencies required:</strong>
                        <template v-for="(subcategory, sc_index) in subcategories" >
                            <div class="card m-0 shadow-none mb-2" :key="'card-'+sc_index" :id="'card-'+sc_index">
                                <div class="card-header" :id="'heading-' + sc_index" style="border: 1px solid #ddd;">
                                    <h6 class="m-0">
                                        <a style="font-weight: 600; display:block;" :href="'#collapse-' + sc_index" class="text-dark">
                                            {{ subcategory.name }}
                                        </a>
                                    </h6>
                                </div>

                                <div aria-labelledby="headingOne">
                                    <div class="card-body" style="border: 1px solid #ddd; border-top: none;">
                                        <div class="row">
                                            <div v-for="(type, jt_index) in subcategory.job_types" :key="'type-' + jt_index"  class="col-12 col-sm-6 col-md-4 col-lg-4">
                                                <template v-if="isSkillSelected(type.id, sc_index)" >
                                                    <div class="mb-1 d-flex align-items-center">
                                                        <i class='bx bxs-check-circle mr-1'></i>
                                                        <label class="form-check-label" :for="'type-' + jt_index">
                                                            {{ type.job_type.name }}
                                                        </label>
                                                    </div>
                                                </template>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            
                            </div>
                        </template>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
import Resume from '../../resume/Details'
export default {
    name: 'job-recommendations-list',
    props: ['properties'],
    data: function () {
        return {
            ready: false,
            recommendations: [],
            message: '',
            action: '',
            selectedRecommendation: null,
            candidate_id: null,
            recommendation: {
                company: {
                    name: ''
                },
                title: '',
                location: '',
                description: '',
                min_hourly_rate: '',
                max_hourly_rate: '',
                minimum_salary: '',
                maximum_salary: '',
                skills: []
            },
            subcategories: [],
        }
    },
    computed: {
        user: function () {
            return this.$store.getters.getAuthenticatedUser 
        },
    },
    components: {
        Resume,
    },
    methods: {
        acceptJob: function (recommendation) {
            var scope = this
            scope.message = ''
            scope.action = 'accept'
            scope.selectedRecommendation = recommendation
            scope.saveJobRecommendationResponse();
        },
        declineJob: function (recommendation) {
            var scope = this
            scope.message = ''
            scope.action = 'decline'
            scope.selectedRecommendation = recommendation
            scope.saveJobRecommendationResponse();
        },
        saveJobRecommendationResponse: function () {
            var scope = this

            if (scope.action == 'accept') {
                var recommendation_id = scope.selectedRecommendation.id
                scope.POST('jobs/posts/' + recommendation_id + '/recommendations/accept',{ message: scope.message }).then(res => {
                    if (res.success) {
                        toastr["success"](res.message)
                        scope.getList()
                    } else {
                       toastr["error"](res.message)
                    }
                }) 
            } else if (scope.action == 'decline') {
                var recommendation_id = scope.selectedRecommendation.id
                scope.POST('jobs/posts/' + recommendation_id + '/recommendations/decline',{ message: scope.message }).then(res => {
                    if (res.success) {
                        toastr["success"](res.message)
                        scope.getList()
                    } else {
                       toastr["error"](res.message)
                    }
                }) 
            }
        },
        acceptCandidate: function (recommendation) {
            var scope = this
            scope.message = ''
            scope.action = 'accept'
            scope.selectedRecommendation = recommendation
            scope.saveJobCandidateRecommendationResponse();
        },
        declineCandidate: function (recommendation) {
            var scope = this
            scope.message = ''
            scope.action = 'decline'
            scope.selectedRecommendation = recommendation
            scope.saveJobCandidateRecommendationResponse();
        },
        saveJobCandidateRecommendationResponse: function () {
            var scope = this

            if (scope.action == 'accept') {
                var recommendation_id = scope.selectedRecommendation.id
                scope.POST('jobs/posts/' + recommendation_id + '/candidate-recommendations/accept',{ message: scope.message }).then(res => {
                    if (res.success) {
                        toastr["success"](res.message)
                        scope.getList()
                    } else {
                       toastr["error"](res.message)
                    }
                }) 
            } else if (scope.action == 'decline') {
                var recommendation_id = scope.selectedRecommendation.id
                scope.POST('jobs/posts/' + recommendation_id + '/candidate-recommendations/decline',{ message: scope.message }).then(res => {
                    if (res.success) {
                        toastr["success"](res.message)
                        scope.getList()
                    } else {
                       toastr["error"](res.message)
                    }
                }) 
            }
        },
        getList: function (job_post_id) {
            var scope = this
            scope.recommendations = [];

            if (job_post_id) {
                var url = (scope.user.type == 'Employer') ? 'jobs/posts/' + job_post_id + '/candidate-recommendations' : 'jobs/posts/' + job_post_id + '/recommendations';
            } else {
                var url = (scope.user.type == 'Employer') ? 'jobs/posts/candidate-recommendations' : 'jobs/posts/recommendations';
            }

            console.log('url used', url)
            
            var response = scope.GET(url).then(res => {
                scope.recommendations = res.rows
                console.log('asdsadsad')
                console.log(scope.recommendations)
                scope.ready = true
            })
        },
        setData: function (job_post_id) {
            var scope = this
            scope.GET('jobs/posts/' + job_post_id).then(res => {
                if (res.success) {
                    scope.recommendation = res.data
                }
            })
        },
        resetData: function () {
            this.recommendation = {}
        },
        getSubcategories: function () {
            var scope = this
            scope.subcategories = []
            scope.GET('job-subcategories').then(res => {
                scope.subcategories = res.rows
                // console.log(scope.subcategories, 'hehe')
            })
        },
        isSkillSelected: function (job_type_id, index) {
            var scope = this

            if (scope.recommendation.skills.includes(job_type_id)) {
                $('#card-'+index).css('display', 'block')
            }
            return scope.recommendation.skills.includes(job_type_id);
        },
    },
    mounted() {
        var scope = this
        var job_post_id = (scope.$route.params.jobPostID) ? scope.$route.params.jobPostID : null

        scope.getList(job_post_id);
        scope.getSubcategories();
    }
}
</script>
<style scoped>
[id*="card-"] {
    display: none;
}

.bxs-check-circle {
    font-size: 17px;
    color: var(--primary);
}

.grey-container {
    border: 1px solid #ddd; border-radius: 4px; padding: 10px 12px; margin-bottom: 20px;
}

.badge.status {  font-size: 11.5px; }
</style>
