<template>
<div>
    
    <template v-if="show_edit">
        <h5 style="font-weight: 600">
            <span v-if="note.id === null">New</span>
            <span v-else>Update</span> Note:
        </h5>
        <div class="pr-card">
            <div class="pr-card-header">
                <div class="d-flex">
                    <div @click="resetNoteData()" class="btn-return">
                        <span><i class="las la-undo mr-1"></i> Return</span>
                    </div>
                    <div class="breadcrumbs">
                        <span @click="resetNoteData()" class="mr-1" style="cursor: pointer">List</span>
                        <span class="mr-1">\</span>
                        <span v-if="note.id === null">Create</span>
                        <span v-else>Update</span>
                    </div>
                </div>                
                <div class="d-flex">
                    <button @click="show_edit = false; resetNoteData()" class="btn btn-danger btn-sm mr-1" type="button">Cancel</button>
                    <button v-if="note.id === null" @click="saveNote()" class="btn btn-success btn-sm" type="button">Submit</button>
                    <button v-else @click="updateNote()" class="btn btn-orig btn-sm" type="button">Update</button>
                </div>
            </div>
            <div class="pr-card-body">
                <textarea v-model="note.message" class="form-control mb-2" placeholder="Write your note here.." style="min-height: 100px;"></textarea>
            </div>
        </div>
    </template>
    <template v-else>
        <div class="d-flex justify-content-between align-items-center mb-2">
            <h5 style="font-weight: 600" class="mb-0">Note List:</h5>
            <button v-show="!show_edit" @click="resetNoteData(); show_edit = true;" class="btn btn-primary btn-sm">New Note</button>
        </div>
        <div v-if="!show_note">
            <table class="table table-bordered mb-0 table" style="background: #fff">
                <thead>
                    <tr>
                        <th>Message</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <template v-if="notes.length">
                        <tr v-for="(note, index) in notes" :key="index" @click="viewNote(note)" title="Click to learn more..">
                            <td>
                                <span style="width: 400px;" class="d-block text-ellipsis">{{ note.message }}</span>
                            </td>
                            <td width="50">
                                <span>{{ note.updated_at | MDY }}</span>
                            </td>
                        </tr>
                    </template>
                    <template v-else>
                        <tr><td colspan="2" style="padding: 10px; font-weight: 600; text-align: center;">No Notes Yet.</td></tr>
                    </template>
                </tbody>
            </table>
        </div>
        <div v-else>
            <div class="pr-card">
                <div class="pr-card-header">
                    <div class="d-flex">
                        <div @click="resetNoteData()" class="btn-return">
                            <span><i class="las la-undo mr-1"></i> Return</span>
                        </div>
                        <div class="breadcrumbs">
                            <span @click="resetNoteData()" class="mr-1" style="cursor: pointer">List</span>
                            <span class="mr-1">\</span>
                            <span>View</span>
                        </div>
                    </div>
                    <div class="d-flex">
                        <button @click="show_edit = !show_edit;" class="btn btn-orig btn-sm mr-1"><i class="fas fa-pencil-alt"></i></button>
                        <button @click="deleteNote()" class="btn btn-danger btn-sm"><i class="bx bxs-trash"></i></button>
                    </div>
                </div>
                <div class="pr-card-body">
                    <div><strong>Date:</strong> {{ note.updated_at | MDY }}</div>
                    <div><strong>Message:</strong> {{note.message}}</div>
                </div>
            </div>
        </div>
    </template>
</div>
</template>

<script>
import moment from 'moment'
export default {
    name: 'admin-note',
    props: ['properties'],
    data: function () {
        return {
            notes: [],
            candidate_id: '',

            show_note: false,
            show_edit: false,

            note: {
                id: null,
                message: '',

                error: '',
                success: '',
            },
        }
    },
    filters: {
        MDY: function (date) {
            return moment(date).format('MM/DD/yyyy');
        }
    },
    methods: {
        viewNote: function (note) {
            var scope = this
            scope.show_note = true

            scope.note.id = note.id
            scope.note.message = note.message
        },
        saveNote: function () {
            var scope = this
            scope.note.error = null

            scope.POST('note/' + scope.candidate_id, scope.note).then(res => {
                if (!res.success) {
                    alert(res.message)
                    return scope.note.error = res.message
                }
                alert(res.message)
                scope.getNotes()
                scope.show_edit = false
            })       
        },
        getNotes: function () {
            var scope = this
            scope.note.error = null

            scope.GET('note/' + scope.candidate_id).then(res => {
                if (!res.success) {
                    console.log(res.message)
                    return scope.note.error = res.message
                }
                scope.notes = res.data
                console.log(res.message)
            })       
        },
        updateNote: function () {
            var scope = this
            scope.note.error = null
            
            scope.PUT('note/' + scope.note.id, scope.note).then(res => {
                if (!res.success) {
                    alert(res.message)
                    return scope.note.error = res.message
                }
                alert(res.message)
                scope.show_edit = false
                scope.getNotes()
            })  
        },
        deleteNote: function () {
            var scope = this
            scope.note.error = null

            scope.DELETE('note/' + scope.note.id).then(res => {
                if (!res.success) {
                    alert(res.message)
                    return scope.note.error = res.message
                }
                alert(res.message)
                scope.getNotes()
                scope.show_note = false
            }) 
        },
        resetNoteData: function () {
            var scope = this

            scope.note.id = null
            scope.note.message = ''

            scope.show_note = false
            scope.show_edit = false
        },
    },
    mounted () {
        var scope = this

        scope.candidate_id = scope.properties ? scope.properties.candidate_id : ''
        scope.getNotes()
    }
}
</script>
<style scoped>
.table tbody tr:hover { cursor: pointer; background: #f5f5f5 }
</style>