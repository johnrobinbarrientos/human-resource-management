<template>
    <div>
        <div class="row">
            <div class="col-lg-6 col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0 font-size-18">Core Competencies</h4>
                    <div class="page-title-right">
                        <nav class="" aria-label="breadcrumb">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript:void(0);">Jobs</a></li>
                                <li class="active breadcrumb-item" aria-current="page">
                                    <a href="javascript:void(0);">Core Competencies</a>
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
                            <div class="row m-column-reverse">
                                <div class="col-lg-4 col-12">
                                    <input @keyup="search()" v-model="keyword" type="text" class="form-control table-search-2" placeholder="Search core competencies...">
                                </div>
                                <div class="col-lg-8 col-12 text-right">
                                    <div class="table-options">
                                        <select v-model="pagination.take" @change="getList()" class="form-control per-page" >
                                            <option :value="15">15</option>
                                            <option :value="50">50</option>
                                            <option :value="75">75</option>
                                            <option :value="100">100</option>
                                        </select>
                                        <button @click="OPEN_MODAL('#modalJobCategories');" class="btn btn-primary" data-toggle="modal">
                                            Add New
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table mb-0 table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th width="160" class="m-width-90 text-center">Actions</th> 
                                        <th>Name</th>
                                        <!--
                                        <th>Job Subcategory</th>
                                        <th>Jobs</th>  
                                        <th>Applicants</th>   
                                        -->
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="type in types" :key="type.id">
                                        <td class="d-flex justify-content-center m-width-90" width="160">
                                            <a href="javascript:void(0)" @click="OPEN_MODAL('#modalJobCategories'); setData(type);" class="btn btn-warning mr-2 table-btn">
                                                <i class='bx bx-edit'></i><span>Edit</span>
                                            </a>
                                            <a href="javascript:void(0)" @click="remove(type.id);" class="btn btn-danger table-btn">
                                                <i class='bx bxs-trash'></i><span>Delete</span>
                                            </a>
                                        </td> 
                                        <th>{{ type.name }}</th>
                                        <!--
                                        <th>50</th>
                                        <th>100</th>  
                                        <th>15</th>    
                                        -->
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

         <!-- Modal JOB CATEGORIES Form -->
        <div class="modal fade" tabindex="-1" id="modalJobCategories">
            <div class="modal-dialog modal-md " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">core competencies</h5>
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
                                        <label class="form-label" for="item-group">Name</label>
                                        <input v-model="formdata.name" class="form-control form-control-lg" type="text" placeholder="Core Competencies">
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
    export default {
    name: 'job-core-competencies',
    props: ['properties'],
    data: function () {
        return {
            formdata: {
                id: null,
                name: '',
                error: null
            },
            types: [],
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
            keyword: '',
            timer: null
        }
    },
    components: {
    
    },
    methods: {
        setData: function (data) {
            var scope = this
            scope.formdata.id = data.id
            scope.formdata.name = data.name
        },
        resetFormData: function() {
            var scope = this
            scope.formdata.id = null
            scope.formdata.name = ''
            scope.formdata.error = null
        }, 
        save: function () {
            var scope = this
            scope.formdata.error = null
            
            scope.POST('job-types',scope.formdata).then(res => {
                if (res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Created',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.types.push(res.data);
                        scope.resetFormData();
                        scope.CLOSE_MODAL('#modalJobCategories');
                    })
                }else{
                    scope.formdata.error = res.message
                    return
                }
            })
        },
        update: function () {
            var scope = this

            scope.PUT('job-types', scope.formdata).then(res => {
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
                    scope.DELETE('job-types/' + id).then(res => {
                        if (res.success) {
                            scope.getList();
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })        
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
            scope.formdata.error = null
            scope.GET('job-types?keyword=' + scope.keyword + '&page=' + scope.pagination.page + '&take=' + scope.pagination.take).then(res => {
                scope.types = res.rows

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
        scope.getList();
    }
}
</script>
