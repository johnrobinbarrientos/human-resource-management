<template>
<div class="container-fluid">
    <Compose v-if="show_compose"></Compose>
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <h4 class="mb-0 font-size-18">Inbox</h4>
                <div class="page-title-right">
                    <nav class="" aria-label="breadcrumb">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="/email-inbox">Email</a></li>
                            <li class="active breadcrumb-item" aria-current="page"><a href="/email-inbox">Inbox</a></li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <Leftbar></Leftbar>
            <div class="email-rightbar mb-3">
                <div class="card">
                    <div class="btn-toolbar p-3" role="toolbar">
                        <div class="btn-group mr-2 mb-2 mb-sm-0">
                            <button type="button" class="waves-light waves-effect btn btn-primary"><i class="fa fa-inbox"></i></button>
                            <button type="button" class="waves-light waves-effect btn btn-primary"><i class="fa fa-exclamation-circle"></i></button>
                            <button type="button" class="waves-light waves-effect btn btn-primary"><i class="far fa-trash-alt"></i></button>
                        </div>
                        <div class="btn-group mr-2 mb-2 mb-sm-0 dropdown">
                            <div aria-haspopup="true" class="btn btn-primary waves-light waves-effect dropdown-toggle" aria-expanded="false">More <i class="mdi mdi-dots-vertical ml-2"></i></div>
                            <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu">
                                <button type="button" to="#" tabindex="0" role="menuitem" class="dropdown-item">Mark as Unread</button>
                                <button type="button" to="#" tabindex="0" role="menuitem" class="dropdown-item">Mark as Important</button>
                                <button type="button" to="#" tabindex="0" role="menuitem" class="dropdown-item">Add Star</button>
                            </div>
                        </div>
                    </div>
                    <ul class="message-list">
                        <li v-for="message in messages" :key="message.id" @click="$router.push({ name: 'read-message', params: { message } })">
                            <div class="col-mail col-mail-1">
                                <div class="checkbox-wrapper-mail"><input id="chk19" type="checkbox" class="form-check-input" /><label for="chk19" class="toggle"></label></div>
                                <a class="title" href="javascript:void(0);">{{ message.sender.first_name }} {{ message.sender.last_name }}</a><span class="star-toggle far fa-star"></span>
                            </div>
                            <div v-if="message.message_replies.length" class="col-mail col-mail-2">
                                <a class="subject" href="javascript:void(0);">{{ message.message_replies[0].message }}</span></a>
                                <div class="date">Mar 6 <!-- {{ message.created_at }} --></div>
                            </div>
                            <div v-else>
                                <a class="subject" href="javascript:void(0);">{{ message.title }}  – <span class="teaser">{{ message.message }}</span></a>
                                <div class="date">Mar 6 <!-- {{ message.created_at }} --></div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-7">Showing 1 - 20 of 1,524</div>
                    <div class="col-5">
                        <div class="btn-group float-right">
                            <button type="button" class="waves-effect btn btn-success btn-sm"><i class="fa fa-chevron-left"></i></button>
                            <button type="button" class="waves-effect btn btn-success btn-sm"><i class="fa fa-chevron-right"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</template>

<script>
import Leftbar from './layouts/Leftbar'
import Compose from './Compose'

export default {
    name: 'inbox',
    props: ['properties'],
    data: function () {
        return {
            formdata: {
                error: null
            },
            messages: [],
            show_compose: false,
        }
    },
    components: {
        Leftbar,
        Compose
    },
    methods: {
        getMessages: function () {
            var scope = this
            scope.formdata.error = null
            scope.GET('messages/' + scope.receiver.id).then(res => {
                scope.messages = res.rows
                console.log('getMessages:', scope.messages)
            })
        },
        toggleCompose: function () {
            var scope = this
            scope.show_compose = !scope.show_compose            
        }
    },
    computed: {
        receiver: function() {
            var scope = this
            return scope.$store.getters.getAuthenticatedUser
        }
    },
    mounted() {
        var scope = this
        scope.getMessages()
        setTimeout(function(){
            console.log('inbox getMessages', scope.messages[0].message_replies.length)
        },1000);
        
    }
}
</script>

