<template>
    <div class="page-dashboard">
        
        <div class="row">
            <div class="col-12">
                <div class="page-title-box">
                    <h4>DASHBOARD</h4>
                </div>
            </div>

            <div v-if="auth && auth.type == 'Admin'" class="col-md-12 mb-4">
                <div class="row">
                    <div class="col-md-3">
                        <div class="pr-blurb-panel blurb-primary box-shadow-w-hover">
                        <div class="left">
                            <span><i class="fas fa-chart-line"></i></span>
                        </div>
                        <div class="right">
                            <span class="number">{{ stats.jobs }}</span>
                            <h4>Active Job Listings</h4>
                        </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="blurb-success pr-blurb-panel box-shadow-w-hover">
                        <div class="left">
                            <span><i class="fas fa-eye"></i></span>
                        </div>
                        <div class="right">
                            <span class="number">{{ stats.personnel_requests }}</span>
                            <h4>Personnel Requests</h4>
                        </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="pr-blurb-panel box-shadow-w-hover">
                        <div class="left">
                            <span><i class="fas fa-folder-open"></i></span>
                        </div>
                        <div class="right">
                            <span class="number">{{ stats.employers }}</span>
                            <h4>Companies</h4>
                        </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="pr-blurb-panel blurb-danger box-shadow-w-hover">
                        <div class="left">
                            <span><i class="fas fa-bookmark"></i></span>
                        </div>
                        <div class="right">
                            <span class="number">{{ stats.cadidates }}</span>
                            <h4>Registered Candidates</h4>
                        </div>
                        </div>
                    </div>
                </div>
            </div>

            <div v-if="auth && auth.type == 'Employer'" class="col-md-12 mb-4">
                <div class="row">

                    <div class="col-md-4">
                        <div class="pr-blurb-panel box-shadow-w-hover">
                        <div class="left">
                            <span><i class="fas fa-folder-open"></i></span>
                        </div>
                        <div class="right">
                            <span class="number">{{ employer_stats.personnel_requests }}</span>
                            <h4>Personnel Requests Sent</h4>
                        </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="blurb-success pr-blurb-panel box-shadow-w-hover">
                        <div class="left">
                            <span><i class="fas fa-eye"></i></span>
                        </div>
                        <div class="right">
                            <span class="number">{{ employer_stats.jobs }}</span>
                            <h4>Jobs Created From Requests</h4>
                        </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="pr-blurb-panel blurb-primary box-shadow-w-hover">
                        <div class="left">
                            <span><i class="fas fa-chart-line"></i></span>
                        </div>
                        <div class="right">
                            <span class="number">{{ employer_stats.employees }}</span>
                            <h4>Total Personnel Hired</h4>
                        </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="col-12">
                <div class="row" v-if="auth && auth.type == 'Admin'">
                    <div class="col-md-6 mb-3">
                        <div class="pr-panel recent-activity-panel box-shadow">
                            <div class="panel-head">
                                <h5 class="mb-0" style="font-weight: 700">Recent Personnel Requests</h5>
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                <table class="table table-striped mb-0 table">
                                    <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th>Job Location</th>
                                            <th>Jobs</th>
                                            <th width="200">Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="request in requests" :key="'request-' + request.id">
                                            <td><span>{{ request.request_id }}</span></td>
                                            <td>{{ request.job_location }}</td>
                                            <!-- <td>{{ request.jobs.length }}</td> -->
                                            <td>
                                                <span v-if="request.jobs.length <= 0">{{ request.jobs.length}}</span>
                                                <span v-else><a @click="showJobs(request.jobs)" href="javascript:void(0)">{{ request.jobs.length}}</a></span>
                                            </td>
                                            <td>{{ request.created_at | calendar  }}</td>
                                        </tr>
                                    </tbody>
                                </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">

                        <div class="pr-panel recent-activity-panel box-shadow">
                            <div class="panel-head">
                                <h5 class="mb-0" style="font-weight: 700">Recent Activities</h5>
                            </div>
                            <div class="panel-body p-0">
                                <div style="padding:10px 20px;" v-for="log in logs" :key="'activity-' + log.id"  class="pb-list">
                                    <div class="d-flex align-items-center mr-auto">
                                        <span class="icon-rounded"><i class="las la-save"></i></span>
                                        <p v-html="log.render"></p>
                                    </div>
                                    <div>{{ log.created_at | fromNow  }}</div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- <div class="col-md-12" :class="{ 'col-lg-12' : auth && auth.type == 'Candidate' }"> -->
                <div class="row" v-if="auth && auth.type == 'Employer'">
                    <div class="col-md-7">
                        <div class="pr-panel recent-activity-panel box-shadow mt-2">
                            <div class="panel-head">
                                <h5 class="mb-0" style="font-weight: 700">Personnel Requests</h5>
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                <table class="table table-striped mb-0 table">
                                    <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th class="text-nowrap">Job Location</th>
                                            <th>Jobs</th>
                                            <th width="200">Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="request in requests" :key="'request-' + request.id">
                                            <td><span>{{ request.request_id }}</span></td>
                                            <td>{{ request.job_location }}</td>
                                            <!-- <td>{{ request.jobs.length }}</td> -->
                                            <td>
                                                <span v-if="request.jobs.length <= 0">{{ request.jobs.length}}</span>
                                                <span v-else><a @click="showJobs(request.jobs)" href="javascript:void(0)">{{ request.jobs.length}}</a></span>
                                            </td>
                                            <td>{{ request.created_at | calendar  }}</td>
                                        </tr>
                                    </tbody>
                                </table>
                                </div>
                            </div>
                        </div>

                        <div class="pr-panel recent-activity-panel box-shadow mt-2">
                            <div class="panel-head">
                                <h5 class="mb-0" style="font-weight: 700">Worker Recommendations</h5>
                            </div>
                          
                            <RecommendationList></RecommendationList>
                          
                        </div>
                    </div>


                    <div class="col-md-5">
                        <div class="pr-panel recent-activity-panel box-shadow mt-2">
                            <div class="panel-head">
                                <h5 class="mb-0" style="font-weight: 700">Recently Hired</h5>
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                <table class="table table-striped mb-0 table">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Email Address</th>
                                            <th>Phone</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="worker_recommendation in worker_recommendations" :key="'hired-employee-' + worker_recommendation.id">
                                            <template v-if="worker_recommendation.status == 'accepted'">
                                                <td>{{ worker_recommendation.user.first_name }} {{ worker_recommendation.user.last_name }}</td>
                                                <td>{{ worker_recommendation.user.email  }}</td>
                                                <td>
                                                    <span v-if="worker_recommendation.user.phone">{{ worker_recommendation.user.phone }}</span>
                                                    <span v-else><i style="font-size: 12px">Not yet specified</i></span>
                                                </td>
                                            </template>
                                        </tr>
                                    </tbody>
                                </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div v-if="auth && auth.type == 'Candidate'" class="row">

                    <div class="col-md-6 col-12">
                        <Resume />
                    </div>
                    <div class="col-md-6 col-12">
                        <div v-if="company">
                            <div class="card">
                                <div class="card-body">
                                    <div class="mb-4 card-title">{{ company.employer.company_name }}</div>
                                    <p class="text-muted mb-4">
                                        {{ company.employer.about }}
                                    </p>
                                    <div class="table-responsive">
                                        <table class="table-nowrap mb-0 table">
                                            <tbody>
                                            <tr>
                                                <th scope="row">Phone #:</th>
                                                <td>{{ company.employer.phone }}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">Company E-mail :</th>
                                                <td>{{ company.employer.email }}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">Company Address :</th>
                                                <td>{{ company.employer.company_address }}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-if="!company" class="pr-panel recent-activity-panel box-shadow">
                            <div class="panel-head">
                                <h5 class="mb-0" style="font-weight: 700">Recent Job Recommendations</h5>
                            </div>
                            <div class="panel-body">
                                <RecommendationList></RecommendationList>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <!-- Modal Jobs -->
            <div class="modal fade" tabindex="-1" id="modal-jobdetails-view">
                <div class="modal-dialog modal-md " role="document" style="max-width: 750px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Job Details</h5>
                            <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-jobdetails-view')" class="close" aria-label="Close">
                                <em class="bx bx-x"></em>
                            </a>
                        </div>
                        <div v-if="load_ready" class="modal-body">
                            <div class="confirm-submit" v-for="(job, index) in jobs" :key="index">
                                    <strong class="d-block mb-1">Basic Details:</strong>
                                    <div class="grey-container">
                                            <strong>Job Title:</strong> {{ job.title}} <br>
                                            <strong>Location:</strong> {{ job.location}} <br>
                                            <strong>Type:</strong> {{ job.type}} <br>
                                            <strong>Description:</strong> <span v-html="job.description"></span>
                                    </div>

                                    <strong class="d-block mb-1">Salary:</strong>
                                    <div class="grey-container">
                                        <strong>Minimum Rate / Hour ($):</strong> {{ job.min_hourly_rate}}<br>
                                        <strong>Maximum Rate / Hour ($):</strong> {{ job.max_hourly_rate}}<br>
                                        <strong>Minimum Salary ($):</strong> {{ job.minimum_salary}}<br>
                                        <strong>Maximum Salary ($):</strong> {{ job.maximum_salary}}<br>          
                                    </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- Modal Group Form -->
            <div class="modal fade" tabindex="-1" id="modal-application">
                <div class="modal-dialog modal-md " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Job Application</h5>
                            <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-application');" class="close" data-dismiss="modal" aria-label="Close">
                                <em class="bx bx-x"></em>
                            </a>
                        </div>
                        <div class="modal-body">
                            <form action="#" class="form-validate is-alter">

                                <div class="row">
                                    <div class="col-md-12 col-12">
                                        <div class="form-group">
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
        </div>
    </div>
</template>

<script>
import moment from 'moment'
import Resume from './resume/Details'
import RecommendationList from './jobs/recommendations/RecommendationList'

export default {
    name: 'dashboard',
    props: ['properties'],
    data: function() {
        return {
            logs: [],
            requests: [],
            recommendations: [],
            worker_recommendations: [],
            company: null,
            employees: [],
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
            stats: {
                jobs: 0,
                personnel_requests: 0,
                employers: 0,
                candidates: 0
            },
            employer_stats: {
                jobs: 0,
                personnel_requests: 0,
                employees: 0
            },
            jobs: [],
            load_ready: false
        }
    },
    components: {
        Resume,
        RecommendationList
    },
    filters: {
        fromNow: function (date) {
            return moment(date).fromNow();
        },
        calendar: function (date) {
            return moment(date).calendar();
        }
    },
    computed: {
        auth: function () {
            return this.$store.getters.getAuthenticatedUser
        },
    },
    methods: {
        showJobs: function(jobs) {
            var scope = this
            console.log('tesssst')
            console.log(jobs)

            scope.jobs = jobs
            scope.load_ready = true
            scope.OPEN_MODAL('#modal-jobdetails-view')
        },
        getStats: function(){
            var scope = this
            scope.mails = [];
            scope.GET('stats/counter').then(res => {
               scope.stats.jobs = res.jobs
               scope.stats.personnel_requests = res.personnel_requests
               scope.stats.employers = res.employers
               scope.stats.cadidates = res.cadidates
            })
        },
        getEmployerStats: function(){
            var scope = this
            scope.GET('stats/employer-counter').then(res => {
                if (res.success) {
                    scope.employer_stats = res
                }
            })
        },
        getActivities: function(){
            var scope = this
            scope.mails = [];
            scope.GET('stats/activities').then(res => {
                scope.logs = res.activities
                console.log(scope.logs)
            })
        },
        getPersonnelRequests: function () {
            var scope = this
            scope.requests = [];
            scope.GET('personnel/request?page=1&take=3').then(res => {
                scope.requests = res.data
            })
        },
        getJobRecommendations: function (job_post_id) {
            var scope = this
            scope.recommendations = [];

            var response = scope.GET('jobs/posts/recommendations').then(res => {
                scope.recommendations = res.rows
                scope.ready = true
            })
        },
        getWorkerRecommendations: function (job_post_id) {
            var scope = this
            scope.recommendations = [];

            var response = scope.GET('jobs/workers/recommendations').then(res => {
                scope.worker_recommendations = res.rows
                scope.ready = true
            })
        },
        getCompany: function (job_post_id) {
            var scope = this
            var response = scope.GET('users/'+ scope.auth.id + '/company').then(res => {
                scope.company = res.data
            })
        },
        // getEmployees: function (job_post_id) {
        //     var scope = this
        //     var response = scope.GET('users/'+ scope.auth.id + '/employees').then(res => {
        //         scope.employees = res.rows
        //     })
        // },
        getEmployeeList: function(){
            var scope = this
            scope.employees = [];
            scope.GET('companies/employees?page=1&take=3').then(res => {
                scope.employees = res.rows
            })
        },
        acceptJob: function (recommendation) {
            var scope = this
            var recommendation_id  = recommendation.id

            scope.POST('jobs/posts/' + recommendation_id + '/recommendations/accept',{ message: '' }).then(res => {
                if (res.success) {
                    scope.OPEN_MODAL('#modal-application');
                    scope.getJobRecommendations()
                } else {
                    alert('ERROR:' + res.code)
                }
            }) 
        },
        declineJob: function (recommendation) {
            var scope = this
            var recommendation_id  = recommendation.id
            scope.POST('jobs/posts/' + recommendation_id + '/recommendations/decline',{ message: '' }).then(res => {
                if (res.success) {
                    window.swal.fire({
                        icon: "success",
                        text: res.message
                    });
                    scope.getJobRecommendations()
                } else {
                    alert('ERROR:' + res.code)
                }
            }) 
        },
        acceptWorker: function (recommendation) {
            var scope = this
            
            window.swal.fire({
                title: 'Are you sure, you want to hire ' + recommendation.user.first_name + '?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.value) {
                    var job_post_id = recommendation.job_post_id
                    scope.POST('jobs/workers/' + job_post_id + '/recommendations/' + recommendation.user.id + '/accept').then(res => {
                        if (res.success) {
                            window.swal.fire({
                                icon: "success",
                                text: res.message
                            });

                            recommendation.status = 'accepted'
                            scope.getActivities()
                            scope.getEmployeeList()
                            scope.getWorkerRecommendations()
                            
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })    
                       
                }                              
            })
        },
        declineWorker: function (recommendation) {
            var scope = this
            
            window.swal.fire({
                title: 'Are you sure, you want to decline ' + recommendation.user.first_name + '?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.value) {
                    var job_post_id = recommendation.job_post_id
                    scope.POST('jobs/workers/' + job_post_id + '/recommendations/' + recommendation.user.id + '/decline').then(res => {
                        if (res.success) {
                            window.swal.fire({
                                icon: "success",
                                text: res.message
                            });

                            recommendation.status = 'declined'

                            scope.getActivities()
                            scope.getEmployeeList()
                            scope.getWorkerRecommendations()
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })    
                       
                }                              
            })
        },
        checkResumeRequiredFields: function(){
            var scope = this
            if(scope.resume.location == ''){
               
            }
        },
    },
    mounted() {
        var scope = this
        
        if (scope.auth && scope.auth.type == 'Admin') {
            scope.getActivities()
            scope.getStats()
            scope.getPersonnelRequests()
        } else if (scope.auth && scope.auth.type == 'Employer') {
            scope.getEmployerStats()
            scope.getActivities()
            scope.getPersonnelRequests()
            scope.getEmployeeList()
            scope.getWorkerRecommendations()
        } else if (scope.auth && scope.auth.type == 'Candidate') {

            scope.getActivities()
            scope.getJobRecommendations()
            scope.getCompany()
            // scope.getResume(scope.auth.id)
            scope.checkResumeRequiredFields()
        }
       
    },
}
</script>
<style scoped>

.pr-blurb-panel { display: flex; align-items: center; background: linear-gradient(45deg,#ffb64d,#ffcb80); padding: 25px; border-radius: 4px; cursor: pointer; margin-bottom: 10px; }
.pr-blurb-panel h4 { font-size: 15px; color: #fff; }
.pr-blurb-panel .left span { width: 45px; height: 45px; border-radius: 30px; display: flex; align-items: center; justify-content: center; background: #fff; }
.pr-blurb-panel .left i { color: var(--warning); font-size: 18px; }
.pr-blurb-panel .right { padding-left: 20px; }
.pr-blurb-panel .right .number { font-size: 20px; font-weight: 700; color: #fff; }

.blurb-primary { background: linear-gradient(45deg,#4099ff,#73b4ff); }
/* .blurb-primary .left span { background: var(--faint-primary); } */
.blurb-primary .left i { color: var(--primary); }

.blurb-success { background: linear-gradient(45deg,#2ed8b6,#59e0c5); }
/* .blurb-success .left span { background: var(--faint-success); } */
.blurb-success .left i { color: var(--success); }

.blurb-danger { background: linear-gradient(45deg,#ff5370,#ff869a); }
.blurb-danger .left span { background: var(--faint-danger); }
.blurb-danger .left i { color: var(--danger); }

.box-shadow,
.box-shadow-w-hover { box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,.16); transition: .2s; }
.box-shadow-w-hover:hover { box-shadow: 0 0 25px -5px #9e9c9e; transition: .2s; }



.pr-panel { border-radius: 4px; background: #fff; }
.pr-panel .panel-head { display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #eaeaea; padding: 10px 15px; }
.pr-panel .panel-body { padding: 15px; }
.pr-panel .panel-head button { border: 1px solid #ccc; color: #333; padding: 5px 10px; border-radius: 4px; font-size: 12px; }
.pr-panel .panel-body .pb-list { display: flex; border-bottom: 1px solid #f7f7f7; padding: 20px; align-items: center; }
.pr-panel .panel-body .pb-list p { margin-bottom: 0; margin-right: 15px; }
.pr-panel .panel-body .pb-list .icon-rounded { display: flex; align-items: center; justify-content: center; width: 30px; height: 30px; background: #eee; border-radius: 30px; margin-right: 10px;; }
.pr-panel .panel-body .pb-list .icon-rounded i { font-size: 20px; }

/* .pr-panel .badge:not(.badge-success) { display: inline-block; padding: 7px; background: #eee; border-radius: 30px; font-size: 11px; }
.badge.badge-danger { background: var(--danger) !important; color: #fff; } */
.pr-panel .btn-remove { font-size: 20px; color: var(--danger); }
.pr-panel .highlight { color: var(--primus-orange); font-weight: 600; }


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