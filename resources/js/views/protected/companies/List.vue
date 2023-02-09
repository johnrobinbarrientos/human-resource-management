<template>
    <div>
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="mb-0 font-size-18">COMPANIES</h4>
            <div class="page-title-right">
                <nav class="" aria-label="breadcrumb">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript:void(0);">Companies</a></li>
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
                            <div class="row">
                                <div class="col-lg-3">
                                    <input @keyup="search()" v-model="keyword" type="text" class="form-control" placeholder="Search Companies...">
                                </div>
                                <div class="col-lg-9">
                                    <div class="d-flex justify-content-end">
                                        <select v-model="pagination.take" @change="getList()" class="form-control per-page" >
                                            <option :value="15">15</option>
                                            <option :value="50">50</option>
                                            <option :value="75">75</option>
                                            <option :value="100">100</option>
                                        </select>
                                        <button @click="OPEN_MODAL('#modalCompanyForm'); resetFormData()" class="btn btn-primary waves-effect waves-light btn btn-primary">Add Company</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table mb-0 table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th scope="col">Name</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Phone</th>
                                        <th scope="col">Address</th>
                                        <th scope="col">Users</th>
                                        <th width="80">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(company,index) in companies" :key="index">
                                        <td><strong>{{ company.name }}</strong></td>
                                        <td>{{ company.email }}</td>
                                        <td>{{ company.phone }}</td>
                                        <td>{{ company.address }}</td>
                                        <td>{{ company.users }}</td>
                                        <td class="text-center">
                                            <!--
                                            <a href="javascript:void(0);" class="btn btn-success btn-sm text-light" ><i class="bx bx-briefcase-alt"></i></a> 
                                            <a href="javascript:void(0);" class="btn btn-primary btn-sm text-light"  style="background: var(--pink); border-color: var(--pink);"><i class="dripicons-user-group"></i></a> 
                                            -->
                                            <a href="javascript:void(0);" @click="OPEN_MODAL('#modalCompanyForm'); setData(company);" class="btn btn-warning btn-sm pr-act-btn" title="Edit">
                                                <i class="bx bx-edit"></i>Edit
                                            </a>   
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


        <!-- Modal COMPANY FORM -->
        <div class="modal fade" tabindex="-1" id="modalCompanyForm">
            <div class="modal-dialog modal-md " role="document" style="max-width: 750px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 v-if="formdata_company.id" class="modal-title">Edit Company</h5>
                        <h5 v-else class="modal-title">New Company</h5>

                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modalCompanyForm'); " class="close" data-dismiss="modal" aria-label="Close">
                            <i class="bx bx-x"></i>
                        </a>

                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger alert-icon" v-if="formdata_company.error">
                            <i class="bx bx-error"></i> <strong>Error</strong>! 
                            {{ formdata_company.error }}
                        </div>
                        <div class="alert alert-success alert-icon" v-if="formdata_company.success">
                            <i class='bx bxs-check-shield'></i> <strong>Success</strong>! 
                            {{ formdata_company.success }}
                        </div>

                        <div v-if="!formdata_company.success" class="form-group">
                            <div class="row" style="margin-bottom: 10px">
                                <div class="col-lg-2 col-sm-12">
                                    <div class="d-flex align-items-center h-100">
                                        <label class="mb-0" for="companyName">Name:</label>
                                    </div>
                                </div>
                                <div class="col-lg-10 col-sm-12">                        
                                    <input
                                        placeholder="Enter Company Name"
                                        type="text"
                                        class="form-control mb-0"
                                        id="companyName"
                                        autocomplete="off"
                                        required
                                        v-model="formdata_company.company_name"
                                    />
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 10px">
                                <div class="col-lg-2 col-sm-12">
                                    <div class="d-flex align-items-center h-100">
                                        <label class="mb-0" for="companyAddress">Phone:</label>
                                    </div>
                                </div>
                                <div class="col-lg-10 col-sm-12">   
                                    <vue-phone-number-input ref="ref_phone" v-model="formdata_company.phone" default-country-code="CA" :only-countries="['CA', 'US']"/>
                                </div>
                            </div>

                            <div v-if="!formdata_company.id" class="row" style="margin-bottom: 10px">
                                <div class="col-lg-2 col-sm-12">
                                    <div class="d-flex align-items-center h-100">
                                        <label class="mb-0" for="companyAddress">Email:</label>
                                    </div>
                                </div>
                                <div class="col-lg-10 col-sm-12">                        
                                    <input
                                        placeholder="Email"
                                        type="text"
                                        class="form-control mb-0"
                                        id="companyAddress"
                                        autocomplete="off"
                                        required
                                        v-model="formdata_company.email_address"
                                    />
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 10px">
                                <div class="col-lg-2 col-sm-12">
                                    <div class="d-flex align-items-center h-100">
                                        <label class="mb-0" for="companyAddress">Address:</label>
                                    </div>
                                </div>
                                <div class="col-lg-10 col-sm-12">                        
                                    <input
                                        placeholder="Enter Address"
                                        type="text"
                                        class="form-control mb-0"
                                        id="companyAddress"
                                        autocomplete="off"
                                        required
                                        v-model="formdata_company.company_address"
                                    />
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 10px">
                                <div class="col-lg-2 col-sm-12">
                                    <div class="d-flex align-items-center h-100">
                                        <label class="mb-0" for="about">About:</label>
                                    </div>
                                </div>
                                <div class="col-lg-10 col-sm-12">                        
                                    <textarea
                                        placeholder="Enter a desciption about your company"
                                        type="text"
                                        class="form-control mb-0"
                                        id="about"
                                        autocomplete="off"
                                        required
                                        v-model="formdata_company.description"
                                        style="min-height: 70px;"
                                    ></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button v-if="formdata_company.id"  @click="update()" type="submit" class="btn btn-lg btn-primary">Save Changes</button>
                        <button v-else @click="save()" type="submit" class="btn btn-lg btn-primary">Save</button>
                    </div>
                </div>
            </div>
        </div>




        <!-- Modal COMPANY FORM -->
        <div class="modal fade" tabindex="-1" id="modalListing">
            <div class="modal-dialog modal-md " role="document" style="max-width: 750px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"></h5>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modalListing'); " class="close" data-dismiss="modal" aria-label="Close">
                            <i class="bx bx-x"></i>
                        </a>

                    </div>
                    <div class="modal-body">
                        PERSONEL REQUEST LIST
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
    name: 'comapany-list',
    props: ['properties'],
    data: function () {
        return {
            companies: [],
            formdata_company: {
                id: null,
                company_name: '',
                company_address: '',
                email_address: '',
                description: '',
                phone: '',
                country_code: '',

                error: null,
                success: null,
            },
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
            timer: null,
        }
    },
    components: {
        
    },
    computed: { 
    },
    methods: {
        setData: function (company) {
            var scope = this
    
            company.company_name = company.name
            company.company_address = company.address
            scope.$set(company,'error',null)
            scope.$set(company,'success',null)

            scope.formdata_company = company
            setTimeout(function () {
                scope.$refs.ref_phone.countryCode = company.country_code
            }, 500)
        },
        resetFormData: function () {
            var scope = this

            scope.formdata_company.id = null;
            scope.formdata_company.company_name = '';
            scope.formdata_company.company_address = '';
            scope.formdata_company.email_address = '';
            scope.formdata_company.phone = '';
            scope.formdata_company.description = '';
            scope.formdata_company.error = null;
            scope.formdata_company.success = null;
            
        },
        update: function ()
        {
            var scope = this
            scope.formdata_company.error = null
            scope.formdata_company.success = null

            scope.formdata_company.country_code = scope.$refs.ref_phone.countryCode

            scope.PUT('companies/' + scope.formdata_company.id , scope.formdata_company).then(res => {
                if(res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Updated',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        setTimeout(function(){
                            scope.CLOSE_MODAL('#modalCompanyForm'); 
                            scope.getList();
                        },1000);

                        //return scope.$set(scope.formdata_company,'success',res.message)
                    })
                }else{
                    return scope.$set(scope.formdata_company,'error',res.message)
                }


            })


        },
        save: function ()
        {
            var scope = this
            scope.formdata_company.error = null
            scope.formdata_company.success = null

            scope.formdata_company.country_code = scope.$refs.ref_phone.countryCode

            scope.POST('companies', scope.formdata_company).then(res => {
                if(res.success) {
                    window.swal.fire({
                        position: 'center',
                        icon: 'success',
                        title: 'Successfully Created',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        setTimeout(function(){
                            scope.CLOSE_MODAL('#modalCompanyForm'); 
                            scope.getList();
                            //return scope.$set(scope.formdata_company,'success',res.message)
                        },1000);
                    })
                }else{
                    return scope.$set(scope.formdata_company,'error',res.message)
                }

                

               
            })


        },
        remove: function (mail) {
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
                    scope.DELETE('mails/' + mail.id).then(res => {
                        if(res.success) {
                            scope.getList();
                            // scope.CLOSE_MODAL('#modal-mail');
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
        getList: function(){
            var scope = this
            scope.mails = [];
            scope.GET('companies?keyword=' + scope.keyword + '&page=' + scope.pagination.page + '&take=' + scope.pagination.take).then(res => {
                scope.companies = res.rows

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
        console.log('....')
    }
}
</script>
