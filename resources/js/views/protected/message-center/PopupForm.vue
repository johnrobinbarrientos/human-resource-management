<template>
    <div>
        <div class="modal fade" tabindex="-1" id="modal-mail">
            <div class="modal-dialog modal-lg " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5  class="modal-title">Message</h5>
                        <a href="javascript:void(0)" @click="CLOSE_MODAL('#modal-mail');" class="close" data-dismiss="modal" aria-label="Close">
                            <em class="bx bx-x"></em>
                        </a>
                    </div>
                    <div class="modal-body">
                        <form action="#" class="form-validate is-alter">

                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="form-group">
                                        <strong class="form-label">Subject</strong>
                                        <input v-model="formdata.subject" type="text" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <strong class="form-label">Filter Group</strong>
                                        <select v-model="filter.group" class="form-control">
                                            <option value="General">General</option>
                                            <option value="Jobs">Jobs</option>
                                        </select>
                                    </div>

                                    <div class="form-group" v-show="filter.group == 'Jobs'">
                                        <strong class="form-label">Job</strong>
                                        <select class="job-post-id"></select>
                                    </div>

                                    <div class="form-group" v-show="filter.group == 'Jobs'">
                                        <strong class="form-label">Status</strong>
                                        <select v-model="filter.job_recommendation_status" class="form-control">
                                            <option value="all">All</option>
                                            <option value="waiting_for_candidate">No Response</option>
                                            <option value="accepted_by_candidate">Available Applicants</option>
                                            <option value="rejected_by_candidate">Unavailable Candidates</option>

                                            <option value="waiting_for_employer">Recommended Candidates</option>
                                            <option value="accepted_by_employer">Hired Candidates</option>
                                            <option value="rejected_by_employer">Rejected Candidates</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <strong class="form-label">Recipients</strong>
                                        <select multiple class="selected-recipient-list"></select>
                                    </div>

                                    <div class="form-group">
                                        <strong class="form-label">Message</strong>
                                        <textarea id="mc-message" rows="4" v-model="formdata.message" type="text" class="form-control"></textarea>
                                    </div>


                                    <div class="form-group">
                                        <div class="form-check">
                                            <input v-model="formdata.is_email" value="yes" class="form-check-input" type="checkbox" id="is-email">
                                            <label class="form-check-label" for="is-email">Send Mail</label>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <div class="form-check">
                                            <input v-model="formdata.is_sms" value="yes" class="form-check-input" type="checkbox" id="is-sms">
                                            <label class="form-check-label" for="is-sms">Send SMS</label>
                                        </div>
                                    </div>

                                    
                                </div>
                                
                            </div>                                    
                            
                        </form>
                    </div>
                    <div class="modal-footer bg-light">
                        <button v-if="!formdata.id" @click="save()" type="button" class="btn btn-md btn-primary">Submit</button>
                        <button v-else  @click="update()" type="button" class="btn btn-md btn-primary">Update</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>



<script>
    
    
    export default {
    name: 'message-center-popup',
    props: ['properties'],
    data: function () {
        return {
            mails: [],
            filter: {
                group: 'General',
                job_post_id: 0,
                job_recommendation_status: 'all'
            },
            formdata: {
                id: null,
                subject: '',
                message: '',
                is_sms: 'yes',
                is_email: 'yes',
                is_from_message_center: true,
                recipients: [],
                has_mail_recipient_details: true // whether or not include the recipient details like "created_at" from mail_recipients table
            }
        }
    },
    components: {
        
    },
    computed: {
    },
    watch: {
        'filter.group': function(val) {
            var scope = this
            if (val == 'general') {
                $('.job-post-id').val(0)
                return
            }
        },
        'filter.job_post_id': function(val) {
            var scope = this
            if (val) {
                $(".selected-recipient-list").select2("destroy")
                $(".selected-recipient-list").html('');
                scope.initializeSelectedRecipientsListSelect();
            }
        },
        'filter.job_recommendation_status': function(val) {
            var scope = this
            if (val) {
                $(".selected-recipient-list").select2("destroy")
                $(".selected-recipient-list").html('');
                scope.initializeSelectedRecipientsListSelect();
            }
        },
        
    },
    methods: {
        setData: function(mail) {
            var scope = this;
            scope.formdata = mail
            $('#mc-message').summernote('code',mail.message);

            var recipients = mail.recipients
            
             $(".selected-recipient-list").html('');

            if (scope.formdata.has_mail_recipient_details) {
                for (let i = 0; i < recipients.length; i++) 
                {
                    var current = recipients[i]
                    var newOption = new Option(current.user.first_name + ' ' + current.user.last_name, current.user.id, true, true);
                    $(".selected-recipient-list").append(newOption).trigger('change');
                }
            } else {
                for (let i = 0; i < recipients.length; i++) 
                {
                    var current = recipients[i]
                    var newOption = new Option(current.first_name + ' ' + current.last_name, current.id, true, true);
                    $(".selected-recipient-list").append(newOption).trigger('change');
                }
            }
            

        },
        save: function () {
            var scope = this
            
            scope.formdata.recipients = $('.selected-recipient-list').val();
            scope.formdata.message = $('#mc-message').summernote('code');

            scope.POST('mails', scope.formdata).then(res => {
                if(res.success) {
                    scope.$parent.getList();
                    scope.CLOSE_MODAL('#modal-mail');
                } else {
                    alert(res.message)
                }
            })
        },
        update: function () {
            var scope = this
            scope.formdata.recipients = $('.selected-recipient-list').val();
            scope.formdata.message = $('#mc-message').summernote('code');

            scope.PUT('mails/' + scope.formdata.id, scope.formdata).then(res => {
                if(res.success) {
                    scope.$parent.getList();
                    scope.CLOSE_MODAL('#modal-mail');
                } else {
                    alert(res.message)
                }
            })
        },
        initializeSelectedRecipientsListSelect: function () {
            var scope = this
            $('.selected-recipient-list').select2({
                ajax: {
                    url: '/api/users/search?type=Candidate&job_post_id=' + scope.filter.job_post_id + '&job_recommendation_status=' + scope.filter.job_recommendation_status,
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
    },
    mounted() {
        var scope = this

        $('#mc-message').summernote({
            height: 150,
            forecolor: '#000'
        });

        scope.initializeSelectedRecipientsListSelect()
        
        $('.job-post-id').select2({
            ajax: {
                url: '/api/jobs/search',
                dataType: 'json',
                delay: 300,
                processResults: function (data) {
                    return {
                        results: data.rows
                    };
                }
            }
        })

        $(document).on('change','.job-post-id',function(){
            scope.filter.job_post_id = $('.job-post-id').val();
        })
    }
}
</script>
