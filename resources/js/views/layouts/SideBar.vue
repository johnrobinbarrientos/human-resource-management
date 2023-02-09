<template>
    <div class="vertical-menu">
    <div data-simplebar="true" class="h-100">
        <div data-simplebar="init" style="max-height: 100%;">
            <div class="simplebar-wrapper" style="margin: 0px;">
                <div class="simplebar-height-auto-observer-wrapper">
                    <div class="simplebar-height-auto-observer"></div>
                </div>
                <div class="simplebar-mask">
                    <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                        <div class="simplebar-content-wrapper" style="height: auto; overflow: hidden scroll;">
                            <div class="simplebar-content" style="padding: 0px;">
                                <div id="sidebar-menu">
                                    <ul class="metismenu list-unstyled mm-active" id="side-menu">
                                        <li class="menu-title">Menu</li>
                                        <li v-for="(menu, index) in menus" :key="'menu-' + index">
                                             <template v-if="menu.route !== '#has-submenu'">
                                                <a href="javascript:void(0);" @click="link(menu.route)" class="waves-effect is-page">
                                                    <i v-bind:class="menu.icon"></i>
                                                    <span>{{ menu.text }}</span>
                                                </a>
                                            </template>
                                            <template v-else>
                                                <a href="javascript:void(0);" class="has-arrow waves-effect">
                                                    <i v-bind:class="menu.icon"></i>
                                                    <span>{{ menu.text }}</span>
                                                </a>
                                                <ul class="sub-menu mm-collapse" aria-expanded="false">
                                                    <li v-for="(submenu1, index2) in menu.submenus" :key="'submenu-' + index + '-' + index2" >
                                                        <template v-if="submenu1.route !== '#has-submenu'">
                                                            <a href="javascript:void(0);"  @click="link(submenu1.route)" class="is-page">{{ submenu1.text }}</a>
                                                        </template>
                                                        <template v-else>
                                                            <a href="javascript:void(0);" class="has-arrow waves-effect">{{ submenu1.text }}</a>
                                                            <ul  class="sub-menu mm-collapse">
                                                                <li v-for="(submenu2, index3) in submenu1.submenus" :key="'submenu-' + index2 + '-' + index3" class="nk-menu-item">
                                                                    <a href="javascript:void(0);" class="has-arrow waves-effect">
                                                                        <span class="nk-menu-icon"><em v-bind:class="submenu2.icon"></em></span>
                                                                        <span class="nk-menu-text">{{ submenu2.text }}</span>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </template>
                                                    </li>
                                                </ul>
                                            </template>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="simplebar-placeholder" style="width: 250px; height: 1300px;"></div>
            </div>
            <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
            </div>
            <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                <div class="simplebar-scrollbar" style="height: 527px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
            </div>
        </div>
    </div>
</div>
</template>

<script>
    export default {
    name: 'SideBar',
    props: ['properties'],
    data: function () {
        return {
            
        }
    },
    computed: {
        menus: function () {
            return this.$store.getters.menus 
        }
    },
    components: {
    
    },
    methods: {
        link: function (path) {
           var scope = this
           scope.$router.push({path: path})
        },
    },
    mounted() {
        var scope = this
    }
}
</script>