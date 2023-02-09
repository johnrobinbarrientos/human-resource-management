<template>
    <div>
        <div class="row">
            <div class="col-12 col-lg-6 offset-lg-3">
                <div class="card">
                    <div class="card-body"> 
                        <div class="card-title">Job Details</div>
                        
                        <hr/>


                        <div v-if="company" class="form-group">
                            <label class="form-control-label">Company</label>
                             <input class="form-control" type="text" :value="company.name" disabled>
                        </div>

                        <div class="form-group">
                            <label class="form-control-label">Job Title</label>
                            <input class="form-control" type="text" disabled :value="formdata.title">
                        </div>


                        <div v-if="formdata.location" class="form-group">
                            <label class="form-control-label">Location (optional)</label>
                            <input :value="formdata.location" class="form-control" type="text" disabled>

                        </div>


                        <div class="form-group">
                            <label class="form-control-label">Description</label>
                            <p v-html="formdata.description"  class="form-control" disabled>

                            </p>
                        </div>

                        <hr/>

                        <div class="card-title">Salary</div>
                       <div class="row">
                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Minimum Rate / Hour ($) </label>
                                    <input :value="formdata.min_hourly_rate" class="form-control input-mask text-left" style="text-align: right;" disabled>
                                </div>
                                <br/>
                            </div>

                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Maximum Rate / Hour ($) </label>
                                    <input :value="formdata.max_hourly_rate" class="form-control input-mask text-left" style="text-align: right;" disabled>
                                </div>
                                <br/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Minimum Salary ($)</label>
                                    <input :value="formdata.minimum_salary" class="form-control input-mask text-left" style="text-align: right;" disabled>
                                </div>
                                <br/>
                            </div>

                            <div class="col-md-6 col-12">
                                <div class="form-group mb-0">
                                    <label class="form-control-label">Maximum Salary ($)</label>
                                    <input :value="formdata.maximum_salary" class="form-control input-mask text-left" style="text-align: right;" disabled>
                                    <span class="text-muted">e.g "$ 0.00"</span>
                                </div>
                                <br/>
                            </div>
                        </div>

                        
                        <hr/>

                        <div class="mb-4 card-title">Core Competencies</div>

                        <div>
                            <template v-for="(subcategory, index) in subcategories" >
                            <div class="card mb-1 shadow-none">
                                <div class="card-header" :id="'heading-' + index">
                                    <h6 class="m-0">
                                        <a style="font-weight: 600; display:block;" :href="'#collapse-' + index" class="text-dark"
                                        >
                                            {{ subcategory.name }}
                                        </a>
                                    </h6>
                                </div>

                                <div  aria-labelledby="headingOne">
                                    <div class="card-body">
                                        <div class="row">
                                            <div v-for="(type, index) in subcategory.job_types" :key="'type-' + index"  class="col-12 col-sm-6 col-md-4 col-lg-3">
                                                <template v-if="isSkillSelected(type.id)" >
                                                    <div class="form-check mb-3">
                                                        <input class="form-check-input" type="checkbox" value="" :id="'type-' + index" :checked="isSkillSelected(type.id)" disabled>
                                                        <label class="form-check-label" :for="'type-' + index">
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
    </div>
</template>

<style>
.form-control-label { font-weight: 600; }
</style>
<script>
import Form from './Form'
export default {
    name: 'job-details',
    props: ['job_post'],
    data: function () {
        return {
            subcategories: [],
            selected_categories: [],
            company: null,
            formdata: {
                id: null,
                personnel_request_id: null,
                title: '',
                type: '',
                location: '',                
                job_category: '',                
                description: '',  
                min_hourly_rate: '',              
                max_hourly_rate: '',              
                minimum_salary: '',              
                maximum_salary: '',
                skills: [],
                category_ids: [],
                options_categories: []        
            }
        }
    },
    components: {
    
    },
    methods: {
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
            scope.formdata.personnel_request_id = $('.personnel-request-list').val();
            scope.formdata.company_id = (scope.company) ? scope.company.id : 0 ;

            scope.POST('jobs/posts',scope.formdata).then(res => {
                alert(res.message)
                if(res.success) {
                   scope.ROUTE({path: '/jobs/posts'})
                }
                
            })
        },
        update: function () {
            var scope = this

            scope.formdata.category_ids = scope.selected_categories
            scope.formdata.description = $('#summernote').summernote('code');
            scope.formdata.personnel_request_id = $('.personnel-request-list').val();
            scope.formdata.company_id = (scope.company) ? scope.company.id : 0 ;

            scope.PUT('jobs/posts',scope.formdata).then(res => {
                alert(res.message)
                if(res.success) {
                    scope.ROUTE({path: '/jobs/posts'})
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
        })

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

        $('.company-list').on("change", function(e) { 
            var THIS = $(this)
            var data = THIS.select2('data');

            scope.company = (data[0]) ? data[0] : null ;
        });
    }
}
</script>


