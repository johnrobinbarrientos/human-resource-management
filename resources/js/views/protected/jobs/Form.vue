<template>
    <div>
        <div class="row">
            <div class="col-12 col-lg-6 offset-lg-3">
                <div class="card">
                    <div class="card-body">
                        <div class="card-title">Job Details</div>
                        <hr/>
                        <template v-if="$route.query.company">
                            <label class="form-control-label">Request ID: </label>
                            {{ $route.query.request_id }}
                            <br>
                            <label class="form-control-label">Company: </label>
                            {{ $route.query.company.name }}
                            <hr class="mt-1"/>
                            <div class="form-group">
                                <label class="form-control-label">Job Title</label>
                                <input v-model="formdata.title" class="form-control" type="text" placeholder="Job Title">
                            </div>

                            <div class="form-group">
                                <label class="form-control-label">Job Type</label>
                                <select v-model="formdata.type" class="form-control" >
                                    <option>Laborer</option>
                                    <option>Operator</option>
                                    <option>Supervisor</option>
                                    <option>Other</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-control-label">Location (optional)</label>
                                <input v-model="formdata.location"  class="form-control" type="text" placeholder="Job Location">
                                <span class="text-muted">Leave this blank if the location is not important</span>
                            </div>
                        </template>
                        <template v-else>
                            <div class="form-group">
                                <label class="form-control-label">Personnel Requests</label>
                                <select class="personnel-request-list"></select>
                            </div>

                            <div class="form-group">
                                <label class="form-control-label">Company</label>
                                <select class="company-list" :disabled="formdata.personnel_request_id && formdata.personnel_request_id > 0"></select>
                            </div>

                            <div class="form-group">
                                <label class="form-control-label">Job Title</label>
                                <input v-model="formdata.title" class="form-control" type="text" placeholder="Job Title">
                            </div>

                            <div class="form-group">
                                <label class="form-control-label">Job Type</label>
                                <select v-model="formdata.type" class="form-control" >
                                    <option>Laborer</option>
                                    <option>Operator</option>
                                    <option>Supervisor</option>
                                    <option>Other</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-control-label">Location (optional)</label>
                                <input v-model="formdata.location"  class="form-control" type="text" placeholder="Job Location">
                                <span class="text-muted">Leave this blank if the location is not important</span>
                            </div>
                        </template>


                        <div class="form-group">
                            <label class="form-control-label">Job Category</label>
                            <select v-model="selected_categories" class="select-job-categories" name="job_post_categories[]" multiple="multiple"></select>
                        </div>


                        <div class="form-group">
                            <label class="form-control-label">Description</label>
                            <!-- <textarea   id="textarea" class="form-control" maxlength="1225" rows="3" ></textarea> -->
                            <textarea style="color:#000;" v-model="formdata.description" id="summernote"></textarea>
                        </div>

                        <hr/>

                        <div class="card-title">Salary</div>
                        <div class="mb-3 card-subtitle">The details from this section are optional, but would help us match the candidate more accurately.</div>

                        <div class="row">
                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Minimum Rate / Hour ($) </label>
                                    <input v-model="formdata.min_hourly_rate" class="form-control input-mask text-left" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'digits': 2, 'digitsOptional': false, 'prefix': '$ ', 'placeholder': '0'" im-insert="true" style="text-align: right;">
                                    <span class="text-muted">e.g "$ 0.00"</span>
                                </div>
                                <br/>
                            </div>

                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Maximum Rate / Hour ($) </label>
                                    <input v-model="formdata.max_hourly_rate" class="form-control input-mask text-left" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'digits': 2, 'digitsOptional': false, 'prefix': '$ ', 'placeholder': '0'" im-insert="true" style="text-align: right;">
                                    <span class="text-muted">e.g "$ 0.00"</span>
                                </div>
                                <br/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Minimum Salary ($)</label>
                                    <input v-model="formdata.minimum_salary" class="form-control input-mask text-left" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'digits': 2, 'digitsOptional': false, 'prefix': '$ ', 'placeholder': '0'" im-insert="true" style="text-align: right;">
                                    <span class="text-muted">e.g "$ 0.00"</span>
                                </div>
                                <br/>
                            </div>

                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Maximum Salary ($)</label>
                                    <input v-model="formdata.maximum_salary" class="form-control input-mask text-left" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'digits': 2, 'digitsOptional': false, 'prefix': '$ ', 'placeholder': '0'" im-insert="true" style="text-align: right;">
                                    <span class="text-muted">e.g "$ 0.00"</span>
                                </div>
                                <br/>
                            </div>
                        </div>


                        <hr/>

                        <div class="row">
                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Start Date </label>
                                    <input v-model="formdata.start_date" class="form-control" type="date">
                                </div>
                            </div>
                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">End Date </label>
                                    <input v-model="formdata.end_date" class="form-control" type="date">
                                </div>
                            </div>
                        </div>

                        <hr/>

                        <div class="mb-4 card-title">Core Competencies</div>

                        <!-- <div id="accordion">
                            <template v-for="(subcategory, index) in subcategories" >
                            <div :key="'collapse-' + index" class="card mb-1 shadow-none">
                                <div class="card-header" :id="'heading-' + index">
                                    <h6 class="m-0">
                                        <a style="font-weight: 600; display:block;" :href="'#collapse-' + index" class="text-dark" data-toggle="collapse"
                                                aria-expanded="true"
                                                aria-controls="collapseOne">
                                            {{ subcategory.name }}
                                        </a>
                                    </h6>
                                </div>

                                <div :id="'collapse-' + index" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
                                    <div class="card-body">
                                        <div class="row">
                                            <div v-for="(type, index) in subcategory.job_types" :key="'type-' + index"  class="col-12 col-sm-6 col-md-4 col-lg-3">
                                                <div class="form-check mb-3">
                                                    <input @click="toggleSkill(type.id)" class="form-check-input" type="checkbox" value="" :id="'type-' + index" :checked="isSkillSelected(type.id)">
                                                    <label class="form-check-label" :for="'type-' + index">
                                                        {{ type.job_type.name }}
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            </template>
                        </div> -->

                        <div id="accordion">
                            <template v-for="(subcategory, index) in subcategories" >
                                <div :key="'collapse-' + index" class="core-competencies-single" v-bind:class="{'open': core_competencies_open ==  subcategory.name}">
                                    <div @click="openCoreCompetencieGroup(subcategory.name)" class="core-competencies-button">
                                        {{ subcategory.name }}
                                        <i class="mdi mdi-arrow-up-drop-circle"></i>
                                        <i class="mdi mdi-arrow-down-drop-circle"></i>
                                    </div>

                                    <div class="core-competencies-options">
                                        <div class="row">
                                            <div v-for="(type, index) in subcategory.job_types" :key="'type-' + index"  class="col-12 col-sm-6 col-md-4 col-lg-3">
                                                <div class="form-check mb-3">
                                                    <input
                                                        @click="toggleSkill(type.id)"
                                                        class="form-check-input"
                                                        type="checkbox" value=""
                                                        :id="'type-' + index"
                                                        :checked="isSkillSelected(type.id)"
                                                    >
                                                    <label class="form-check-label" :for="'type-' + index">
                                                        {{ type.job_type.name }}
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </template>
                        </div>


                        <br/>

                        <button v-if="!formdata.id" @click="save()" class="btn btn-primary btn-lg waves-effect waves-light btn btn-primary">Submit</button>
                        <div v-else>
                            <button @click="update()" class="btn btn-primary btn-lg waves-effect waves-light">Save Changes</button>
                            <button @click="$parent.toggleForm()" class="btn btn-light btn-lg waves-effect waves-light btn">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
.form-control-label { font-weight: 600; }

.core-competencies-single  { margin-bottom:5px; }
.core-competencies-single .core-competencies-button {  cursor:pointer; font-weight:600; position:relative; padding:10px;  background:#f6f6f6; border-radius:3px; }
.core-competencies-single .core-competencies-button i {  font-size:20px; color:#8e8e8e; position:absolute; top:6px; right:10px; }

.core-competencies-single .core-competencies-button i.mdi-arrow-down-drop-circle { display:inline-block; }
.core-competencies-single .core-competencies-button i.mdi-arrow-up-drop-circle { display:none; }

.core-competencies-single.open .core-competencies-button i.mdi-arrow-down-drop-circle { display:none; }
.core-competencies-single.open .core-competencies-button i.mdi-arrow-up-drop-circle { display:inline-block; }

.core-competencies-single .core-competencies-button:hover { background:#efefef;  }
.core-competencies-single .core-competencies-options { display:none; padding: 15px; border: 1px solid #efefef; }
.core-competencies-single.open .core-competencies-options { display:block;  }
</style>
<script>
import Form from './Form'
export default {
    name: 'job-form',
    props: ['job_post'],
    data: function () {
        return {
            subcategories: [],
            selected_categories: [],
            company: null,
            core_competencies_open: 'Class 1 / 3 – Drivers / Operators',
            formdata: {
                id: null,
                personnel_request_id: null,
                title: '',
                type: 'Laborer',
                location: '',
                job_category: '',
                description: '',
                min_hourly_rate: '',
                max_hourly_rate: '',
                minimum_salary: '',
                maximum_salary: '',
                skills: [],
                category_ids: [],
                options_categories: [],
                start_date: '',
                end_date: ''
            }
        }
    },
    components: {

    },
    methods: {
        openCoreCompetencieGroup: function (name) {
            this.core_competencies_open = name
        },
        isSkillSelected: function (job_type_id) {
            var scope = this

            return scope.formdata.skills.includes(job_type_id);
        },
        toggleSkill: function (job_type_id) {
            var scope = this

            if (!scope.isSkillSelected(job_type_id)) {
                scope.formdata.skills.push(job_type_id)
                //scope.POST('users/resume/skill/' + job_type_id).then(res => {})
            } else {
                const index = scope.formdata.skills.indexOf(job_type_id);
                scope.formdata.skills.splice(index, 1);
                //scope.DELETE('users/resume/skill/' + job_type_id).then(res => {})
            }
        },
        getCategories: function () {
            var scope = this
            scope.formdata.error = null
            scope.options_categories = []

            var response = scope.GET('job-categories',scope.formdata).then(res => {
                scope.categories = res.rows

                res.rows.forEach(function (data) {
                    scope.options_categories.push({
                        id: data.id,
                        text: data.name
                    })
                });

                $('.select-job-categories').select2({data: scope.options_categories});
            })
        },
        getSubcategories: function () {
            var scope = this
            scope.subcategories = []
            var response = scope.GET('job-subcategories',scope.formdata).then(res => {
                scope.subcategories = res.rows
            })
        },
        save: function () {
            var scope = this

            scope.formdata.category_ids = scope.selected_categories
            scope.formdata.description = $('#summernote').summernote('code');

            if (!scope.$route.query.personnel_request_id) {
                scope.formdata.personnel_request_id = $('.personnel-request-list').val();
            }
            
            scope.formdata.company_id = (scope.company) ? scope.company.id : 0 ;
            scope.POST('jobs/posts',scope.formdata).then(res => {
                if(res.success) {
                    // toastr["success"](res.message)
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Created',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        setTimeout(function(){
                            scope.ROUTE({path: '/jobs/posts'})
                        },1000)
                    })

                  
                } else {
                    toastr["error"](res.message)
                }
            })
        },
        getJobTypes: function () {
            var scope = this
            var response = scope.GET('job-types',scope.formdata).then(res => {
                scope.job_type = res.rows
            })
        }
        ,
        update: function () {
            var scope = this

            scope.formdata.category_ids = scope.selected_categories
            scope.formdata.description = $('#summernote').summernote('code');
            scope.formdata.personnel_request_id = $('.personnel-request-list').val();
            scope.formdata.company_id = (scope.company) ? scope.company.id : 0 ;

            scope.PUT('jobs/posts',scope.formdata).then(res => {
                if(res.success) {
                    // toastr["success"](res.message)
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Updated',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        setTimeout(function(){
                            scope.ROUTE({path: '/jobs/posts'})
                        },1000)
                    })

                } else {
                    toastr["error"](res.message)
                }
            })
        },
        getJobPostDetails: function (job_post_id) {
            var scope = this
            var response = scope.GET('jobs/posts/' + job_post_id).then(res => {
                if (res.success) {
                    scope.formdata = res.data
                    $('#summernote').summernote('code',res.data.description);



                    scope.company = res.data.company
                    //$('.company-list').val(scope.employer.id).trigger('change');


                    var personnel_request = res.data.personnel_request

                    if (personnel_request) {
                        personnel_request.text = personnel_request.request_id;
                        personnel_request.company = res.data.company

                        var personnel_request_options = [];
                        personnel_request_options.push(personnel_request);

                        $('.personnel-request-list').select2({ data: personnel_request_options });
                        $('.personnel-request-list').val(personnel_request.id).trigger('change');
                    }

                    setTimeout(function(){
                         $('.select-job-categories').val(res.data.category_ids).change();
                    },1000);

                }
            })
        }
    },
    mounted() {
        var scope = this
        
        if (scope.$route.query.personnel_request_id) {
            console.log(scope.$route.query, 'routequery')
            scope.company = scope.$route.query.company

            scope.formdata.personnel_request_id = scope.$route.query.personnel_request_id
            scope.formdata.location = scope.$route.query.job_location
            scope.formdata.company_id = scope.$route.query.company.id
        }

        var job_post_id = (scope.$route.params.jobPostID) ? scope.$route.params.jobPostID : null

        scope.getSubcategories()
        scope.getCategories()


        if (job_post_id) {
            scope.getJobPostDetails(job_post_id)
        }

        $('.select-job-categories').on("change", function(e) {
            scope.selected_categories = $('.select-job-categories').val();
        });

        $('#summernote').summernote({
            height: 150,
            forecolor: '#000'
        });


         $('.personnel-request-list').on("change", function(e) {
            var THIS = $(this)
            var data = THIS.select2('data');

            scope.company = (data[0]) ? data[0].company : null ;


            if (scope.company) {
                scope.company.text = scope.company.name
                var company_options = [];
                company_options.push(scope.company);
                $('.company-list').select2({ data: company_options });
                $('.company-list').val(scope.company.id).trigger('change');
            }

            scope.formdata.personnel_request_id = THIS.val();
        });



        $('.personnel-request-list').select2({
            ajax: {
                url: '/api/personnel-requests/search',
                dataType: 'json',
                delay: 300,
                processResults: function (data) {
                    return {
                        results: data.rows
                    };
                }
            }
        });

        $('.company-list').select2({
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
        });

        $('.job-type-list').select2({
            ajax: {
                url: '/api/job-types',
                dataType: 'json',
                delay: 300,
                processResults: function (data) {
                    return {
                        results: data.rows
                    };


                }
            }
        });


        $('.company-list').on("change", function(e) {
            var THIS = $(this)
            var data = THIS.select2('data');
            console.log(data);
            scope.company = (data[0]) ? data[0] : null ;
        });

        $('.job-type-list').on("change", function(e) {
          // var type  = $('.job-type-list :selected').text();
            var THIS = $(this)
            var data = THIS.select2('data');
            scope.formdata.type = data[0]['text'];
            //console.log(data[0]['text']);



        });
    }
}
</script>


