<template>
    <header id="page-topbar">
        <div class="navbar-header">
            <div class="d-flex">
                <div style="border-right: 1px solid #efefef;  border-bottom: 1px solid #2c3e50;" class="navbar-brand-box">
                    <a href="https://primusworkforce.com/" style="font-size:20px; font-weight:600; color:#fff;">
                        <img class="main-header-logo desktop" :src="logo">
                        <img class="main-header-logo mobile"  :src="icon">
                      
                    </a>
                </div>
                <button type="button" class="btn btn-sm px-3 font-size-16 header-item waves-effect" id="vertical-menu-btn"><i class="mdi mdi-menu"></i></button>
        
                
            </div>
            <div class="d-flex">
                <div class="dropdown d-inline-block d-lg-none ml-2">
                    <button type="button" class="btn header-item noti-icon waves-effect" id="page-header-search-dropdown"><i class="mdi mdi-magnify"></i></button>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right p-0" aria-labelledby="page-header-search-dropdown">
                        <form class="p-3">
                            <div class="form-group m-0">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search ..." aria-label="Recipient&#39;s username">
                                    <div class="input-group-append"><button class="btn btn-primary" type="submit"><i class="mdi mdi-magnify"></i></button></div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <li style="display:none;" class="dropdown d-inline-block dropdown">
                    <button style="display:none;" id="page-header-notifications-dropdown" aria-haspopup="true" class="btn header-item noti-icon waves-effect" aria-expanded="false"><i class="bx bx-bell bx-tada"></i><span class="badge badge-danger badge-pill">3</span></button>
                    <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu dropdown-menu-lg p-0 dropdown-menu dropdown-menu-right">
                        <div class="p-3">
                            <div class="align-items-center row">
                                <div class="col">
                                    <h6 class="m-0"> Notifications </h6>
                                </div>
                                <div class="col-auto"><a href="javascript:void(0);#!" class="small"> View All</a></div>
                            </div>
                        </div>
                        <div data-simplebar="init" style="height: 230px;">
                            <div class="simplebar-wrapper" style="margin: 0px;">
                                <div class="simplebar-height-auto-observer-wrapper">
                                    <div class="simplebar-height-auto-observer"></div>
                                </div>
                                <div class="simplebar-mask">
                                    <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                        <div class="simplebar-content-wrapper" style="height: auto; overflow: hidden;">
                                            <div class="simplebar-content" style="padding: 0px;">
                                                <a class="text-reset notification-item" href="javascript:void(0);">
                                                    <div class="media">
                                                        <div class="avatar-xs mr-3"><span class="avatar-title bg-primary rounded-circle font-size-16"><i class="bx bx-cart"></i></span></div>
                                                        <div class="media-body">
                                                            <h6 class="mt-0 mb-1">Your order is placed</h6>
                                                            <div class="font-size-12 text-muted">
                                                                <p class="mb-1">If several languages coalesce the grammar</p>
                                                                <p class="mb-0"><i class="mdi mdi-clock-outline"></i> 3 min ago </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                                <a class="text-reset notification-item" href="javascript:void(0);">
                                                    <div class="media">
                                                        <img src="" class="mr-3 rounded-circle avatar-xs" alt="user-pic">
                                                        <div class="media-body">
                                                            <h6 class="mt-0 mb-1">James Lemire</h6>
                                                            <div class="font-size-12 text-muted">
                                                                <p class="mb-1">It will seem like simplified English.</p>
                                                                <p class="mb-0"><i class="mdi mdi-clock-outline"></i>1 hours ago </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                                <a class="text-reset notification-item" href="javascript:void(0);">
                                                    <div class="media">
                                                        <div class="avatar-xs mr-3"><span class="avatar-title bg-success rounded-circle font-size-16"><i class="bx bx-badge-check"></i></span></div>
                                                        <div class="media-body">
                                                            <h6 class="mt-0 mb-1">Your item is shipped</h6>
                                                            <div class="font-size-12 text-muted">
                                                                <p class="mb-1">If several languages coalesce the grammar</p>
                                                                <p class="mb-0"><i class="mdi mdi-clock-outline"></i> 3 min ago</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                                <a class="text-reset notification-item" href="javascript:void(0);">
                                                    <div class="media">
                                                        <img src="" class="mr-3 rounded-circle avatar-xs" alt="user-pic">
                                                        <div class="media-body">
                                                            <h6 class="mt-0 mb-1">Salena Layfield</h6>
                                                            <div class="font-size-12 text-muted">
                                                                <p class="mb-1">As a skeptical Cambridge friend of mine occidental.</p>
                                                                <p class="mb-0"><i class="mdi mdi-clock-outline"></i>1 hours ago </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="simplebar-placeholder" style="width: 0px; height: 0px;"></div>
                            </div>
                            <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                                <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                            </div>
                            <div class="simplebar-track simplebar-vertical" style="visibility: hidden;">
                                <div class="simplebar-scrollbar" style="height: 0px; display: none;"></div>
                            </div>
                        </div>
                        <div class="p-2 border-top"><a class="btn btn-sm btn-link font-size-14 btn-block text-center" href="javascript:void(0);"> View all </a></div>
                    </div>
                </li>



                <div id="user-setting-dropdown" class="d-inline-block dropdown">
                    <button id="page-header-user-dropdown" class="btn header-item waves-effect dropdown-toggle" type="button"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img class="rounded-circle header-profile-user" :src="avatar" alt="Header Avatar">
                        <span class="d-none d-xl-inline-block ml-2 mr-1">{{ user.first_name }} {{ user.last_name }}</span>
                        <i class="mdi mdi-chevron-down d-none d-xl-inline-block"></i>
                    </button>
                    <div role="menu" aria-hidden="true" class="dropdown-menu dropdown-menu-right" aria-labelledby="page-header-user-dropdown">
                        <a @click="$router.push({ name: 'profile' })" href="javascript:void(0);" tabindex="0" role="menuitem" class="dropdown-item">
                            <i class="bx bx-user font-size-16 align-middle mr-1"></i> Profile Settings
                        </a>
                        <!--<a href="javascript:void(0);#" tabindex="0" role="menuitem" class="dropdown-item">
                            <span style="display:none;" class="badge badge-success float-right mt-1">5</span>
                            <i class="bx bx-wrench font-size-17 align-middle mr-1"></i> Settings
                        </a>-->
                        <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="javascript:void(0);" @click="logout()">
                                <i class="bx bx-power-off font-size-16 align-middle mr-1 text-danger"></i><span>Logout</span>
                            </a>
                    </div>
                </div>
            </div>
        </div>
    </header>
<!-- main header @e -->
</template>

<script>

    import logo from '../../assets/themes/images/logo-white.png';
    import avatar from '../../assets/themes/images/icon.png';
    import icon from '../../assets/themes/images/icon.png';
    import Profile from '../protected/Profile'

    export default {
    name: 'Header',
    props: ['properties'],
    data: function () {
        return {
            logo,
            avatar,
            icon,
        }
    },
    computed: {
        user: function () {
            return this.$store.getters.getAuthenticatedUser 
        } 
    },
    components: {
        Profile
    },
    methods: {
        link: function (name) {
           var scope = this
           scope.$router.push({name: name})
        },
        logout: function () {
            this.$store.dispatch('revoke',{ token: '' })
        }
    },
    mounted() {
        var scope = this
        //console.log(scope.user)



    }
}
</script>