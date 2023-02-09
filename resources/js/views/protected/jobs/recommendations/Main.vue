<template>
    <div>
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="mb-0 font-size-18">Recommendations</h4>
            <div class="page-title-right">
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6 col-md-8">
                <RecommendationList></RecommendationList>
            </div>
        </div>
    </div>
</template>

<script>
import RecommendationList from './RecommendationList'

export default {
    name: 'job-recommendations-main',
    props: ['properties'],
    data: function () {
        return {
        }
    },
    computed: {
    },
    components: {
        RecommendationList
    },
    methods: {
    },
    mounted() {
        var scope = this
    }
}
</script>
<style scoped>
[id*="card-"] {
    display: none;
}

.bxs-check-circle {
    font-size: 17px;
    color: var(--primary);
}

.grey-container {
    border: 1px solid #ddd; border-radius: 4px; padding: 10px 12px; margin-bottom: 20px;
}

.badge.status {  font-size: 11.5px; }
</style>