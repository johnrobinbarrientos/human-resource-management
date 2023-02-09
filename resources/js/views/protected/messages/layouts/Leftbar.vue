<template>
    <div class="email-leftbar card">
        <button  @click="$parent.toggleCompose()" type="button" class="waves-effect waves-light btn btn-danger btn-block">Compose</button>
        <div class="mail-list mt-4">
            <a class="active" @click="$router.push({ name: 'inbox' })" href="javascript:void(0)"><i class="mdi mdi-email-outline mr-2"></i> Inbox <span class="ml-1 float-right">(18)</span></a>
            <a href="/email-inbox"><i class="mdi mdi-star-outline mr-2"></i>Starred</a>
            <a href="/email-inbox"><i class="mdi mdi-diamond-stone mr-2"></i>Important</a>
            <a href="/email-inbox"><i class="mdi mdi-file-outline mr-2"></i>Draft</a>
            <a href="/email-inbox"><i class="mdi mdi-email-check-outline mr-2"></i>Sent Mail</a>
            <a href="/email-inbox"><i class="mdi mdi-trash-can-outline mr-2"></i>Trash</a>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'Leftbar'
    }
</script>