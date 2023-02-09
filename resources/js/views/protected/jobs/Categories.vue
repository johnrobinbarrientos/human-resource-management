<template>
    <div>
        <div class="row">
            <div class="col-lg-6 col-12">
                <div class="page-title-box d-flex align-items-center justify-content-between">
                    <h4 class="mb-0 font-size-18">Job Categories</h4>
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
                                    <input @keyup="search()"  v-model="keyword" type="text" class="form-control table-search" placeholder="Search Job Cateogries...">
                                </div>
                                <div class="col-lg-8 text-right">
                                    <a href="javascript:void(0)" @click="OPEN_MODAL('#modalJobCategories');" class="btn btn-primary" data-toggle="modal">
                                        <em class="icon ni ni-plus"></em> <span>Add Category</span>
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
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="category in categories" :key="category.id">
                                        <td class="d-flex justify-content-center" width="160">
                                            <a href="javascript:void(0)" @click="OPEN_MODAL('#modalJobCategories'); setData(category);" class="btn btn-warning pr-act-btn mr-2">
                                                <i class='bx bx-edit'></i> Edit
                                            </a>
                                            <a href="javascript:void(0)" @click="remove(category.id);" class="btn btn-danger pr-act-btn">
                                                <i class='bx bxs-trash'></i> Delete
                                            </a>
                                        </td> 
                                        <th>{{ category.name }}</th>  
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

         <!-- Modal JOB CATEGORIES Form -->
        <div class="modal fade" tabindex="-1" id="modalJobCategories">
            <div class="modal-dialog modal-md " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Job Category</h5>
                        <a href="javascript:void(0)"  @click="CLOSE_MODAL('#modalJobCategories'); resetFormData();" class="close" data-dismiss="modal" aria-label="Close">
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
                                        <input v-model="formdata.name" class="form-control form-control-lg" type="text" placeholder="Category Name">
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
    name: 'job-categories',
    props: ['properties'],
    data: function () {
        return {
            formdata: {
                id: null,
                name: '',
                error: null
            },
            categories: [],
            keyword: '',
            timer: null,
        }
    },
    components: {
    
    },
    methods: {
        resetFormData: function() {
            var scope = this
            scope.formdata.id = null
            scope.formdata.name = ''
            scope.formdata.error = null
        },
        setData: function (data) {
            var scope = this
            scope.formdata.id = data.id
            scope.formdata.name = data.name
        },
        save: function () {
            var scope = this
            scope.formdata.error = null
            
            scope.POST('job-categories',scope.formdata).then(res => {
                if (res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Created',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        scope.categories.push(res.data);
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

            scope.PUT('job-categories', scope.formdata).then(res => {
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
                    scope.DELETE('job-categories/' + id).then(res => {
                        if (res.success) {
                            scope.getList();
                        } else {
                            alert('ERROR:' + res.code)
                        }
                    })        
                }                              
            })
        },
        getList: function () {
            var scope = this
            scope.formdata.error = null
            var response = scope.GET('job-categories?keyword=' + scope.keyword ,scope.formdata).then(res => {
                scope.categories = res.rows
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
