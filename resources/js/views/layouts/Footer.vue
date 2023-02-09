<template>
<div class="nk-footer nk-footer-fluid">
    <div class="container-fluid">
        <div class="nk-footer-wrap">
            <div class="nk-footer-copyright"> &copy; 2020 DashLite. Template by <a href="#">Softnio</a>
            </div>
            <div class="nk-footer-links">
                <ul class="nav nav-sm">
                    <li class="nav-item"><a class="nav-link" href="#">Terms</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Privacy</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Help</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</template>

<script>
    export default {
    name: 'Footer',
    props: ['properties'],
    data: function () {
        return {
            
        }
    },
    components: {
    
    },
    methods: {
        link: function (name) {
           var scope = this
           scope.$router.push({name: name})
        },
        logout: function () {
          var scope = this
          localStorage.removeItem("kxtoken");
          scope.$router.push({name: 'auth'})
        }
    },
    mounted() {
        
    }
}
</script>