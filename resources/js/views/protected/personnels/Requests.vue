<template>
    <div>
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="mb-0 font-size-18">Personnel Requests</h4>
            <div class="page-title-right">
                <nav class="" aria-label="breadcrumb">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript:void(0);">Personnel</a></li>
                        <li class="active breadcrumb-item" aria-current="page">
                            <a href="javascript:void(0);">Requests</a>
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
                            <div class="row">
                                <div class="col-12 col-md-3">
                                    <input @keyup="search()" v-model="keyword" type="text" class="form-control" placeholder="Search Job Posted...">
                                </div>
                                <div class="col-12 col-md-2">
                                    <select @change="getList()" v-model="show" type="text" class="form-control">
                                        <option value="all">Show All</option>
                                        <option value="with-job">With Job</option>
                                        <option value="without-job">Without Job</option>
                                        <option value="archive">Archive</option>
                                    </select>
                                </div>
                                <div class="col-12 col-md-4 offset-md-3 text-right">
                                    <div class="d-flex justify-content-end">
                                        <select v-model="pagination.take" @change="getList()" class="form-control per-page" >
                                            <option :value="15">15</option>
                                            <option :value="50">50</option>
                                            <option :value="75">75</option>
                                            <option :value="100">100</option>
                                        </select>
                                        <button v-if="user.type === 'Admin'" @click="OPEN_MODAL('#modal-send-client-request')" data-toggle="modal" class="btn btn-primary mr-2 d-flex align-items-center">Send Personnel Request to Client <i class="las la-share-square" style="font-size: 18px; margin-left: 4px;"></i></button>
                                        <button @click="newPersonnelRequest()" class="btn btn-primary" data-toggle="modal">Request Personnel</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table mb-0 table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th width="230" class="text-center">Actions</th>
                                    <th>Date</th>
                                    <th class="text-center">Request ID</th>
                                    <th>Company</th>
                                    <th>Company Email</th>
                                    <th>Job Location</th>
                                    <th>Work Site Name</th>
                                    <th>Jobs</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="(request,index) in requests" :key="index">
                                    <td class="text-center" width="230">
                                        <div class="d-flex justify-content-center">
                                            <button @click="viewPersonnelRequest(request)" v-bind:class="'request-view-' + request.id" type="button"  class="btn btn-success btn-sm pr-act-btn mr-2">
                                                <i class="las la-eye"></i> View
                                            </button>
                                            <button @click="updatePersonnelRequest(request)" type="button"  class="btn btn-warning btn-sm pr-act-btn mr-2">
                                                <i class="bx bx-edit"></i> Edit
                                            </button>
                                            <button v-if="show != 'archive'" @click="remove(request.id)" type="button"  class="btn btn-danger btn-sm pr-act-btn mr-2">
                                               <i class="bx bx-archive"></i> Archive
                                            </button>
                                            <button v-if="show == 'archive'" @click="restore(request.id)" type="button"  class="btn btn-success btn-sm pr-act-btn mr-2">
                                               <i class="bx bx-reset"></i> Restore
                                            </button>
                                            <button
                                                v-if="show != 'archive' && user && user.type == 'Admin'"
                                                @click="ROUTE({
                                                    path: '/jobs/create',
                                                    query: {
                                                        personnel_request_id: request.id,
                                                        request_id: request.request_id,
                                                        company: request.company,
                                                        job_location: request.job_location
                                                     },
                                                })"
                                                
                                                type="button"
                                                class="btn btn-secondary btn-sm pr-act-btn text-nowrap"
                                            >
                                                <i class="bx bxs-briefcase"></i>Create Job
                                            </button>
                                        </div>
                                    </td>
                                    <td class="text-nowrap">{{ request.date }}</td>
                                    <td>{{ request.request_id }}</td>
                                    <td>{{ request.company.name }}</td>
                                    <td>{{ request.company.email }}</td>
                                    <td>{{ request.job_location }}</td>
                                    <td>{{ request.site_location }}</td>
                                    <!-- <td width="30">{{ request.jobs.length }}</td> -->
                                    <td>
                                        <span v-if="request.jobs.length <= 0">{{ request.jobs.length}}</span>
                                        <span v-else><a @click="showJobs(request.jobs)" href="javascript:void(0)">{{ request.jobs.length}}</a></span>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
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
                </div><!-- end of card -->


                <!-- Modal Group Form -->
                <div class="modal fade" tabindex="-1" id="modal-send-client-request">
                    <div class="modal-dialog modal-md " role="document" style="max-width:600px;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Send Request To Client</h5>
                                <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-send-client-request'); resetFormData();" class="close" data-dismiss="modal" aria-label="Close">
                                    <em class="bx bx-x"></em>
                                </a>
                            </div>
                            <div class="modal-body">
                                <form action="#" class="form-validate is-alter">

                                    <div class="row">
                                        <div class="col-md-12 col-12">

                                            <div class="form-group">
                                                <strong class="form-label">Recipients</strong>
                                                <select multiple class="recipients-list"></select>
                                            </div>

                                        </div>
                                    </div>

                                </form>
                            </div>
                            <div class="modal-footer bg-light">
                                <button @click="sendRequest()" type="button" class="btn btn-md btn-primary">Send</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Group Form -->
                <div class="modal fade" tabindex="-1" id="modal-request-view">
                    <div class="modal-dialog modal-md " role="document" style="max-width:1000px;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">View Request Form</h5>
                                <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-request-view'); resetFormData();" class="close" aria-label="Close">
                                    <em class="bx bx-x"></em>
                                </a>
                            </div>
                            <div class="modal-body" style="height: calc(100vh - 160px); overflow-y: auto;">
                                <Single :properties="{ request: selected_request, user, test:'tessst', action: 'view' }" :key="'single-' + selected_request.id" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Group Form -->
                <div class="modal fade" tabindex="-1" id="fake-request">
                    <div class="modal-dialog modal-md " role="document"  style="max-width:1000px;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Request Personnel Form</h5>
                                <a href="javascript:void(0)" @click="closePersonnelRequest();" class="close" data-dismiss="modal" aria-label="Close">
                                    <em class="bx bx-x"></em>
                                </a>
                            </div>
                            <div class="card mb-0">
                                <div class="card-body">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
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
                        <div class="confirm-submit" v-for="(job, index) in request_jobs" :key="index">
                                <strong class="d-block mb-1">Basic Details:</strong>
                                <div class="grey-container">
                                        <span>Job Title: {{ job.title}}</span>
                                        <span>Location: {{ job.location}}</span>
                                        <span>Type: {{ job.type}}</span>
                                        <span>Description:</span> <span v-html="job.description"></span>
                                        <br>
                                        <span>Minimum Rate / Hour ($): {{ job.min_hourly_rate}}</span>
                                        <span>Maximum Rate / Hour ($): {{ job.max_hourly_rate}}</span>
                                        <span>Minimum Salary ($): {{ job.minimum_salary}}</span>
                                        <span>Maximum Salary ($): {{ job.maximum_salary}}</span>  
                                </div>
                        </div>
                    </div>



                </div>
            </div>
        </div>

    </div>
</template>

<script>
    import moment from 'moment'
    import Single from './Single'
    import PersonnelForm from './PersonnelForm'
    import FileUploader from '../../components/FileUploader'

    export default {
        name: 'personnel-requests',
        props: ['properties'],
        data: function () {
            return {
                selected_request: { id: 0},
                show_success_notif: false,
                show_error_notif: false,
                requests: [],
                recipients: [],
                mails: [],
                show: 'all',
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
                request_jobs: [],
                load_ready: false
            }
        },
        watch: {

        },
        computed: {
            user: function () {
                var scope = this
                return scope.$store.getters.getAuthenticatedUser
            }
        },
        components: {
            Single,
            PersonnelForm,
            FileUploader,
        },
        filters: {
            fromNow: function (date) {
                return moment(date).fromNow();
            },
            calendar: function (date) {
                return moment(date).calendar();
            },
            MDY: function (date) {
                return moment(date).format('MM/DD/yyyy');
            },
            YMD: function (date) {
                return moment(date).format('YYYY-MM-DD');
            }
        },
        methods: {
            newPersonnelRequest: function () {
                this.$router.push({path: '/personnels/requests/create'})
            },
            updatePersonnelRequest: function (request) {
                this.$router.push({path: '/personnels/requests/' + request.id})
            },
            showJobs: function(jobs) {
                var scope = this
                scope.load_ready = true
                
                scope.request_jobs = jobs
                
                scope.OPEN_MODAL('#modal-jobdetails-view')
            },
            viewPersonnelRequest: function (request) {
                var scope = this
                scope.selected_request = request
                scope.OPEN_MODAL('#modal-request-view')
            },
            remove: function(id) {
                var scope = this

                window.swal.fire({
                    title: 'Are you sure you want to archive this request?',
                    text: 'You won\'t be able to revert this',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, archive it!',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.value) {
                        scope.DELETE('personnel/request/' +  id).then(res => {
                            if(!res.success){
                                scope.formdata.error = res.message
                                scope.show_error_notif = true
                                setTimeout(function(){ scope.show_success_notif = false }, 3000)
                            }else{
                                scope.formdata.success = res.message
                                scope.show_success_notif = true
                                setTimeout(function(){ scope.show_success_notif = false }, 3000)
                                this.getList()
                            }
                        })
                    }
                })
            },
            restore: function(id) {
                var scope = this

                window.swal.fire({
                    title: 'Are you sure you want to restore this request?',
                    text: 'You won\'t be able to revert this',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, restore it!',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.value) {
                        scope.POST('personnel/request/' +  id + '/restore').then(res => {
                            if(!res.success){
                                scope.formdata.error = res.message
                                scope.show_error_notif = true
                                setTimeout(function(){ scope.show_success_notif = false }, 3000)
                            }else{
                                scope.formdata.success = res.message
                                scope.show_success_notif = true
                                setTimeout(function(){ scope.show_success_notif = false }, 3000)
                                this.getList()
                            }
                        })
                    }
                })
            },
            sendRequest: function () {
                var scope = this

                scope.recipients = $('.recipients-list').val()

                scope.POST('personnel/request/send-request', {'recipients' : scope.recipients, template: 'personnel-request'}).then(res => {
                    if(!res.success) {
                        alert('Oops! Something went wrong..')
                    } else {
                        scope.CLOSE_MODAL('#modal-send-client-request')
                    }
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
                scope.requests = [];
                scope.GET('personnel/request?keyword=' + scope.keyword + '&show=' + scope.show + '&page=' + scope.pagination.page + '&take=' + scope.pagination.take).then(res => {
                    if(!res.success) {
                        return scope.formdata.error = res.message
                    }
                    scope.requests = res.data


                    scope.pagination.count = res.count
                    scope.pagination.offset = ((scope.pagination.page - 1 ) * scope.pagination.take)

                    // number of pages to paginate based on number of result count
                    scope.pagination.pages = Math.ceil(scope.pagination.count / scope.pagination.take)

                    scope.pagination.min = (scope.pagination.page > scope.pagination.show) ? scope.pagination.page - scope.pagination.show : 1;
                    var max = (scope.pagination.page + scope.pagination.show)
                    scope.pagination.max = (max < scope.pagination.pages) ? max : scope.pagination.pages
                    scope.pagination.loading = false
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

            scope.getList()
 
            // only Admin can search companies
            if(scope.user && scope.user.type === 'Admin') {
                scope.show_company_select = true

                $('.company-id').select2({
                    ajax: {
                        url: '/api/companies/search?type=Employer&text=company',
                        dataType: 'json',
                        delay: 300,
                        processResults: function (data) {
                            return {
                                results: data.rows
                            };
                        }
                    }
                })

                $('.recipients-list').select2({
                    ajax: {
                        url: '/api/companies/search',
                        dataType: 'json',
                        delay: 300,
                        processResults: function (data) {
                            return {
                                results: data.rows
                            };
                        }
                    }
                })
            }
        }
    }
</script>
<style scoped>
    .pr-paginate { margin-top:30px; text-align:center; }
    .pr-paginate i { font-size:20px; color:#ccc; cursor:pointer; }
    .pr-paginate i.active { color:#f58220;  }
    .pr-paginate i:hover { color:#333;  }

    ul { margin-bottom: .6rem; }
    .card .collapse, .card .collapse.show { transition: .5s; }
    /*.card-header, .card-body { border: 1px solid #ddd; }*/
    .card-header { cursor: pointer; }
    .card-body { border-top: 0; }
    .confirm-submit span,
    .confirm-submit strong { display: block; }
    .confirm-submit strong { font-size: 14px; }
    .details { border: 1px solid rgba(0,0,0,.1); padding: 10px; border-radius: 6px; }
    .step-number { cursor: pointer; }
    table th, label { white-space: nowrap; }

    #snackbar {
        visibility: hidden;
        min-width: 250px;
        margin-left: -125px;
        background-color: var(--success);
        border: 2px solid #333;
        color: #fff;
        text-align: center;
        border-radius: 4px;
        padding: 10px;
        position: fixed;
        z-index: 1;
        left: 50%;
        bottom: 30px;
        font-size: 17px;
    }

    #snackbar.sb-error {background-color: var(--danger);}

    #snackbar.show {
        visibility: visible;
        -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
        animation: fadein 0.5s, fadeout 0.5s 2.5s;
    }

    @-webkit-keyframes fadein {
        from {bottom: 0; opacity: 0;}
        to {bottom: 30px; opacity: 1;}
    }

    @keyframes fadein {
        from {bottom: 0; opacity: 0;}
        to {bottom: 30px; opacity: 1;}
    }

    @-webkit-keyframes fadeout {
        from {bottom: 30px; opacity: 1;}
        to {bottom: 0; opacity: 0;}
    }

    @keyframes fadeout {
        from {bottom: 30px; opacity: 1;}
        to {bottom: 0; opacity: 0;}
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
