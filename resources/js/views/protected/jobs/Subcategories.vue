<template>
    <div v-if="readyjobCategories && readyjobSubcategories && readyJobTypes">
        <div class="row">
            <div class="col-lg-6 col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0 font-size-18">Job Subcategories</h4>
                    <div class="page-title-right">
                        <nav class="" aria-label="breadcrumb">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript:void(0);">Jobs</a></li>
                                <li class="active breadcrumb-item" aria-current="page">
                                    <a href="javascript:void(0);">Categories</a>
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 col-12">
                <div class="card">
                    <div class="card-body">
                        <div style="margin-bottom: 17px;">
                            <div class="row">
                                <div class="col-lg-4">
                                    <input @keyup="search()" v-model="keyword" type="text" class="form-control table-search" placeholder="Search Job Cateogries...">
                                </div>
                                <div class="col-lg-8 text-right">
                                    <a href="javascript:void(0)" @click="OPEN_MODAL('#modalJobCategories');" class="btn btn-primary" data-toggle="modal">
                                        <em class="icon ni ni-plus"></em> <span>Add Subcategory</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table mb-0 table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th width="160" class="text-center">Actions</th> 
                                        <th>Name</th>
                                        <th>Job Category</th>
                                        <th>Core Competencies</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="subcategory in subcategories" :key="subcategory.id">
                                        <td class="d-flex justify-content-center m-width-90" width="160">
                                            <a href="javascript:void(0)" @click="OPEN_MODAL('#modalJobCategories'); setData(subcategory);" class="btn btn-sm btn-warning mr-2 table-btn">
                                                <i class='bx bx-edit'></i><span>Edit</span>
                                            </a>
                                            <a href="javascript:void(0)" @click="remove(subcategory.id);" class="btn btn-sm btn-danger table-btn">
                                                <i class='bx bxs-trash'></i><span>Delete</span>
                                            </a>                           
                                        </td> 
                                        <td class="text-nowrap"><span class="m-ellipsis ellipsis-100px">{{ subcategory.name }}</span></td>
                                        <td>{{ subcategory.job_category.name }}</td>
                                        <td>
                                            <a
                                                @click="getSubcategoryJobTypes(subcategory.id);
                                                OPEN_MODAL('#modalJobTypes');
                                                selectSubcategory(subcategory);"
                                                href="javascript:void(0);">
                                                    {{ subcategory.job_types.length }}
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal JOB CATEGORIES Form -->
        <div class="modal fade" tabindex="-1" id="modalJobTypes">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Core Competencies</h5>
                        <a href="javascript:void(0)"  @click="CLOSE_MODAL('#modalJobTypes');" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="bx bx-x"></i>
                        </a>
                    </div>
                    <div class="modal-body">

                        <div v-if="selectedJobTypesStatus == 'success'" class="alert alert-success fade show" role="alert">
                            Successfully updated!
                        </div>
                        <div v-if="selectedJobTypesStatus == 'error'" class="alert alert-danger fade show" role="alert">
                            An error occur while saving
                        </div>

                        <div class="row">
                            <div class="col-12 col-md-6">
                                <h4 v-if="selected_job_subcategory">{{ selected_job_subcategory.name }}</h4>
                            </div>
                            <div class="col-12 col-md-6">
                                <input v-model="searchJobTypesKeyword" class="form-control" type="text" placeholder="Enter keyword..">
                            </div>
                        </div>
                        <br/>

                        <table class="table mb-0 table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>Name</th>   
                                    <th width="60">Enable</th> 
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(type, index) in jobtTypes" :key="type.id">
                                    <th>{{ type.name }}</th>  
                                    <td>
                                        <div class="custom-control custom-switch mb-2" dir="ltr">
                                            <input @click="toggleSelectedJobType(type.id)" v-bind:checked="selectedTypes.indexOf(type.id) !== -1" type="checkbox" class="custom-control-input" v-bind:id="'checkbox-' + index">
                                            <label class="custom-control-label" v-bind:for="'checkbox-' + index"></label>
                                        </div>
                                    </td> 
                                </tr>
                            </tbody>
                        </table>
                       
                        <div style="margin-top:10px; float:right;" class="btn-group mr-2" role="group" aria-label="First group">
                           <ul data-test="pagination" class="pagination">
                                <li @click="jobTypesChangePage('prev')"  v-bind:class="{'disabled': (jobTypesPagination.currentPage + 1) === 1}" data-test="page-item" class="page-item"><a data-test="page-link" aria-label="Previous" class="page-link page-link"><span>Previous</span></a></li>
                                <li @click="jobTypesChangePage(index)" v-for="(pageNumber,index) in jobTypesPagination.totalPages" :key="index" v-bind:class="{'active': pageNumber === (jobTypesPagination.currentPage + 1)}" class="page-item" >
                                    <a data-test="page-link" class="page-link page-link">{{ pageNumber }}</a>
                                </li>
                                <li @click="jobTypesChangePage('next')" v-bind:class="{'disabled': (jobTypesPagination.currentPage + 1) === jobTypesPagination.totalPages}" data-test="page-item" class="page-item"><a data-test="page-link" aria-label="Next" class="page-link page-link"><span>Next</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button @click="saveJobSubcategoryItems()" type="submit" class="btn btn-lg btn-primary">Save Changes</button>
                    </div>
                </div>
            </div>
        </div> 


        <!-- Modal JOB TYPES Form -->
        <div class="modal fade" tabindex="-1" id="modalJobCategories">
            <div class="modal-dialog modal-md " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Job Subcategory</h5>
                        <a href="javascript:void(0)"  @click="CLOSE_MODAL('#modalJobCategories');" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="bx bx-x"></i>
                        </a>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger alert-icon" v-if="formdata.error">
                            <i class="bx bx-error"></i> <strong>Error</strong>! 
                            {{ formdata.error }}
                        </div>
                        <form action="#" class="form-validate is-alter">
                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="form-group">
                                        <label class="form-label" for="item-group">Category</label>
                                        <select v-model="formdata.category_id" class="form-control form-control-lg">
                                            <option value="0">Select a Category</option>
                                            <option v-for="(category, index) in categories" :key="index" :value="category.id">{{ category.name }}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-12 col-12">
                                    <div class="form-group">
                                        <label class="form-label" for="item-group">Subcategory Name</label>
                                        <input v-model="formdata.name" class="form-control form-control-lg" type="text" placeholder="Subcategory Name">
                                    </div>
                                </div>
                            </div>                                    
                        </form>
                    </div>
                    <div class="modal-footer bg-light">
                        <button v-if="formdata.id === null" @click="save()" type="submit" class="btn btn-lg btn-primary">Save</button>
                        <button v-else @click="update()" type="submit" class="btn btn-lg btn-primary">Save Changes</button>
                    </div>
                </div>
            </div>
        </div> 
    </div>
</template>



<script>
import moment from 'moment'
export default {
    name: 'job-categories',
    props: ['properties'],
    data: function () {
        return {
            formdata: {
                id: null,
                category_id: 0,
                name: '',
                error: null
            },
            selected_job_subcategory: null,
            selected_job_subcategory_id: null,
            categories: [],
            subcategories: [],
            types: [],
            selectedTypes: [],
            selectedJobTypesReady: false,
            selectedJobTypesStatus: null, //  success, error or null (nothing)
            searchJobTypesKeyword: '',
            readyjobCategories: false,
            readyjobSubcategories: false,
            readyJobTypes: false,
            jobTypesPagination: {
                currentPage: 0,
                itemsPerPage: 10,
                resultCount: 0,
                totalPages: 0,
            },
            keyword: '',
            timer: null,
        }
    },
    watch: {
        readyjobCategories: function (val) {
        
        },
        readyjobSubcategories: function (val) {
        
        },
        readyJobTypes: function (val) {
        
        }
    },
    components: {
    
    },
    computed: {
        jobtTypes : function () {
            var scope = this

            var keyword = scope.searchJobTypesKeyword.toLowerCase()

            var list = scope.types.filter((item) => {
                return (item.name.toLowerCase().indexOf(keyword) > -1);
            })

            scope.jobTypesPagination.resultCount = list.length;
            scope.jobTypesPagination.totalPages = Math.ceil(scope.jobTypesPagination.resultCount / scope.jobTypesPagination.itemsPerPage)
           
            if (scope.jobTypesPagination.currentPage >= scope.totalPages) {
                scope.jobTypesPagination.currentPage = Math.max(0, scope.totalPages - 1);
            }
            var index = scope.jobTypesPagination.currentPage * scope.jobTypesPagination.itemsPerPage;
           
            return list.slice(index, index + scope.jobTypesPagination.itemsPerPage);
        }
    },
    methods: {
        selectSubcategory: function (subcategory) {
            var scope = this
            scope.selected_job_subcategory = subcategory
        },
        resetFormData: function() {
            var scope = this
            scope.formdata.id = null
            scope.formdata.category_id = 0
            scope.formdata.error = null
        },
        setData: function (data) {
            var scope = this
            scope.formdata.id = data.id
            scope.formdata.category_id = data.job_category_id
            scope.formdata.name = data.name
        },
        save: function () {
            var scope = this
            scope.formdata.error = null
            scope.POST('job-subcategories',scope.formdata).then(res => {
                if (res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Created',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.getList();
                        scope.resetFormData();
                        scope.CLOSE_MODAL('#modalJobCategories');
                        scope.resetFormData();
                    })

                } else {
                   scope.formdata.error = res.message
                }

                
                
            })
        },
        update: function () {
            var scope = this

            scope.PUT('job-subcategories', scope.formdata).then(res => {
                if (res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Updated',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.getList()
                        scope.CLOSE_MODAL('#modalJobCategories')
                    })

                } else {
                    alert('ERROR:' + res.code)
                }   
            })
        },
        remove: function (id) {
            var scope = this

            window.swal.fire({
                title: 'Are you sure?',
                text: 'You won\'t be able to revert this',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.value) {
                    scope.DELETE('job-subcategories/' + id).then(res => {
                        if (res.success) {
                            scope.getList();
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })        
                }                              
            })
        },
        getJobCategoryList: function () {
            var scope = this
            var response = scope.GET('job-categories',scope.formdata).then(res => {
                scope.categories = res.rows
                scope.readyjobCategories = true
            })
        },
        getJobTypeList: function () {
            var scope = this
            var response = scope.GET('job-types',scope.formdata).then(res => {
                scope.types = res.rows
                scope.readyJobTypes = true
            })
        },
        getSubcategoryJobTypes: function (subcategory_id) {
            var scope = this

            scope.formdata.error = null
            scope.selected_job_subcategory_id = subcategory_id
            scope.selectedTypes = []
            scope.selectedJobTypesReady = false

            var response = scope.GET('job-subcategories/' + subcategory_id + '/job-types').then(res => {
                var i = 0
                res.rows.forEach(function (data) {
                    scope.selectedTypes.push(data.job_type_id)
                })
            })
        },
        getList: function () {
            var scope = this
            scope.formdata.error = null
            var response = scope.GET('job-subcategories?keyword=' + scope.keyword,scope.formdata).then(res => {
                scope.subcategories = res.rows
                scope.readyjobSubcategories = true
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
        },
        saveJobSubcategoryItems: function() {
            var scope = this
            var subcategory_id = scope.selected_job_subcategory_id
            scope.selectedJobTypesStatus = null
            var response = scope.POST('job-subcategories/' + subcategory_id + '/job-types',{job_type_ids: scope.selectedTypes}).then(res => {
                if (!res.success) {
                    scope.selectedJobTypesStatus = 'error'
                    return;
                }

                scope.selectedJobTypesStatus = 'success'
                scope.getList();
                scope.CLOSE_MODAL('#modalJobTypes');
            })
        },
        jobTypesChangePage: function (page) {
            var scope = this
            if (page == 'next' && (scope.jobTypesPagination.currentPage + 1) < scope.jobTypesPagination.totalPages) { 
                scope.jobTypesPagination.currentPage =  scope.jobTypesPagination.currentPage + 1
                return
            }

            if (page == 'prev' && scope.jobTypesPagination.currentPage > 0) { 
                scope.jobTypesPagination.currentPage =  scope.jobTypesPagination.currentPage - 1
                return
            }

            if (page == 'next' || page == 'prev') {
                return
            }

            scope.jobTypesPagination.currentPage = page
        },
        toggleSelectedJobType: function (id) {
            var scope = this
            var index = scope.selectedTypes.indexOf(id);
            if (index == -1) {
                scope.selectedTypes.push(id)
                return
            } 

            scope.selectedTypes.splice(index, 1);
            return
        }
    },
    mounted() {
        var scope = this
        scope.getJobTypeList();
        scope.getJobCategoryList();
        scope.getList();
        console.log(Math.ceil(108/10))
        console.log(moment().format("YYYY-MM-DD"))
    }
}
</script>
