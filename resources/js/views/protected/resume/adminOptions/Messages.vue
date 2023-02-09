<template>
<div>
    
    <template v-if="show_edit">
        <h5 style="font-weight: 600">
            <span>Compose Message</span>
        </h5>
        <div class="pr-card">
            <div class="pr-card-header">
                <div class="d-flex">
                    <div @click="resetMessageData()" class="btn-return">
                        <span><i class="las la-undo mr-1"></i> Return</span>
                    </div>
                    <div class="breadcrumbs">
                        <span @click="resetMessageData()" class="mr-1" style="cursor: pointer">List</span>
                        <span class="mr-1">\</span>
                        <span>Create</span>
                    </div>
                </div>                
                <div class="d-flex">
                    <button @click="show_edit = false; resetMessageData()" class="btn btn-danger btn-sm mr-1" type="button">Cancel</button>
                    <button @click="sendMessage()" class="btn btn-success btn-sm" type="button">Send</button>
                </div>
            </div>
            <div class="pr-card-body">
                <form>
                    <input v-if="properties && properties.type === 'email'" v-model="message.subject" class="form-control mb-2" placeholder="Subject" />
                    <textarea v-model="message.message" class="form-control mt-2 mb-2" placeholder="Message"></textarea>
                </form>
            </div>
        </div>
    </template>
    <template v-else>
        <div class="d-flex justify-content-between align-items-center mb-2">
            <h5 style="font-weight: 600" class="mb-0">
                <span v-if="properties" style="text-transform: capitalize">{{ properties.type }}</span> List:
            </h5>
            <button v-show="!show_edit" @click="resetMessageData(); show_edit = true;" class="btn btn-primary btn-sm">Compose Message</button>
        </div>
        <div v-if="!show_message">
            <table class="table table-bordered mb-0 table" style="background: #fff">
                <thead>
                    <tr>
                        <th>Subject</th>
                        <th>Message</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <template v-if="messages.length">
                        <tr v-for="(message, index) in messages" :key="index" @click="viewMessage(message)" title="Click to learn more..">
                            <td width="200">
                                <span class="d-block">{{ ELLIPSIS(message.mail.subject,40) }}</span>
                            </td>
                            <td>
                                <span class="d-block">{{ ELLIPSIS(message.mail.message,100) }}</span>
                            </td>
                            <td width="50">
                                <span>{{ message.updated_at | MDY }}</span>
                            </td>
                        </tr>
                    </template>
                    <template v-else>
                        <tr><td colspan="3" style="padding: 10px; font-weight: 600; text-align: center;">No Mails Sent Yet.</td></tr>
                    </template>
                </tbody>
            </table>
        </div>
        <div v-else>
            <div class="pr-card">
                <div class="pr-card-header">
                    <div class="d-flex">
                        <div @click="resetMessageData()" class="btn-return">
                            <span><i class="las la-undo mr-1"></i> Return</span>
                        </div>
                        <div class="breadcrumbs">
                            <span @click="resetMessageData()" class="mr-1" style="cursor: pointer">List</span>
                            <span class="mr-1">\</span>
                            <span>View</span>
                        </div>
                    </div>
                </div>
                <div class="pr-card-body">
                    <div><strong>Date:</strong> {{ message.updated_at | MDY }}</div>
                    <div><strong>Subject:</strong> {{message.subject}}</div>
                    <div><strong>Message:</strong> {{message.message}}</div>
                </div>
            </div>
        </div>
    </template>
</div>
</template>

<script>
import moment from 'moment'
export default {
    name: 'admin-message',
    props: ['properties'],
    data: function () {
        return {
            messages: [],
            candidate_id: '',
            message_type: '',

            show_message: false,
            show_edit: false,

            message: {
                id: null,
                subject: '',
                message: '',
                is_sms: false,
                is_email: false,
                date: '',
                is_from_message_center: false,
            },
        }
    },
    filters: {
        MDY: function (date) {
            var stillUtc = moment.utc(date).toDate();
            var formatted = moment(stillUtc).local().format('MM/DD/yyyy')
            return  formatted
 
        }
    },
    methods: {
        viewMessage: function (message) {
            var scope = this
            scope.show_message = true

            scope.message.date = message.mail.created_at
            scope.message.subject = message.mail.subject
            scope.message.message = message.mail.message
            scope.message.is_sms = message.mail.is_sms
            scope.message.is_email = message.mail.is_email
        },
        sendMessage: function () {
            var scope = this
            
            scope.message.id = scope.candidate_id
            if(scope.message_type === 'email')
            {
                scope.message.is_sms = false
                scope.message.is_email = true
            }

            if(scope.message_type === 'SMS')
            {
                scope.message.is_sms = true
                scope.message.is_email = false
            }

            scope.POST('candidate/message', scope.message).then(res => {
                if(!res.success) {
                    alert('Oops! Something went wrong..')
                }
                scope.getMessages()
                alert('Message Successfully Sent!')
                scope.$parent.fromComponentMsgs(scope.message_type)
            })
        },
        resetMessageData: function () {
            var scope = this

            // sms and email
            scope.message.date = ''
            scope.message.subject = ''
            scope.message.message = ''
            scope.message.is_sms = ''
            scope.message.is_email = ''

            scope.show_message = false
            scope.show_edit = false
        },
        getMessages: function () {
            var scope = this
            
            scope.GET('candidate/message-history', {'candidate_id': scope.candidate_id, 'message_type': scope.message_type }).then(res => {
                if(!res.success) {
                    return alert('Oops! Something went wrong..')
                }
                scope.messages = res.rows
                scope.resetMessageData()
            })
        },
    },
    mounted () {
        var scope = this

        scope.candidate_id = scope.properties ? scope.properties.candidate_id : ''
        scope.message_type = scope.properties ? scope.properties.type : ''
        scope.getMessages()
    }
}
</script>
<style scoped>
.table tbody tr:hover { cursor: pointer; background: #f5f5f5 }
</style>