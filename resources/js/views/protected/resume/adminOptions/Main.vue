<template>
    <div class="admin-message" :class="{'message-wrap': show_options }">
        <div class="d-flex justify-content-between align-items-center">
            <div><p></p></div>
            <div class="msg-btn-tab">
                <button @click="call(candidate_id)" class="btn btn-primary" style="border-top-right-radius: 0; border-bottom-right-radius: 0"><i class="fas fa-phone-alt"></i> Call</button>
                <button @click="toggleAdminMsg('send-mail')" :class="{'active' : active_tab == 'send-mail'}" class="btn btn-primary" style="border-top-right-radius: 0; border-bottom-right-radius: 0">Send Mail</button>
                <button @click="toggleAdminMsg('send-sms')" :class="{'active' : active_tab == 'send-sms'}"  class="btn btn-primary" style="border-radius: 0">Send SMS</button>
                <button @click="toggleAdminMsg('notes')" :class="{'active' : active_tab == 'notes'}" class="btn btn-primary" style="border-top-left-radius: 0; border-bottom-left-radius: 0">Notes</button>
                <div class="dropdown ml-2">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Logs <i class="las la-caret-down"></i>
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a  @click="toggleAdminMsg('call-logs')" :class="{'active' : active_tab == 'call-logs'}" class="dropdown-item" href="javascript:void(0);">Call Logs</a>
                        <a  @click="toggleAdminMsg('sms-logs')" :class="{'active' : active_tab == 'sms-logs'}" class="dropdown-item" href="javascript:void(0);">Sms Logs</a>
                        <a  @click="toggleAdminMsg('email-logs')" :class="{'active' : active_tab == 'email-logs'}" class="dropdown-item" href="javascript:void(0);">Email Logs</a>
                    </div>
                </div>
            </div>
            <div @click="resetToggleAdminMsg();" class="btn-close" title="close">
                <i v-if="show_options" style="font-size: 16px;" class="las la-times"></i>
            </div>
        </div>
        <div v-show="show_options" id="msg-tabs" class="mt-4">
            <div class="msg-tab" :class="{'active' : active_tab == 'send-mail'}">
                <div v-if="candidate_id">
                    <Messages ref="childEmailMessage" :properties="{ type: 'email', candidate_id }" />
                </div>
            </div>
            <div class="msg-tab" :class="{'active' : active_tab == 'send-sms'}">
                <div v-if="candidate_id">
                    <Messages ref="childSMSMessage" :properties="{ type: 'SMS', candidate_id }" />
                </div>
            </div>

            <div class="msg-tab" :class="{'active' : active_tab == 'notes'}">
                <div v-if="candidate_id">
                    <Notes ref="childNotes" :properties="{ candidate_id }" />
                </div>
            </div>
            <div class="msg-tab" :class="{'active' : active_tab == 'call-logs'}">
                <div v-if="candidate_id">
                    <Logs ref="childCallLogs" :properties="{ type: 'call', candidate_id }" />
                </div>
            </div>
            <div class="msg-tab" :class="{'active' : active_tab == 'sms-logs'}">
                <div v-if="candidate_id">
                    <Logs ref="childSMSLogs" :properties="{ type: 'sms', candidate_id }" />
                </div>
            </div>
            <div class="msg-tab" :class="{'active' : active_tab == 'email-logs'}">
                <div v-if="candidate_id">
                    <Logs ref="childEmailLogs" :properties="{ type: 'email', candidate_id }" />
                </div>
            </div>
            
        </div>
    </div>
</template>

<script>
import moment from 'moment'
import Notes from './Notes'
import Logs from './Logs'
import Messages from './Messages'

export default {
    name: 'admin-options',
    props: ['properties'],
    data: function () {
        return {
            show_message: false,
            show_options: false,
            active_tab: '',
            candidate_id: null,
        }
    },
    components: {
        Notes,
        Logs,
        Messages,
    },
    filters: {
        fromNow: function (date) {
            return moment(date).fromNow();
        },
        calendar: function (date) {
            return moment(date).calendar();
        },
        MDY: function (date) {
            return moment(date).format('MM/DD/yyyy');
        }
    },
    methods: {
        fromComponentMsgs: function (message_type) {
            var scope = this

            // new message is added, trigger the ff. to update data
            if(message_type === 'email'){
                scope.$refs.childEmailLogs.getLogs()
            }
            if(message_type === 'SMS'){
                scope.$refs.childSMSLogs.getLogs()
            }
        },
        toggleAdminMsg: function (tab) {
            var scope = this

            scope.show_options = true

            scope.active_tab = tab
        },
        resetToggleAdminMsg: function() {
            var scope = this

            scope.show_options = false
            scope.resetData()
            scope.active_tab = ''
            //$('.msg-btn-tab button').removeClass('active')
        },
        resetData: function () {
            var scope = this

            scope.$refs.childNotes.resetNoteData()
            scope.$refs.childCallLogs.resetLogData()
            scope.$refs.childSMSLogs.resetLogData()
            scope.$refs.childEmailLogs.resetLogData()
            scope.$refs.childEmailMessage.resetMessageData()
            scope.$refs.childSMSMessage.resetMessageData()
        },
        call: function (user_id) {
            var scope = this
            var response = scope.GET('twilio/call/' + user_id,{}).then(res => {
                if (res.success) {
                    alert(res.message)
                } else {
                    alert(res.data.message)
                }
            })
        },

    },
    mounted() {
        var scope = this
        scope.candidate_id = (scope.properties && scope.properties.candidate_id) ? scope.properties.candidate_id : null
    }
}
</script>
<style scoped>
.admin-message { margin-top: -10px; margin-bottom: 20px; }
.admin-message tbody tr:hover { cursor: pointer; background: #f5f5f5 }
.admin-message.message-wrap { margin-top: 10px; border: 1px solid #ddd; border-radius: 4px; padding: 20px; margin-bottom: 20px; background: #f8f9fa; }
.admin-message .msg-btn-tab button { transition: .5s }
.admin-message .msg-btn-tab button:nth-child(1),
.admin-message .msg-btn-tab button:nth-child(2) { margin-right: 1px }
.admin-message .msg-btn-tab button.active,
.admin-message .msg-btn-tab button.active:focus,
.admin-message .msg-btn-tab button.active:active {
    box-shadow: none !important;
    border-color: var(--primus-orange) !important;
    transition: .5s
}
.admin-message .msg-btn-tab { display: flex; align-items: center; border-radius: 6px; }
.admin-message .msg-tab { display: none; }
.admin-message .msg-tab.active { display: block; }

.admin-message textarea { height: 100px; }

.btn-close { cursor: pointer; line-height: 1; border: 1px solid #bbb; padding-right: 1px; border-radius: 2px; transition: .5s; }
.btn-close:hover { background: #555; transition: .5s; border-color: #555; }
.btn-close:hover i { color: #fff; }

</style>