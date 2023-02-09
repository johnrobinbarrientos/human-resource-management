require('./bootstrap');
import Vue from 'vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import Vuex from 'vuex'
import Notifications from 'vue-notification'

import datePicker from 'vue-bootstrap-datetimepicker';
import 'pc-bootstrap4-datetimepicker/build/css/bootstrap-datetimepicker.css';

import VuePhoneNumberInput from 'vue-phone-number-input';
import 'vue-phone-number-input/dist/vue-phone-number-input.css';

import moment from 'moment'

Vue.component('vue-phone-number-input', VuePhoneNumberInput);
import Multiselect from 'vue-multiselect'
import 'vue-multiselect/dist/vue-multiselect.min.css'

// CSS 
// import './assets/vendors/lineawesome/css/line-awesome.min.css'
//import './assets/themes/css/dashlite.css?ver=1.6.0'
//import './assets/themes/css/skins/theme-blue.css?ver=1.6.0'
//import './assets/css/custom.css'

// JS
//import './assets/themes/js/bundle.js?ver=1.6.0'
//import './assets/js/custom.js?ver=1.6.0'
// import './assets/themes/js/scripts.js?ver=1.6.0'
// import './assets/themes/js/charts/chart-crypto.js?ver=1.6.0'

// includes
import stores from './stores'
import router from './routes'
import customs from './utils/customs'
import mixins from './utils/mixins'

// components
import App from './views/App'

window.TOKEN_KEY = 'KX-PRIMUS'
window.VERSION = 1
window.API_URL = '//'+ window.location.host +'/api'

/*
var version = localStorage.getItem('KX-VERSION')
if (!version || version == null || version < window.VERSION) {
    localStorage.removeItem(window.TOKEN_KEY);
    localStorage.setItem('KX-VERSION',window.VERSION);
}
*/

Vue.use(VuePhoneNumberInput)
Vue.component('multiselect', Multiselect)

Vue.use(datePicker)
Vue.use(Vuex) 
Vue.use(VueAxios, axios)
Vue.use(Notifications)
Vue.use(moment)
Vue.mixin(customs)
Vue.mixin(mixins)
Vue.mixin(require('./assets'));

window.swal = require('sweetalert2')

const store = new Vuex.Store({
    modules : stores
})

const app = new Vue({
    el: '#app',
    components: { App },
    router,
    store
});