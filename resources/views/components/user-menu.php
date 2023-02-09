<script>
    Vue.component('user-menu', {
        data: function () {
            return {
                error: false,
                user: null,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem('KX-PRIMUS')
                },
            }
        },
        methods: {
            getAuthenticateduser: function () {
                var scope = this
                $.ajax({
                    url: "/api/auth/check",
                    type: "GET",
                    headers: scope.headers,
                    success: function (response) {
                        if (response.success) {
                            scope.user = response.user
                        }
                    },
                    error: function(res) {
                        var response = res.responseJSON
                        response.code = res.status
                        
                        if (response.code == 401) {
                            localStorage.removeItem('KX-PRIMUS')
                        }
                    }
                });
            },
            logout: function() {
                var scope = this
                $.ajax({
                    url: "/api/auth/revoke",
                    type: "GET",
                    headers: scope.headers,
                    success: function (response) {
                        localStorage.removeItem('KX-PRIMUS')
                    },
                    error: function(res) {
                        localStorage.removeItem('KX-PRIMUS')
                    }
                });
            }
        },
        mounted() {
            var scope = this
            scope.getAuthenticateduser()
        },
        template: `
        <div id="user-menu" class="header-right">
            <template v-if="!user">
                <a href="/auth" class="nav-item"><i class="las la-sign-in-alt"></i><span>Log in</span></a>
                <a href="/register" class="nav-item"><i class="las la-user-plus"></i><span>Register</span></a>
            </template>
            <template v-else>
                <a href="/dashboard" class="nav-item"><span>Hi {{ user.first_name }}!</span></a>
                <a @click="logout()" href="/register" class="nav-item"><i class="las la-power-off"></i><span>Logout</span></a>
            </template>
        </div>`
    })
</script>