<template>
<div class="rate-wrap" v-if="ready" :class="{'no-edit': disable_edit}">
    <div v-if="formdata.response_status == 'success'" class="alert alert-success">
        <strong>Success!</strong>
        Your review has been successfully saved!
    </div>
    <div  v-if="formdata.response_status == 'error'" class="alert alert-danger">
        <strong>Error!</strong>
        <span v-if="formdata.response_message == ''">An error occur while processing...</span>
        <span v-else>{{ formdata.response_message }}</span>
    </div>
    <div class="rate-category">
        <h4>Job Competency</h4>
        <p>Competencies are the knowledge, skills, abilities, personal characteristics and other "worker-based" factors</p>
        <div class="stars">
            <i v-if="formdata.job_competency >= 1" @click="rate('job_competency',1)" class="bx bxs-star active"></i>
            <i v-else @click="rate('job_competency',1)" class="bx bx-star"></i>

            <i v-if="formdata.job_competency >= 2" @click="rate('job_competency',2)" class="bx bxs-star active"></i>
            <i v-else @click="rate('job_competency',2)" class="bx bx-star"></i>

            <i v-if="formdata.job_competency >= 3" @click="rate('job_competency',3)" class="bx bxs-star active"></i>
            <i v-else @click="rate('job_competency',3)" class="bx bx-star"></i>

            <i v-if="formdata.job_competency >= 4" @click="rate('job_competency',4)" class="bx bxs-star active"></i>
            <i v-else @click="rate('job_competency',4)" class="bx bx-star"></i>

            <i v-if="formdata.job_competency >= 5" @click="rate('job_competency',5)" class="bx bxs-star active"></i>
            <i v-else @click="rate('job_competency',5)" class="bx bx-star"></i>
        </div>
    </div>


    <div class="rate-category">
        <h4>Health &amp; Safety Performance</h4>
        <p>Competencies are the knowledge, skills, abilities, personal characteristics and other "worker-based" factors</p>
        <div class="stars">
            <i v-if="formdata.health_safety_performance >= 1" @click="rate('health_safety_performance',1)" class="bx bxs-star active"></i>
            <i v-else @click="rate('health_safety_performance',1)" class="bx bx-star"></i>

            <i v-if="formdata.health_safety_performance >= 2" @click="rate('health_safety_performance',2)" class="bx bxs-star active"></i>
            <i v-else @click="rate('health_safety_performance',2)" class="bx bx-star"></i>

            <i v-if="formdata.health_safety_performance >= 3" @click="rate('health_safety_performance',3)" class="bx bxs-star active"></i>
            <i v-else @click="rate('health_safety_performance',3)" class="bx bx-star"></i>

            <i v-if="formdata.health_safety_performance >= 4" @click="rate('health_safety_performance',4)" class="bx bxs-star active"></i>
            <i v-else @click="rate('health_safety_performance',4)" class="bx bx-star"></i>

            <i v-if="formdata.health_safety_performance >= 5" @click="rate('health_safety_performance',5)" class="bx bxs-star active"></i>
            <i v-else @click="rate('health_safety_performance',5)" class="bx bx-star"></i>
        </div>
    </div>


    <div class="rate-category">
        <h4>Work Ethic</h4>
        <p>Competencies are the knowledge, skills, abilities, personal characteristics and other "worker-based" factors</p>
        <div class="stars">
            <i v-if="formdata.work_ethic >= 1" @click="rate('work_ethic',1)" class="bx bxs-star active"></i>
            <i v-else @click="rate('work_ethic',1)" class="bx bx-star"></i>

            <i v-if="formdata.work_ethic >= 2" @click="rate('work_ethic',2)" class="bx bxs-star active"></i>
            <i v-else @click="rate('work_ethic',2)" class="bx bx-star"></i>

            <i v-if="formdata.work_ethic >= 3" @click="rate('work_ethic',3)" class="bx bxs-star active"></i>
            <i v-else @click="rate('work_ethic',3)" class="bx bx-star"></i>

            <i v-if="formdata.work_ethic >= 4" @click="rate('work_ethic',4)" class="bx bxs-star active"></i>
            <i v-else @click="rate('work_ethic',4)" class="bx bx-star"></i>

            <i v-if="formdata.work_ethic >= 5" @click="rate('work_ethic',5)" class="bx bxs-star active"></i>
            <i v-else @click="rate('work_ethic',5)" class="bx bx-star"></i>
        </div>
    </div>

    <div style="padding:10px 0px; border-bottom:1px solid #efefef">
        <h4 style="font-size:14px; font-weight:900; margin-bottom:5px;">How was your experience?</h4>
        <textarea  v-if="!disable_edit" v-model="formdata.comment" class="form-control" rows="4"></textarea>
        <p v-else>{{ formdata.comment }}</p>
    </div>

    <div v-if="!disable_edit" style="text-align:right; margin-top:10px;">
        <button @click="save()" data-toggle="modal" class="btn btn-primary">Publish Review</button>
    </div>
</div>
</template>

<style>
    .rate-wrap .rate-category {  padding:10px 0px; border-bottom:1px solid #efefef; }
    .rate-wrap .rate-category h4 { font-weight:900; font-size:16px; margin-bottom:5px; }
    .rate-wrap .rate-category p { margin-bottom:5px; }
    .rate-wrap .rate-category .stars { display:inline-block; }
    .rate-wrap .rate-category .stars i { font-size:35px; cursor:pointer; }

    .rate-wrap .rate-category .stars:hover i, .rate-wrap .rate-category .stars i.active { color:#fcc300; }
    
    .rate-wrap .rate-category .stars i:hover { color:#fcc300; }
    .rate-wrap .rate-category .stars i:hover ~ i { color: #495057; }
    .rate-wrap .rate-category .stars i.active:hover { color:#f9d65d; }

    .rate-wrap.no-edit .rate-category .stars i { cursor:initial !important; }
    .rate-wrap.no-edit .rate-category .stars:hover i { color:#495057 !important; }
    .rate-wrap.no-edit .rate-category .stars i.active { color:#fcc300 !important; }
</style>

<script>
export default {
    name: 'ratings-form',
    props: ['properties'],
     data: function () {
        return {
            ready: false,
            disable_edit: false,
            formdata: {
                response_status: 'default',
                response_message: '',
                job_competency: 0,
                health_safety_performance: 0,
                work_ethic: 0,
                comment: '',
                job_post_id: null,
                user_id: null,
            }
            
        }
    },
    computed: {
    },
    watch: {
 
    },
    components: {

    },
    methods: {
        rate: function (category,rate) {
            var scope = this
            if (scope.disable_edit) {
                return;
            }

            if (category == 'job_competency') {
                scope.formdata.job_competency = rate
            } else if (category == 'health_safety_performance') {
                scope.formdata.health_safety_performance = rate
            } else if (category == 'work_ethic') {
                scope.formdata.work_ethic = rate
            }
        },
        save: function() {
            var scope = this
            scope.POST('users/ratings', scope.formdata)
            .then(function (res) {
                if (!res.success) {
                    scope.formdata.response_status = 'error'
                    scope.formdata.response_message = res.message
                    return
                }
                scope.formdata.response_status = 'success'
            });
                
           
        },
        getUserJobRating: function () {
            var scope = this

            scope.GET('users/' + scope.formdata.user_id + '/ratings/' + scope.formdata.job_post_id ).then(res => {
                scope.ready = true
                if (res.data) {
                    scope.formdata.job_competency = res.data.job_competency
                    scope.formdata.health_safety_performance = res.data.health_safety_performance
                    scope.formdata.work_ethic = res.data.work_ethic
                    scope.formdata.comment = res.data.comment
                    scope.disable_edit = true
                }
                
            })
        },
    },
    mounted() {
        var scope = this
        
        scope.formdata.user_id = scope.properties.user_id
        scope.formdata.job_post_id = scope.properties.job_post_id

        if (scope.formdata.user_id && scope.formdata.job_post_id) {
            scope.getUserJobRating();
        }
    }
}
</script>