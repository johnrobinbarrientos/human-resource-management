<template>
    <div>
        <div class="row">
            <div class="col-lg-8">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0 font-size-18">Personnel</h4>
                    <div class="page-title-right">
                        <nav class="" aria-label="breadcrumb">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript:void(0);">Personnel</a></li>
                                <li class="active breadcrumb-item" aria-current="page">
                                    <a href="javascript:void(0);">List</a>
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-body">
                        <div style="margin-bottom:10px;">
                            <div class="row">
                                <div class="col-12 col-md-3">
                                    <input @keyup="search()" v-model="keyword" type="text" class="form-control" placeholder="Search Employees...">
                                </div>
                                <div class="col-12 col-md-2 offset-md-7">
                                    <div class="d-flex justify-content-end">
                                        <select v-model="pagination.take" @change="getEmployeeList()" class="form-control per-page" >
                                            <option :value="15">15</option>
                                            <option :value="50">50</option>
                                            <option :value="75">75</option>
                                            <option :value="100">100</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table mb-0 table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Request ID</th>
                                        <th>Fullname</th>    
                                        <th v-if="auth.type == 'Admin'">Company</th>    
                                        <th>Job Title</th>    
                                        <th>Personnel Type</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(employee,index) in employees" :key="index">
                                        <td>
                                            <span v-if="employee.job.personnel_request &&  employee.job.personnel_request.request_id">{{ employee.job.personnel_request.request_id }}</span>
                                            <span v-else>None</span>
                                        </td>
                                        <!-- <td>{{ (employee.user == null) ?  '' : employee.user.first_name }} {{ employee.user.last_name }}</td> -->
                                        <td>
                                            <span v-if="employee.user == null"></span>
                                            <span v-else>{{ employee.user.first_name }} {{ employee.user.last_name }}</span>
                                        </td>
                                        <th v-if="auth.type == 'Admin'">{{ employee.company.name }}</th>
                                        <td><a @click="showJobDetails(employee)" href="javascript:void(0)">{{ employee.job.title }}</a></td>
                                        <td>{{ employee.job.type }}</td>
                                        <td>
                                            <span v-if="employee.status == 'active'" class="badge badge-success">Active</span>
                                            <span v-else-if="employee.status == 'removed'" class="badge badge-danger">Removed</span>
                                            <span v-else-if="employee.status == 'declined'" class="badge badge-danger">Declined (Re-Hiring)</span>
                                            <span v-else class="badge badge-warning">Re-Hiring (waiting for worker's response)</span>
                                        </td>
                                        <td class="d-flex">
                                            <button @click="OPEN_MODAL('#modalCandidateResume'); candidate_id = employee.user.id" class="btn btn-success pr-act-btn mr-1"><i class="las la-eye"></i> View</button>
                                            <button v-if="employee.status == 'active'" @click="removeEmployee(employee, index)" class="btn btn-danger pr-act-btn">
                                                <i class="bx bxs-trash"></i> Remove
                                            </button>
                                            <button style="display:none;"
                                                @click="rehireEmployee(employee, index)"
                                                class="btn btn-secondary pr-act-btn cursor-nodrop mr-1"
                                                :disabled="employee.status == 'rehiring'"
                                            >
                                                <i class="las la-recycle"></i> Re-Hire
                                            </button>
                                            <button
                                                @click="OPEN_MODAL('#modalCandidateRatings');  candidate_id = employee.user.id; job_post_id = employee.job_post_id"
                                                class="btn btn-success pr-act-btn cursor-nodrop">
                                                <i class="las la-star"></i> Rate Me
                                            </button>
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
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" id="modal-jobdetails-view">
            <div class="modal-dialog modal-sm " role="document" style="max-width:1000px;">
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
                                                            <span>Job Title: {{ employee.job.title}}
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Location: {{ employee.job.location}}
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Type: {{ employee.job.type}}
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Description: <span v-html="employee.job.description"></span>
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Minimum hourly rate: {{ employee.job.min_hourly_rate}}
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Maximum hourly rate: {{ employee.job.max_hourly_rate}}
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Minimum salary: {{ employee.job.minimum_salary}}
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Maximum salary: {{ employee.job.maximum_salary}}
                                                            </span>
                                                        </div>
                                                    </template>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-lg-4">
                                                    <div class="row">
                                                        <strong>Request Details</strong>
                                                    </div>
                                                    <br>
                                                    <div class="row">
                                                        <span>Request ID: {{ employee.job.personnel_request.request_id}}
                                                        </span>
                                                    </div>
                                                    <div class="row">
                                                        <span>Request Date: {{ employee.job.personnel_request.date}}
                                                        </span>
                                                    </div>
                                                    <div class="row">
                                                        <span>Job Location: {{ employee.job.personnel_request.job_location}}
                                                        </span>
                                                    </div>
                                                    <div class="row">
                                                        <span>Site Location: {{ employee.job.personnel_request.site_location}}
                                                        </span>
                                                    </div>
                                                    <div class="row">
                                                        <span>Estimated Work Start Date: {{ employee.job.personnel_request.estimated_start_date}}
                                                        </span>
                                                    </div>
                                                    <div class="row">
                                                        <span>Estimated Work End Date: {{ employee.job.personnel_request.estimated_end_date}}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-lg-4">
                                                    <template>
                                                        <div class="row">
                                                            <strong>Company Details</strong>
                                                        </div>
                                                        <br>
                                                        <div class="row">
                                                            <span>Company Name: {{ employee.company.name}}
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Email: {{ employee.company.email}}
                                                            </span>
                                                        </div>
                                                        <div class="row">
                                                            <span>Contact #: {{ employee.company.phone}}
                                                            </span>
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
                        <strong class="d-block mb-1">Basic Details:</strong>
                        <div class="grey-container">
                                <strong>Job Title:</strong> {{ employee.job.title}} <br>
                                <strong>Location:</strong> {{ employee.job.location}} <br>
                                <strong>Type:</strong> {{ employee.job.type}} <br>
                                <strong>Description:</strong> <span v-html="employee.job.description"></span>
                        </div>

                        <strong class="d-block mb-1">Salary:</strong>
                        <div class="grey-container">
                            <strong>Minimum Rate / Hour ($)</strong> {{ employee.job.min_hourly_rate}}<br>
                            <strong>Maximum Rate / Hour ($):</strong> {{ employee.job.max_hourly_rate}}<br>
                            <strong>Minimum Salary ($):</strong> {{ employee.job.minimum_salary}}<br>
                            <strong>Maximum Salary ($):</strong> {{ employee.job.maximum_salary}}<br>          
                        </div>

                        <strong class="d-block mb-1">Request Details:</strong>
                        <div class="grey-container">
                            <strong>Request ID:</strong> {{ employee.job.personnel_request.request_id }}<br>
                            <strong>Request Date:</strong> {{ employee.job.personnel_request.date }}<br>
                            <strong>Job Location:</strong> {{ employee.job.personnel_request.job_location }}<br>
                            <strong>Site Location:</strong> {{ employee.job.personnel_request.site_location }}<br> 
                            <strong>Estimated Work Start Date:</strong> {{ employee.job.personnel_request.estimated_start_date }}<br>    
                            <strong>Estimated Work End Date:</strong> {{ employee.job.personnel_request.estimated_end_date }}<br>           
                        </div>

                        <strong class="d-block mb-1">Company Details:</strong>
                        <div class="grey-container">
                            <strong>Company Name:</strong> {{ employee.company.name }}<br>
                            <strong>Email:</strong> {{ employee.company.email }}<br>
                            <strong>Contact #:</strong> {{ employee.company.phone }}<br>     
                        </div>
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



        <!-- Modal Candidate Resume Form -->
        <div class="modal fade" tabindex="-1" id="modalCandidateRatings">
            <div class="modal-dialog modal-md " role="document" style="max-width: 550px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Write a Review</h5>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modalCandidateRatings'); candidate_id = null" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="bx bx-x"></i>
                        </a>
                    </div>
                    <div class="modal-body">
                        <RatingForm :properties="{ user_id: candidate_id, job_post_id: job_post_id }" :key="'ratings-' + candidate_id"></RatingForm>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</template>

<script>
    import Resume from '../resume/Details'
    import RatingForm from '../ratings/Form'

    export default {
    name: 'employee-list',
    props: ['properties'],
    data: function () {
        return {
            candidate_id: null,
            job_post_id:  null,
            employees: [],
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
            employee: [],
            keyword: '',
            timer: null,
            load_ready: false
        }
    },
    components: {
        Resume,
        RatingForm,
    },
    computed: {
        auth: function () {
            return this.$store.getters.getAuthenticatedUser 
        }
    },
    methods: {
        showJobDetails: function(employee) {
            var scope = this
            scope.employee = employee
            scope.load_ready = true
            scope.OPEN_MODAL('#modal-jobdetails-view')
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
                scope.getEmployeeList()
                return
            } else  if (scope.pagination.page > scope.pagination.pages) {
                scope.pagination.page =  scope.pagination.pages
                scope.getEmployeeList()
                return
            }

            scope.getEmployeeList()
        },
        getEmployeeList: function(){
            var scope = this
            scope.employees = [];
            scope.GET('companies/employees?keyword=' + scope.keyword + '&page=' + scope.pagination.page + '&take=' + scope.pagination.take).then(res => {
                scope.employees = res.rows

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
        removeEmployee: function (employee, index) {
            const scope = this

            window.swal.fire({
                title: 'Are you sure you want to remove this personnel?',
                text: 'You won\'t be able to revert this',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.value) {
                    scope.POST('companies/' + employee.user.company_id + '/employees/' + employee.user.id, { job_post_id : employee.job.id, action: 'remove' })
                    .then(res => {
                        if (!res.success) {
                            alert('Oops something went wrong')
                            return
                        }
                        scope.employees[index].status = 'removed'
                    })
                }
            })
        },
        rehireEmployee: function (employee, index) {
            const scope = this

            window.swal.fire({
                title: 'Are you sure you want to re-Hire this personnel?',
                text: 'You won\'t be able to revert this',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, re-hire him/her.',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.value) {
                    scope.POST('companies/' + employee.company_id + '/employees/' + employee.user.id, { job_post_id : employee.job.id, action: 're-hire' })
                    .then(res => {
                        if (!res.success) {
                            if (!res.msg) {
                                alert('Oops something went wrong.')
                                return
                            }
                            alert(res.msg)
                            return
                        }
                        scope.employees[index].status = 'rehiring'
                    })
                }
            })
        },
        search() {  
            var scope = this
            if (scope.timer) {
                clearTimeout(this.timer);
                scope.timer = null;
            }
            scope.timer = setTimeout(() => {
                scope.getEmployeeList();
            }, 500);
        }
        
    },
    mounted() {
        var scope = this
        scope.getEmployeeList()
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