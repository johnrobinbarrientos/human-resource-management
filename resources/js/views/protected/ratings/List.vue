<template>
<div v-if="ready" class="rate-wrap" >
    <div class="row">
        <div class="col-md-5">
            <div style="margin-top:-10px; text-align:center; display:inline-block;">
                <h2 style=" margin:0px;  font-weight:900; font-size:65px; display:inline-block;">{{ averages.total.toFixed(1) }}</h2>
                <div class="overall-average">
                    <i :class="{'active' : Math.floor(averages.total) >= 1}" class="bx bxs-star"></i>
                    <i :class="{'active' : Math.floor(averages.total) >= 2}" class="bx bxs-star"></i>
                    <i :class="{'active' : Math.floor(averages.total) >= 3}" class="bx bxs-star"></i>
                    <i :class="{'active' : Math.floor(averages.total) >= 4}" class="bx bxs-star"></i>
                    <i :class="{'active' : Math.floor(averages.total) >= 5}" class="bx bxs-star"></i>
                </div>
            </div>
        </div>
        <div class="col-md-7">
            <div style="margin-top:8px;">
                <div class="row">
                    <div class="col-md-8">
                        <strong>Job Competency</strong>
                    </div>
                    <div class="col-md-4">
                        <div class="category-average text-right">
                            <i :class="{'filled' : averages.job_competency >= 1}" class="bx bxs-star"></i>
                            <i :class="{'filled' : averages.job_competency >= 2}" class="bx bxs-star"></i>
                            <i :class="{'filled' : averages.job_competency >= 3}" class="bx bxs-star"></i>
                            <i :class="{'filled' : averages.job_competency >= 4}" class="bx bxs-star"></i>
                            <i :class="{'filled' : averages.job_competency >= 5}" class="bx bxs-star"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div style="margin-top:8px;">
                <div class="row">
                    <div class="col-md-8">
                        <strong>Health & Safety Performance</strong>
                    </div>
                    <div class="col-md-4">
                        <div class="category-average text-right">
                            <i :class="{'filled' : Math.floor(averages.health_safety_performance) >= 1}" class="bx bxs-star"></i>
                            <i :class="{'filled' : Math.floor(averages.health_safety_performance) >= 2}" class="bx bxs-star"></i>
                            <i :class="{'filled' : Math.floor(averages.health_safety_performance) >= 3}" class="bx bxs-star"></i>
                            <i :class="{'filled' : Math.floor(averages.health_safety_performance) >= 4}" class="bx bxs-star"></i>
                            <i :class="{'filled' : Math.floor(averages.health_safety_performance) >= 5}" class="bx bxs-star"></i>
                            
                        </div>
                    </div>
                </div>
            </div>

            <div style="margin-top:8px;">
                <div class="row">
                    <div class="col-md-8">
                        <strong>Work Ethic</strong>
                    </div>
                    <div class="col-md-4">
                        <div class="category-average text-right">
                            <i :class="{'filled' : Math.floor(averages.work_ethic) >= 1}" class="bx bxs-star"></i>
                            <i :class="{'filled' : Math.floor(averages.work_ethic) >= 2}" class="bx bxs-star"></i>
                            <i :class="{'filled' : Math.floor(averages.work_ethic) >= 3}" class="bx bxs-star"></i>
                            <i :class="{'filled' : Math.floor(averages.work_ethic) >= 4}" class="bx bxs-star"></i>
                            <i :class="{'filled' : Math.floor(averages.work_ethic) >= 5}" class="bx bxs-star"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            
        </div>
    </div>

    <div style="border-top:1px solid #efefef; margin-top:20px; padding:10px 0px;">
        <div v-for="rating in ratings" :key="'rating' + rating.id" style="padding:10px 5px; margin-bottom:10px; border-bottom:1px solid #efefef">
            <strong  style="font-size:20px;">{{ rating.reviewer.company.name }}</strong>
            <div style="margin-top:8px;">
                <div class="row">
                    <div class="col-md-5">
                        <strong>Job Competency</strong>
                    </div>
                    <div class="col-md-7">
                        <div class="category-average">
                            <i :class="{'filled' : rating.job_competency >= 1}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.job_competency >= 2}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.job_competency >= 3}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.job_competency >= 4}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.job_competency >= 5}" class="bx bxs-star"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div style="margin-top:8px;">
                <div class="row">
                    <div class="col-md-5">
                        <strong>Health & Safety Performance</strong>
                    </div>
                    <div class="col-md-7">
                        <div class="category-average">
                            <i :class="{'filled' : rating.health_safety_performance >= 1}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.health_safety_performance >= 2}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.health_safety_performance >= 3}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.health_safety_performance >= 4}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.health_safety_performance >= 5}" class="bx bxs-star"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div style="margin-top:8px;">
                <div class="row">
                    <div class="col-md-5">
                        <strong>Work Ethic</strong>
                    </div>
                    <div class="col-md-7">
                        <div class="category-average">
                            <i :class="{'filled' : rating.work_ethic >= 1}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.work_ethic >= 2}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.work_ethic >= 3}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.work_ethic >= 4}" class="bx bxs-star"></i>
                            <i :class="{'filled' : rating.work_ethic >= 5}" class="bx bxs-star"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div style="margin-top:15px; font-size:16px;">
                <i>{{ rating.comment }}</i>
            </div>
        </div>
    </div>
   
</div>
</template>

<style>
    .overall-average i { font-size:18px; color:#ccc; }
    .overall-average i, .category-average i { color:#ccc; }
    .overall-average i.filled, .category-average i.filled { color:#fcc300; }
</style>

<script>
export default {
    name: 'ratings-list',
    props: ['properties'],
     data: function () {
        return {
            ready: false,
            ratings: [],
            averages: null,
        }
    },
    computed: {
    },
    watch: {
        
    },
    components: {

    },
    methods: {
        getUserRatings: function () {
            var scope = this
            scope.GET('users/' + scope.user_id + '/ratings' ).then(res => {
                scope.ready = true
                scope.ratings = res.ratings
                scope.averages = res.averages
                // console.log('asdsaddsd')
                // console.log(scope.averages)
            })
        },
    },
    mounted() {
        var scope = this
        setTimeout(function(){
            scope.user_id = scope.properties.user_id
            if (scope.user_id) {
                scope.getUserRatings();
            }
        },1000);
        
       
    }
}
</script>