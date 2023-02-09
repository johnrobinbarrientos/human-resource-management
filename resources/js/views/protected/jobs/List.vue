<template>
<div v-if="ready">
    <div>
        <div class="d-flex align-items-center justify-content-between">
            <h4 class="mb-0 font-size-18"><b>Upcoming Projects</b></h4>
            <div class="page-title-right">
                <nav class="" aria-label="breadcrumb">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript:void(0);">Jobs</a></li>
                        <li class="active breadcrumb-item" aria-current="page">
                            <a href="javascript:void(0);">List</a>
                        </li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div style="margin-bottom: 17px;">
                        <div class="row m-column-reverse">
                            <div class="col-12 col-md-4">
                                <input @keyup="search()" v-model="keyword" type="text" class="form-control table-search-2" placeholder="Search Project...">
                            </div>
                            <div class="col-12 col-md-8 text-right">
                                <div class="table-options">
                                    <select v-model="pagination.take" @change="getList()" class="form-control per-page" >
                                        <option :value="15">15</option>
                                        <option :value="50">50</option>
                                        <option :value="75">75</option>
                                        <option :value="100">100</option>
                                    </select>
                                    <button v-if="user.type == 'Employer'" class="btn btn-primary" @click="ROUTE({path: '/personnels/requests?create=yes'})">
                                        Request a Personnel
                                    </button>
                                    <button v-if="user.type == 'Admin'" class="btn btn-primary" @click="ROUTE({path: '/jobs/create'})">
                                        Create a Job
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="table-responsive">
                                <table class="table mb-0 table table-striped table-bordered job-list">
                                    <thead>
                                        <tr>
                                            <th width="100" class="text-center">Action</th> 
                                            <th width="120" v-if="user.type == 'Admin'" class="text-center">Is Post Public</th>
                                            <th>Name</th>
                                            <th class="col-location">Location</th>

                                            <th class="col-type">Type</th>
                                            <th class="col-salary">Salary</th>
                                            <template v-if="user.type == 'Admin'">
                                                <th>Matches</th>    
                                                <th>Applicants</th>    
                                            </template>
                                            <template v-if="user.type == 'Candidate'">
                                                <th>Application</th>  
                                            </template>  
                                        </tr>
                                    </thead>
                                    <tbody v-if="posts.length">
                                        <tr v-for="(post,index) in posts" :key="index">
                                                <template v-if="user.type == 'Admin' || user.type == 'Employer'">
                                                    <td class="d-flex justify-content-center" width="70">
                                                    <div class="mx-auto">
                                                        <a @click="ROUTE({path: '/jobs/' + post.id + '/edit'})" href="javascript:void(0)" class="btn btn-warning pr-act-btn">
                                                            <i class='bx bx-edit'></i> <span>Edit</span>
                                                        </a>
                                                    </div>
                                                    </td>
                                                </template>
                                                <template v-else>
                                                     <td class="d-flex justify-content-left" width="300">
                                                    <template v-if="post.application && post.application.status == 'pending'">
                                                        <div class="mx-auto">
                                                            <a @click="selectJobPost(post, 'apply')" href="javascript:void(0)" class="btn btn-warning btn-sm"><i class='bx bx-pencil '></i> Edit Application</a>
                                                            <a @click="remove(post)" href="javascript:void(0)" class="btn btn-danger btn-sm"><i class='bx bx-x-circle'></i> Remove Application</a>
                                                        </div>
                                                    </template>
                                                    <template v-else>
                                                        <div class="mx-auto">
                                                            <a @click="selectJobPost(post, 'apply')" href="javascript:void(0)" class="btn btn-success  btn-sm"><i class='bx bx-check-circle '></i> Send Application</a>
                                                            <a @click="selectJobPost(post,'ignored')" href="javascript:void(0)" class="btn btn-danger  btn-sm"><i class='bx bx-x-circle'></i> Hide Job</a>
                                                        </div>
                                                    </template> 
                                                    </td>
                                                </template> 
                                            
                                            <td width="120" v-if="user.type == 'Admin'">
                                                <div class="mx-auto">
                                                    <div class="custom-control custom-switch custom-switch-md" dir="ltr">
                                                        <input type="checkbox" class="custom-control-input " :id="'job-sw-' + post.id" :checked="post.is_public" @change="togglePostVisibility(post)">
                                                        <label class="custom-control-label" :for="'job-sw-' + post.id">&nbsp;</label>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <!-- <span class="m-ellipsis ellipsis-75px">{{ post.title }}</span>  <span v-if="post.recommended" class="badge badge-success">Recommended</span> -->
                                                <span class="m-ellipsis ellipsis-75px"><a @click="showJob(post)" href="javascript:void(0)">{{ post.title}}</a></span>  <span v-if="post.recommended" class="badge badge-success">Recommended</span>
                                            </td>
                                            <td class="col-location">
                                                <span v-if="post.location">{{ post.location }}</span>
                                                <span v-else>No location</span>
                                            </td>
                                            <td class="col-type">{{ post.type }}</td>
                                            <td class="col-salary">
                                                <span v-if="post.min_hourly_rate || post.max_hourly_rate">
                                                    ${{ post.min_hourly_rate }}/hr to ${{ post.max_hourly_rate }}/hr
                                                </span>
                                                <span v-if="(post.min_hourly_rate || post.max_hourly_rate) && (post.max_hourly_rate || post.max_hourly_rate)">OR</span>
                                                <span v-if="post.max_hourly_rate || post.max_hourly_rate">
                                                    ${{ post.maximum_salary }} to ${{ post.maximum_salary }}
                                                </span>
                                            </td>

                                            <template v-if="user.type == 'Admin'">
                                                <td>
                                                    <button @click="ROUTE({path: '/jobs/' + post.id + '/matches'})" class="btn btn-success pr-act-btn" style="width: 85px">
                                                        <i class="fas fa-eye"></i> View ({{ post.matches }})
                                                    </button>
                                                </td>    
                                                <td>
                                                    <button @click="ROUTE({path: '/jobs/' + post.id + '/applicants'})" class="btn btn-success pr-act-btn" style="width: 85px">
                                                        <i class="fas fa-eye"></i> View ({{ post.applicants }})
                                                    </button>
                                                </td>    
                                            </template>
                                            <template v-if="user.type == 'Candidate'">
                                                <td>
                                                    <span v-if="post.application && post.application.status == 'pending'" class="badge badge-success">Submmited</span>
                                                    <span v-else class="badge badge-soft-dark">None</span>
                                                </td>  
                                            </template>
                              
                                            
                                        </tr>
                                    </tbody>
                                    <tbody v-else>
                                        <td colspan="4" class="p-2">There are no Job Posts for you yet.</td>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                   
                    <div style="padding:10px; padding-top:20px; padding-bottom:0px;">
                        Showing {{  pagination.offset + 1  }} to {{ (pagination.count > pagination.page * pagination.take ? pagination.take : pagination.count) }} of  {{  pagination.count }} entries
                    </div>
                    <nav v-if="pagination.count > 1" class="pagination pagination-rounded justify-content-center mt-4" aria-label="pagination">
                        <ul class="pagination">
                            <li @click="paginate('prev')"  v-bind:class="{'disabled' :  pagination.page <= 1}"  class="page-item" >
                                <a href="javascript:void(0)" class="page-link" aria-label="Previous">
                                    <span aria-hidden="true">‹</span><span class="sr-only">Previous</span>
                                </a>
                            </li>

                            <template v-if="pagination.min > 1">
                                <li @click="paginate(1)" :key="page" class="page-item">
                                    <a href="javascript:void(0)" class="page-link"> 1</a>
                                </li>

                                <li>
                                    <a href="javascript:void(0)" class="page-link"> ...</a>
                                </li>
                            </template>

                            <template  v-for="page in  pagination.pages">
                            <li @click="paginate(page)" :key="page" class="page-item" v-bind:class="{'active' : page ===  pagination.page}">
                                <a  v-if="page >= pagination.min && page <= pagination.max " href="javascript:void(0)" class="page-link">
                                    {{ page }}
                                </a>
                            </li>
                            </template>
                            
                            <li @click="paginate('next')" v-bind:class="{'disabled' :  pagination.page >=  pagination.pages}" class="page-item">
                                <a href="javascript:void(0)" class="page-link" aria-label="Next"><span aria-hidden="true">›</span><span class="sr-only">Next</span></a>
                            </li>
                        </ul>
                    </nav>
                   
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

                        <!-- <div v-if="load_ready" class="modal-body" style="height: calc(100vh - 160px); overflow-y: auto;">
                            <div class="confirm-submit">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="row">
                                                    <div class="col-lg-4">
                                                        <template>
                                                            <div class="row">
                                                                <span>Job Title: {{ job.title}}
                                                                </span>
                                                            </div>
                                                            <div class="row">
                                                                <span>Location: {{ job.location}}
                                                                </span>
                                                            </div>
                                                            <div class="row">
                                                                <span>Type: {{ job.type}}
                                                                </span>
                                                            </div>
                                                            <div class="row">
                                                                <span>Description: <span v-html="job.description"></span>
                                                                </span>
                                                            </div>
                                                            <div class="row">
                                                                <span>Minimum hourly rate: {{ job.min_hourly_rate}}
                                                                </span>
                                                            </div>
                                                            <div class="row">
                                                                <span>Maximum hourly rate: {{ job.max_hourly_rate}}
                                                                </span>
                                                            </div>
                                                            <div class="row">
                                                                <span>Minimum salary: {{ job.minimum_salary}}
                                                                </span>
                                                            </div>
                                                            <div class="row">
                                                                <span>Maximum salary: {{ job.maximum_salary}}
                                                                </span>
                                                            </div>
                                                            <br>
                                                            <div class="row">
                                                                <span>Skills
                                                                </span>
                                                            </div>
                                                            <div v-for="(skill,index) in skills" :key="index">
                                                                <li>{{skill.name}}</li>
                                                            </div>
                                                        </template>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> -->
                        <div v-if="load_ready" class="modal-body">
                            <div class="confirm-submit">
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

                                    <strong class="d-block mb-2">Core Competencies Required:</strong>
                                    <div class="grey-container">
                                    <div v-for="(skill,index) in skills" :key="index">
                                        <li>{{skill.name}}</li>
                                    </div>
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
                        <h5 v-if="action == 'apply'" class="modal-title">Job Application</h5>
                        <h5 v-if="action == 'ignored'" class="modal-title">Ignore Job</h5>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-application');" class="close" data-dismiss="modal" aria-label="Close">
                            <em class="bx bx-x"></em>
                        </a>
                    </div>
                    <div class="modal-body">
                        <form action="#" class="form-validate is-alter">

                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="form-group">
                                        <strong class="form-label" for="application-message">Message</strong>
                                        <div style="margin-top:10px;" class="form-control-wrap">
                                            <textarea v-model="message" class="form-control" id="application-message" rows="4"></textarea>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>                                    
                            
                        </form>
                    </div>
                    <div class="modal-footer bg-light">
                        <button @click="save()" type="button" class="btn btn-md btn-primary">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
</template>

<script>
export default {
    name: 'job-post-list',
    props: ['properties'],
    data: function () {
        return {
            ready: false,
            posts: [],
            selected_post: null,
            action: 'apply',
            message: '',
            keyword: '',
            pagination: {
                loading: true,
                page: 1,
                take: 15,
                count: 1,
                offset: 0,
                pages: 0,
                min: 0,
                max: 0,
                show: 5
            },
            timer: null, // search delay
            job: [],
            skills: [],
            subcat_items: [],

            load_ready: false
        }
    },
    computed: {
        user: function () {
            return this.$store.getters.getAuthenticatedUser 
        },
        editable: function () {
            var scope = this
            if (scope.auth && scope.auth.id == scope.user.id) {
                return true
            } else {
                return false
            }
        }
    },
    components: {
    },
    methods: {
        showJob: function(post) {
            var scope = this
            scope.skills = []

            scope.job = post

            post.skills.forEach(function (post_skill) {
                scope.subcat_items.forEach(function (data) {
                    if(post_skill == data.id){
                        scope.skills.push({
                            name: data.job_type.name,
                        })
                    }
                })
            })

            console.log('skilllss')
            console.log(scope.skills)

            

            scope.load_ready = true
            scope.OPEN_MODAL('#modal-jobdetails-view')
        },
        getSubcatItemList: function () {
            var scope = this

            scope.GET('job-subcategory-items').then(res => {
                console.log('sulooooddd')
                console.log(res.rows)
                scope.subcat_items = res.rows

            })
        },
        remove: function (post) {
            var scope = this
            scope.selected_post = post

            window.swal.fire({
                title: 'Are you sure you want to delete this Job Application?',
                text: 'You won\'t be able to revert this',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.value) {
                    scope.DELETE('jobs/posts/'+ scope.selected_post.id +'/applications', {message: '', action: 'deleted'}).then(res => {
                        if(res.success) {
                            scope.getList();
                        }
                    })      
                }                              
            })
        },
        togglePostVisibility: function (post) {
            var scope = this
            var is_public = (!post.is_public) ? true : false;
            scope.$set(post,'is_public', is_public)

            scope.POST('jobs/posts/'+ post.id +'/visibility', {is_public: is_public}).then(res => {
                if(res.success) {
                    scope.getList();
                } else {
                    alert(res.message)
                }
            })
        },
        selectJobPost: function (post, action = 'apply') {
            var scope = this
            scope.selected_post = post
            scope.OPEN_MODAL('#modal-application');
            scope.action = action
            scope.message = (post.application) ? post.application.message : ''
        },
        save: function () {
            var scope = this

            if (scope.action == 'apply') {
                scope.POST('jobs/posts/'+ scope.selected_post.id +'/applications', {message: scope.message}).then(res => {
                    if(res.success) {
                        scope.getList();
                        scope.CLOSE_MODAL('#modal-application');
                    } else {
                        alert(res.message)
                    }
                })
            } else if (scope.action == 'ignored' || scope.action == 'deleted') {
                scope.DELETE('jobs/posts/'+ scope.selected_post.id +'/applications', {message: scope.message, action: scope.action}).then(res => {
                    if(res.success) {
                        scope.getList();
                        scope.CLOSE_MODAL('#modal-application');
                    }
                })
            }
        },
        getPersonnelRequestList: function () {
            var scope = this
            scope.requests = [];
            scope.GET('personnel/request').then(res => {
                if(!res.success) {
                    return scope.formdata.error = res.message
                }
                scope.requests = res.data
            })
        },
        paginate: function(page) {
            var scope = this
        
            if (page === 'prev') {
                scope.pagination.page = scope.pagination.page - 1
            } else if (page === 'next') {
                scope.pagination.page = scope.pagination.page  + 1
            } else {
                scope.pagination.page = page
            }

            if (scope.pagination.page < 1) {
                scope.pagination.page = 1
                scope.getList()
                return
            } else  if (scope.pagination.page > scope.pagination.pages) {
                scope.pagination.page =  scope.pagination.pages
                scope.getList()
                return
            }

            scope.getList()
        },
        getList: function () {
            var scope = this
            scope.posts = [];
            scope.GET('jobs/posts?keyword=' + scope.keyword  + '&page=' + scope.pagination.page + '&take=' + scope.pagination.take).then(res => {
                scope.posts = res.rows

                console.log('posts')
                console.log(scope.posts)

                scope.pagination.count = res.count
                scope.pagination.offset = ((scope.pagination.page - 1 ) * scope.pagination.take)

                // number of pages to paginate based on number of result count
                scope.pagination.pages = Math.ceil(scope.pagination.count / scope.pagination.take)

                scope.pagination.min = (scope.pagination.page > scope.pagination.show) ? scope.pagination.page - scope.pagination.show : 1;
                var max = (scope.pagination.page + scope.pagination.show)
                scope.pagination.max = (max < scope.pagination.pages) ? max : scope.pagination.pages
                scope.pagination.loading = false

                setTimeout(function(){
                     scope.ready = true
                },100);
            })
        },
        search() {  
            var scope = this
            if (scope.timer) {
                clearTimeout(this.timer);
                scope.timer = null;
            }
            scope.timer = setTimeout(() => {
                scope.getList();
            }, 500);
        }
    },
    mounted() {
        var scope = this
        scope.getList();
        scope.getSubcatItemList()
        scope.getPersonnelRequestList()
    }
}
</script>
<style scoped>
    i.fas.fa-eye {
        font-size: 10px;
    }

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