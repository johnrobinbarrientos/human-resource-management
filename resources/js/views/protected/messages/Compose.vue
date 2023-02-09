<template>
<div class="rounded" style="width: 480px; position: absolute;z-index: 999;right: 0;bottom: 0; border: 1px solid #ddd; background: #fff; padding: 20px;">
    <div class="d-flex justify-content-between mb-4">
        <div class="d-flex align-items-center"><h4 class="mb-0">Compose Message</h4></div>
        <div><a @click="$parent.toggleCompose()" class="btn btn-danger rounded" href="javascript:void(0);">x</a></div>
    </div>
    <div><input v-model="formdata.receiver_id" class="w-100 mb-3 p-2" placeholder="Send to"></div>
    <div><input v-model="formdata.title" class="w-100 mb-3 p-2" placeholder="Write subject here.."></div>
    <div><textarea v-model="formdata.message" class="w-100 mb-4 p-2" style="height: 150px;" placeholder="Write message here.."></textarea></div>

    <a @click="save()" class="btn btn-primary" href="javascript:void(0);">Send</a>
</div>
</template>

<script>
    export default {
    name: 'compose',
    props: ['properties'],
    data: function () {
        return {
            formdata: {
                id: null,
                title: '',
                message: '',
                receiver_id: '',
                error: null
            },
            messages: [],
        }
    },  
    components: { },
    methods: {
        save: function() {
            var scope = this
            scope.formdata.sender_id = scope.sender.id
            scope.formdata.error = null
            scope.POST('messages', scope.formdata).then(res => {
                if(!res.success) {
                    alert('something went wrong')
                    return
                }
                alert('message sent!')
                scope.$parent.toggleCompose()
            })
        }
    },
    computed: {
        sender: function() {
            var scope = this
            return scope.$store.getters.getAuthenticatedUser
        }
    },
    mounted() {
        var scope = this
        console.log(scope.$store.getters.getAuthenticatedUser)
    }
}
</script>

