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
                    <div class="card-body">
                        <div class="mb-4 media">
                            <img class="d-flex mr-3 rounded-circle avatar-sm" src="/static/media/avatar-2.02aea0c2.jpg" alt="skote" />
                            <div class="media-body">
                                <h5 class="font-size-14 mt-1">{{ message.sender.first_name }} {{ message.sender.last_name }}</h5>
                                <small class="text-muted">support@domain.com</small>
                            </div>
                        </div>
                        <h4 class="mt-0 font-size-16"> {{ message.title }} </h4>
                        <p> {{ message.message }} </p>
                        
                        <hr />
                        
                        <div v-for="reply in replies" :key="reply.id" class="reply p-2">
                            <strong>{{ reply.sender.first_name }} {{ reply.sender.last_name }}</strong>
                            <p>{{ reply.message }}</p>
                        </div>

                        <hr />
                        <div v-if="!show_reply">
                            <a class="btn btn-secondary waves-effect mt-3 mb-3" @click="toggleReply"><i class="mdi mdi-reply"></i> Reply</a>
                        </div>
                        <div v-else>
                            <textarea v-model="formdata.message" class="w-100 p-3 mb-2" placeholder="Write a reply here.." style="height: 120px;"></textarea>
                            <a @click="sendReply()" class="btn btn-primary" href="javascript:void(0)">Send</a>
                            <a @click="toggleReply()" class="btn btn-danger" href="javascript:void(0)">Cancel</a>
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
    name: 'read-message',
    props: ['properties'],
    data: function () {
        return {
            formdata: {
                message_id: '',
                sender_id: '',
                receiver_id: '',
                message: '',
                error: null,
            },

            show_compose: false,
            show_reply: false,

            replies: [],
        }
    },
    components: { 
        Leftbar,
        Compose
    },
    methods: {
        toggleCompose: function () {
            var scope = this
            scope.show_compose = !scope.show_compose            
        },
        toggleReply: function() {
            var scope = this
            scope.show_reply = !scope.show_reply
        },
        resetFormdata: function() {
            var scope = this
            scope.formdata.message = ''
        },


        getReplies: function() {
            var scope = this
            scope.GET('message_replies/' + scope.message.id).then(res => {
                scope.replies = res.rows
                console.log('getReplies:', scope.replies)
            })
        },
        sendReply: function() {
            var scope = this
            scope.formdata.message_id = scope.message.id
            
            // receiver of the mail(user logged in) now becomes the sender of the reply
            scope.formdata.sender_id = scope.message.receiver.id
            scope.formdata.receiver_id = scope.message.sender.id

            scope.POST('message_replies', scope.formdata).then(res => {
                if(!res.success) {
                    alert('Something went wrong')
                    return
                }
                alert('reply sent!')
                scope.resetFormdata()
                scope.toggleReply()
                scope.getReplies()
            })
        }
    },
    computed: {
        message() {
            var scope = this
            return scope.$route.params.message
        }
    },
    mounted() {
        var scope = this
        scope.getReplies()
        console.log('$route.params.message', scope.message)
    }
}
</script>

