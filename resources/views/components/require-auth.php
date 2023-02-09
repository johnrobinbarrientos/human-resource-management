<script>
    Vue.component('require-auth', {
        props: ['redirect'],
        data: function () {
            return {
            }
        },
        methods: {
            checkAuthenticatedUser: function () {
                var scope = this
                $.ajax({
                    url: "/api/auth/check",
                    type: "GET",
                    headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem('KX-PRIMUS')
                    },
                    success: function (response) {
                        if (response.success) {
                            console.log('authenticated')
                        } else {
                            location.href=scope.$props.redirect
                            localStorage.removeItem('KX-PRIMUS')
                        }
                    },
                    error: function(response) {
                        console.log(response)
                        if (response.status == 401) {
                            location.href= scope.$props.redirect
                            localStorage.removeItem('KX-PRIMUS')
                        }
                    }
                });
            }
        },
        mounted() {
            var scope = this
            scope.checkAuthenticatedUser()
        },
        template: `
        <div> 
        </div>`
    })
</script>