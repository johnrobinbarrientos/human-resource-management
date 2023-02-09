<template>
    <div v-if="ready">
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="mb-0 font-size-18">Matches</h4>
            <div class="page-title-right"></div>
        </div>
        <div class="card">
         <div class="card-body">
            <div class="row align-items-right">
                <div class="col-md-6">
                    <h4>Applicants</h4>
                    <p>Recommend the following workers to the company.</p>
                </div>
                <div class="col-md-6 text-right">
                    <button class="btn btn-primary" @click="sendRecommendationToEmployer()">Recommend to Company</button>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table mb-0 table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 40px;">
                            <div style="padding-left:30px; padding-bottom:20px;">
                                <input class="form-check-input" type="checkbox" :id="'select-user-0'" @change="selectAllMatches($event)">
                            </div>
                        </th>
                        <th>Name</th>
                        <th width="90">Status</th>
                        <th width="280">Actions</th>
                        <th width="80">Recommend</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="(match, index) in applicants" :key="index">
                        <td>
                            <div style="padding-left:30px; padding-bottom:20px;">
                                <input @click="toggleSelectJobRecommendation(match)" class="form-check-input" type="checkbox" :id="'select-match-' + match.id" :checked="isJobRecommendationSelected(match)">
                            </div>
                        </td>
                        <th>{{ match.user.first_name }} {{ match.user.last_name }}</th>
                        <th>
                            <template v-if="match.job_recommendation">
                                <span v-if="match.job_recommendation.status == 'waiting_for_candidate'" class="badge badge badge-soft-warning">Pending</span>
                                <span v-else-if="match.job_recommendation.status == 'accepted_by_candidate'" class="badge badge badge-soft-info">Applied</span>
                                <span v-else-if="match.job_recommendation.status == 'rejected_by_candidate'" class="badge badge badge-soft-danger">Rejected</span>
                                <span v-else-if="match.job_recommendation.status == 'waiting_for_employer'" class="badge bg-warning">Pending</span>
                                <span v-else-if="match.job_recommendation.status == 'accepted_by_employer'" class="badge bg-success">Hired</span>
                                <span v-else-if="match.job_recommendation.status == 'rejected_by_employer'" class="badge bg-danger">Rejected</span>
                                <span v-else>{{ match.job_recommendation.status }}</span>
                            </template>
                            <template v-else><span class="badge badge-soft-info">Available</span></template>
                        </th>
                        <th class="text-center">
                            <button @click="OPEN_MODAL('#modal-candidate-resume'); setData(match.user);" style="border-radius:3px; padding:2px 10px; background:#333; color:#fff; font-size:10px; border:none;">VIEW RESUME</button>
                            <button @click="getMatchedList(match.user.id)" style="border-radius:3px; padding:2px 10px; background:#333; color:#fff; font-size:10px; border:none;">VIEW MATHCED SKILLS</button>
                        </th>
                        <th>
                            <button v-if="match.job_recommendation.status == 'accepted_by_candidate'"  @click="recommendCandidate(match)" style="border-radius:3px; padding:2px 10px; background:#1cb841; color:#fff; font-size:10px; border:none;">
                                RECOMMEND 
                            </button>
                            <button v-else  style="border-radius:3px; padding:2px 10px; background:#1cb841; opacity:0.6; cursor:default; color:#fff; font-size:10px; border:none;">
                                RECOMMEND
                            </button>
                        </th>
                    </tr>
                    </tbody>
                </table>
            </div>
            </div>
        </div>

        <!-- Modal Group Form -->
        <div class="modal fade" tabindex="-1" id="modal-skills">
        <div class="modal-dialog modal-md " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5  class="modal-title">Skill Matched</h5>
                    <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-skills');" class="close" data-dismiss="modal" aria-label="Close">
                        <i class="bx bx-x"></i>
                    </a>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table mb-0 table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th width="30">#</th>
                                    <th >Skill</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(skill, index) in matchedSkills" :key="index">
                                    <th>{{ (index + 1) }}</th>
                                    <th>{{ skill.job_type.name }}</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button @click="CLOSE_MODAL('#modal-skills');" type="button" class="btn btn-md btn-light">Close</button>
                </div>
            </div>
        </div>
        </div>

        <div class="modal fade" tabindex="-1" id="modalUserNote">
            <div class="pr-note-wrap">
                <div class="pr-note">
                    <div class="note-header">
                        <span>NOTE:</span>
                        <div class="d-flex align-items-center">
                            <a href="javascript:void(0);" @click="CLOSE_MODAL('#modalUserNote'); resetFormData()" title="Close" class="btn btn-sm d-flex align-items-center btn-outline-danger mr-2"><i class="fas fa-times mr-1"></i> Cancel</a>
                            <a href="javascript:void(0);" @click="CLOSE_MODAL('#modalUserNote'); saveNote()" title="Save" class="btn btn-sm d-flex align-items-center btn-outline-primary" ><i class="far fa-save mr-1"></i> Save</a>
                        </div>
                    </div>
                    <div class="note-body"><textarea class="" cols="30" rows="10" v-model="formdata.note"></textarea></div>
                </div>
            </div>
        </div>

        <!-- Resume -->
        <div class="modal fade" tabindex="-1" id="modal-candidate-resume">
            <div class="modal-dialog modal-md " role="document" style="max-width: 750px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Candidate Resume</h5>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-candidate-resume'); resetFormData();" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="bx bx-x"></i>
                        </a>
                    </div>
                    <div class="modal-body">
                        <template> <Resume :properties="{ candidate_id: formdata.id, fullscreen: true, adminMessaging: true }" :key="'resume-' + formdata.id"></Resume> </template>
                    </div>
                    <!-- <div v-if="formdata.id" class="modal-footer bg-light">
                        <button v-if="formdata.id === null" @click="save()" type="submit" class="btn btn-lg btn-primary d-flex align-items-center">Next <i style="font-size: 13px; margin-left: 6px;" class="fas fa-chevron-right"></i></button>
                        <button v-else @click="update()" type="submit" class="btn btn-lg btn-primary">Save Changes</button>
                    </div> -->
                </div>
            </div>
        </div>

    </div>
</template>

<script>
import Resume from '../resume/Details'

export default {
    name: 'job-matches',
    props: ['properties'],
    data: function () {
        return {
            ready: false,
            post: null,
            recommendedWorkers: [],
            recommendedJobs: [],
            matchedSkills: [],
            formdata : {
                id: null,
                note: '',
            },
            selected_job_recommendations: []
        }
    },
    computed: {
        applicants() {
            var scope = this
            return scope.post.matches.filter((item) => {

                return (item.user.company_id == null && 
                    (item.job_recommendation &&
                        (
                            item.job_recommendation.status == 'accepted_by_candidate' ||
                            item.job_recommendation.status == 'waiting_for_employer' ||
                            item.job_recommendation.status == 'accepted_by_employer' ||
                            item.job_recommendation.status == 'rejected_by_employer'
                        )
                    )
                );

            })
        }
    },
    components: {
        Resume,
    },
    methods: {
        isJobRecommendationSelected: function(data) {
            var scope = this

            var found = scope.selected_job_recommendations.find((row) => {
                return row.id === data.id;
            });

            if (!found) {
                return false;
            } 

            return true
        },
        selectAllMatches: function($event) {
            var scope = this

            if($event.target.checked) {
                for (let i = 0; i < scope.applicants.length; i++) {
                    var current = scope.applicants[i]
                    scope.selected_job_recommendations.push(current)
                }
            } else {
                scope.selected_job_recommendations = []
            }
        },
        toggleSelectJobRecommendation: function(match) {
            var scope = this
            if (!scope.isJobRecommendationSelected(match)) {
                scope.selected_job_recommendations.push(match);
                return
            } 
            var index = scope.selected_job_recommendations.findIndex(x => x.id === match.id);
            // var index = scope.selected_users.indexOf(user.id)
            scope.selected_job_recommendations.splice(index,1)
            return
        },
        recommendCandidate: function (match) {
            var scope = this
            var user = match.user
            var recommendations = [];
            recommendations.push(user)

            window.swal.fire({
                title: 'Are you sure, you want to recommend this job to ' + user.first_name + '?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.value) {
                    var job_post_id = scope.post.id

                    scope.POST('jobs/posts/' + job_post_id + '/candidate-recommendations',{ recommendations: recommendations }).then(res => {
                        if (res.success) {
                            window.swal.fire({
                                icon: "success",
                                text: res.message
                            });

                            match.job_recommendation = res.row
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })

                }
            })

        },
        sendRecommendationToEmployer: function(){
            var scope = this
            var users = scope.selected_job_recommendations
            var recommendations = []
            for (let i = 0; i < users.length; i++) {
                recommendations.push(users[i].user)
            }

            var job_post_id = scope.post.id

            window.swal.fire({
                title: 'Are you sure, you want to recommend this job to ' + recommendations.length + ' Candidates?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.value) {
                    scope.POST('jobs/posts/' + job_post_id + '/candidate-recommendations',{ recommendations: recommendations }).then(res => {
                        if (res.success) {
                            scope.getList(job_post_id)
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })
                }
            })


        },
        recommendWorker: function (match) {
            var scope = this
            var user = match.user

            window.swal.fire({
                title: 'Are you sure, you want to recommend ' + user.first_name + ' to this job?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.value) {
                    var job_post_id = scope.post.id

                    scope.POST('jobs/workers/' + job_post_id + '/recommendations',{ user_id: user.id }).then(res => {
                        if (res.success) {
                            window.swal.fire({
                                icon: "success",
                                text: res.message
                            });
                            match.worker_recommendation = res.row
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })    
                       
                }                              
            })
        },
        getList: function (job_post_id) {
            var scope = this
            scope.posts = [];
            scope.GET('jobs/posts/' + job_post_id + '/matches').then(res => {
                scope.post = res.rows

                scope.recommendedJobs = scope.post.job_recommendations
                scope.recommendedWorkers = scope.post.worker_recommendations
                scope.ready = true
            })
        },
        getMatchedList: function (user_id) {
            var scope = this
            var job_post_id = scope.post.id

            scope.matchedSkills = [];
            scope.OPEN_MODAL('#modal-skills');

            var response = scope.GET('jobs/posts/' + job_post_id + '/matches/' + user_id).then(res => {
                scope.matchedSkills = res.rows
            })
        },
        saveNote: function () {
            var scope = this
            scope.formdata.error = null
            var response = scope.POST('users/' + scope.formdata.id + '/note', scope.formdata).then(res => {
                if (!res.success) {
                   return scope.formdata.error = res.message
                }
 
                scope.getList(scope.$route.params.jobPostID)
                scope.resetFormData();
                scope.CLOSE_MODAL('#modalUserNote');
                
            })       
        },
        setData: function (data) {
            var scope = this
            scope.formdata.id = data.id
            scope.formdata.note = data.note
        },
        resetFormData: function () {
            var scope = this
            scope.formdata.id = null
            scope.formdata.note = ''
        }
    },
    mounted() {
        var scope = this
        var job_post_id = scope.$route.params.jobPostID
        scope.getList(job_post_id);
    }
}
</script>
