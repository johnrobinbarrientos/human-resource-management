<template>
    <div>
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="mb-0 font-size-18">Message Center</h4>
            <div class="page-title-right">
                <nav class="" aria-label="breadcrumb">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript:void(0);">Messsage Center</a></li>
                        <li class="active breadcrumb-item" aria-current="page">
                            <a href="javascript:void(0);">Messages</a>
                        </li>
                    </ol>
                </nav>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div style="margin-bottom:10px;">
                            <div class="row">
                                <div class="col-12 col-md-3">
                                    <input type="text" class="form-control table-search" placeholder="Search Employees...">
                                </div>
                                <div class="col-12 col-md-2 offset-md-7 text-right">
                                    <a @click="create();" href="javascript:void(0)" data-toggle="modal" class="btn btn-primary">
                                        <em class="icon ni ni-plus"></em> <span>Add Message</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table mb-0 table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Subject</th>    
                                        <th>Message</th>
                                        <th>Status</th>
                                        <th>Mail</th>
                                        <th>SMS</th>
                                        <th>Recipients</th>
                                        <th width="120">Actions</th>
                                    </tr>
                                </thead>
                                <tbody v-if="mails.length > 0">
                                    <tr v-for="(mail,index) in mails" :key="index">
                                        <td>{{ mail.subject }}</td>
                                        <td>
                                            <p  style="white-space: nowrap; width: 150px; overflow: hidden;text-overflow: ellipsis;">{{ mail.message }}</p>
                                        </td>
                                        <td>
                                            <span v-if="mail.status == 'pending'" class="badge badge-warning">Pending</span>
                                            <span v-if="mail.status == 'sending'" class="badge badge-info">Sending</span>
                                            <span v-if="mail.status == 'sent'" class="badge badge-success">Sent</span>
                                        </td> 
                                        <td>
                                            <span v-if="mail.is_email" class="badge badge-success">Yes</span>
                                            <span v-else class="badge badge-soft-dark">No</span>
                                        </td> 
                                        <td>
                                            <span v-if="mail.is_sms" class="badge badge-success">Yes</span>
                                            <span v-else class="badge badge-soft-dark">No</span>
                                        </td> 
                                        <td>{{ mail.recipients.length }}</td>
                                        <td>
                                            <button @click="edit(mail);" type="button"   class="btn btn-warning btn-sm">
                                                Edit
                                            </button>
                                            <button @click="remove(mail)" type="button"  class="btn btn-danger btn-sm">
                                                Delete
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                                <tbody v-else>
                                    <tr>
                                        <td colspan="7" class="p-2 text-center">There are no messages yet.</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <PopupForm ref="popupForm"></PopupForm>

    </div>
</template>



<script>
    import PopupForm from './PopupForm'

    export default {
    name: 'message-list',
    props: ['properties'],
    data: function () {
        return {
            mails: [],
            recipients: []
        }
    },
    components: {
        PopupForm
    },
    computed: {
    },
    methods: {
        create: function(mail) {
            var scope = this

            var mail = {};
            mail.id =  null
            mail.subject =  ''
            mail.message =  ''
            mail.is_sms =  'yes'
            mail.is_email =  'yes'
            mail.recipients =  []
            mail.has_mail_recipient_details =  true
 
            scope.$refs.popupForm.setData(mail)
            scope.OPEN_MODAL('#modal-mail');
        },
        edit: function(mail) {
            var scope = this
            
            mail.has_mail_recipient_details =  true
            scope.$refs.popupForm.setData(mail)
            scope.OPEN_MODAL('#modal-mail');
        },
        getList: function(){
            var scope = this
            scope.mails = [];
            scope.GET('mails').then(res => {
                scope.mails = res.rows
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
        }
    },
    mounted() {
        var scope = this
        scope.getList()

        $('.recipients-list').select2({
            ajax: {
                url: '/api/users/search?type=Candidate',
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
</script>
