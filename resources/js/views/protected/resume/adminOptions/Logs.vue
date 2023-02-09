<template>
<div>
    <template v-if="show_edit">
        <h5 style="font-weight: 600">
            <span v-if="log.id === null">New</span>
            <span v-else>Update</span> Log:
        </h5>
        <div class="pr-card">
            <div class="pr-card-header">
                <div class="d-flex">
                    <div @click="resetLogData()" class="btn-return">
                        <span><i class="las la-undo mr-1"></i> Return</span>
                    </div>
                    <div class="breadcrumbs">
                        <span @click="resetLogData()" class="mr-1" style="cursor: pointer">List</span>
                        <span class="mr-1">\</span>
                        <span v-if="log.id === null">Create</span>
                        <span v-else>Update</span>
                    </div>
                </div>
                <div class="d-flex justify-content-end">
                    <button @click="show_edit = false; resetLogData()" class="btn btn-danger btn-sm mr-1" type="button">Cancel</button>
                    <button v-if="log.id === null" @click="saveLog()" class="btn btn-success btn-sm" type="button">Submit</button>
                    <button v-else @click="updateLog()" class="btn btn-orig btn-sm" type="button">Update</button>
                </div>
            </div>
            
            <div class="log-options-wrap">
                <div class="log-options">
                    <div v-if="properties && properties.type === 'call'" class="w-100">
                        <label>Outcome:</label>
                        <select v-model="log.outcome" class="form-control">
                            <option>Busy</option>
                            <option>Connected</option>
                            <option>Left Live Message</option>
                            <option>Left Voice Mail</option>
                            <option>No Answer</option>
                            <option>Wrong Number</option>
                        </select>
                    </div>
                    <div class="w-100">
                        <label>Date:</label>
                        <input v-model="log.date" type="date" id="inputDate" class="form-control">
                    </div>
                    <div class="w-100">
                        <label>Time:</label>
                        <input v-model="log.time" type="time" class="form-control">
                    </div>
                </div>
                <div class="mb-3">
                    <label>Description:</label>
                    <textarea v-model="log.description" class="form-control" style="min-height: 100px" placeholder="Write your description here.."></textarea>
                </div>
            </div>
        
        </div>
    </template>
    <template v-else>
        <div class="d-flex justify-content-between align-items-center mb-2">
            <h5 style="font-weight: 600" class="mb-0"><span v-if="properties" style="text-transform: capitalize;">{{ properties.type }}</span> Log List:</h5>
            <button v-show="!show_edit" @click="resetLogData(); show_edit = true;" class="btn btn-primary btn-sm">New <span v-if="properties" style="text-transform: capitalize;">{{ properties.type }}</span> Log</button>
        </div>
        <div v-if="!show_log">
            <table class="table table-bordered mb-0 table" style="background: #fff">
                <thead>
                    <tr>
                        <th>Logged by</th>
                        <th>Description</th>
                        <th v-if="properties && properties.type === 'call'">Outcome</th>
                        <th>Date</th>
                        <th>Time</th>

                    </tr>
                </thead>
                <tbody>
                    <template v-if="logs.length">
                        <tr v-for="(log, index) in logs" :key="index" @click="viewLog(log)" title="Click to learn more..">
                            <td>
                                <span v-if="log.user" class="badge badge-primary">{{ log.user.first_name }} {{ log.user.last_name }}</span>
                            </td>
                            <td>
                                <span  class="d-block ">{{ ELLIPSIS(log.description ,60) }}</span>
                            </td>
                            <td v-if="properties && properties.type === 'call'">
                                <span class="text-nowrap">{{ log.outcome }}</span>
                            </td>
                            <td>
                                <span class="text-nowrap">
                                    <template v-if="log.date != '0000-00-00'">{{ log.date }}</template>
                                    <template v-else>{{ LOCALIZED_UTC_DATE(log.created_at,'MM/DD/yyyy') }}</template>
                                </span>
                            </td>
                            <td>
                                <span class="text-nowrap">
                                    <template v-if="log.time != '00:00:00'">{{ log.time }}</template>
                                    <template v-else>{{ LOCALIZED_UTC_DATE(log.created_at,'HH:mm:ss') }}</template>
                                </span>
                            </td>
                        </tr>
                    </template>
                    <template v-else>
                        <tr><td colspan="5" style="padding: 10px; font-weight: 600; text-align: center;">No Logs Yet.</td></tr>
                    </template>
                </tbody>
            </table>
        </div>
        <div v-else>
            <div class="pr-card">
                <div class="pr-card-header">
                    <div class="d-flex">
                        <div @click="resetLogData()" class="btn-return">
                            <span><i class="las la-undo mr-1"></i> Return</span>
                        </div>
                        <div class="breadcrumbs">
                            <span @click="resetLogData()" class="mr-1" style="cursor: pointer">List</span>
                            <span class="mr-1">\</span>
                            <span>View</span>
                        </div>
                    </div>
                    <div class="d-flex">
                        <div class="mr-2" style="background: #eee;  padding: 5px 10px; border-radius: 4px;">
                            <span class="mr-1">Logged by:</span>
                            <span class="badge badge-primary">{{ log.logged_by }}</span>
                        </div>
                        <button @click="show_edit = !show_edit;" class="btn btn-orig btn-sm mr-1"><i class="fas fa-pencil-alt"></i></button>
                        <button @click="deleteLog()" class="btn btn-danger btn-sm"><i class="bx bxs-trash"></i></button>
                    </div>
                </div>
                <div style="padding: 15px;">
                    <div><strong>Date:</strong> {{ log.date }}</div>
                    <div><strong>Time:</strong> {{ log.time }}</div>
                    <div v-if="properties && properties.type === 'call'"><strong>Outcome:</strong> {{ log.date }}</div>
                    <div><strong>Description:</strong> {{log.description}}</div>
                </div>
            </div>
        </div>
    </template>


</div>
</template>
<script>
import moment from 'moment'
export default {
    name: 'admin-logs',
    props: ['properties'],
    data: function () {
        return {
            candidate_id: '',
            logs: [],
            log: {
                id: null,
                user_id: null,
                type: '',
                outcome: '',
                date: '',
                time: '',
                description: '',
                logged_by: '',
            },

            show_log: false,
            show_edit: false,
        }
    },
    methods: {
        viewLog: function (log) {
            var scope = this

            scope.show_log = true
            scope.log.id = log.id
            scope.log.outcome = log.outcome
            scope.log.date = (log.date != '0000-00-00') ? log.date : scope.LOCALIZED_UTC_DATE(log.created_at,'yyyy-MM-DD')
            scope.log.time = (log.time != '00:00:00') ? log.time : scope.LOCALIZED_UTC_DATE(log.created_at,'HH:mm:ss')
            scope.log.description = log.description
            scope.log.logged_by = log.user.first_name + ' ' + log.user.last_name
        },
        getLogs: function () {
            var scope = this
            
            scope.GET('user/logs', {'type': scope.properties.type, 'user_id': scope.candidate_id}).then(res => {
                if (!res.success) {
                    console.log('error', res.message)
                    return
                }
                console.log('success', res.message)
                scope.logs = res.data
            })
        },
        saveLog: function () {
            var scope = this
            
            scope.log.type = scope.properties.type
            scope.log.user_id = scope.candidate_id
            scope.POST('user/logs', scope.log).then(res => {
                if (!res.success) {
                    alert(res.message)
                    return
                }
                alert(res.message)
                scope.getLogs()
                scope.show_edit = false
            })
        },
        updateLog: function () {
            var scope = this

            scope.log.user_id = scope.candidate_id
            scope.PUT('user/logs', scope.log).then(res => {
                if (!res.success) {
                    alert(res.message)
                    return
                }
                alert(res.message)
                scope.getLogs()
            })    
        },
        deleteLog: function () {
            var scope = this

            scope.DELETE('user/logs/' + scope.log.id).then(res => {
                if (!res.success) {
                    alert(res.message)
                    return
                }
                alert(res.message)
                scope.getLogs()
                scope.show_log = false
            })    
        },
        resetLogData: function () {
            var scope = this

            scope.log.id = null
            scope.log.user_id = null
            scope.log.type = ''
            scope.log.outcome = ''
            scope.log.date = ''
            scope.log.time = ''
            scope.log.description = ''
            scope.log.logged_by = ''

            scope.show_log = false
            scope.show_edit = false
        }
    },
    mounted() {
        var scope = this

        scope.candidate_id = scope.properties ? scope.properties.candidate_id : ''
        scope.getLogs()
    },
}
</script>
<style scoped>
.table thead th { white-space: nowrap; }
.log-options-wrap { padding: 15px; background-color: #fff; }
.log-options {
    display: flex;
    margin-bottom: 20px;
}
.log-options div:nth-child(2) { margin: 0 10px; }
.table tbody tr:hover { cursor: pointer; background: #f5f5f5 }
</style>