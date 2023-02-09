<template>
    <div>
        <div class="modal fade" tabindex="-1" id="modal-mail">
            <div class="modal-dialog modal-md " role="document">
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
                                        <strong class="form-label">Message</strong>
                                        <textarea rows="4" v-model="formdata.message" type="text" class="form-control"></textarea>
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

                                    <div class="form-group">
                                        <strong class="form-label">Recipients</strong>
                                        <select multiple class="recipients-list"></select>
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
    methods: {
        setData: function(mail) {
            var scope = this;
            scope.formdata = mail

            var recipients = mail.recipients
            
             $(".recipients-list").html('');

            if (scope.formdata.has_mail_recipient_details) {
                for (let i = 0; i < recipients.length; i++) 
                {
                    var current = recipients[i]
                    var newOption = new Option(current.user.first_name + ' ' + current.user.last_name, current.user.id, true, true);
                    $(".recipients-list").append(newOption).trigger('change');
                }
            } else {
                for (let i = 0; i < recipients.length; i++) 
                {
                    var current = recipients[i]
                    var newOption = new Option(current.first_name + ' ' + current.last_name, current.id, true, true);
                    $(".recipients-list").append(newOption).trigger('change');
                }
            }
            

        },
        getList: function(){
            var scope = this
            scope.mails = [];
            scope.GET('mails').then(res => {
                scope.mails = res.rows
            })
        },
        save: function () {
            var scope = this
            
            scope.formdata.recipients = $('.recipients-list').val();

            scope.POST('mails', scope.formdata).then(res => {
                if(res.success) {
                    scope.getList();
                    scope.CLOSE_MODAL('#modal-mail');
                } else {
                    alert(res.message)
                }
            })
        },
        update: function () {
            var scope = this
            scope.formdata.recipients = $('.recipients-list').val();
            scope.PUT('mails/' + scope.formdata.id, scope.formdata).then(res => {
                if(res.success) {
                    scope.getList();
                    scope.CLOSE_MODAL('#modal-mail');
                } else {
                    alert(res.message)
                }
            })
        }
    },
    mounted() {
        var scope = this

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
