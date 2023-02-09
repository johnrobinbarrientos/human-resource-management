// Mixins are a flexible way to distribute reusable functionalities for Vue components.
import moment from 'moment'
export default {
    name: 'mixins',
    data () {
      return {
        msg: ''
      }
    },
    methods: {
        CHECK_VUE_INSTANCE: function () {
            console.log(this)
        },
        UNIQUE: function () {
            let key = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                // eslint-disable-next-line one-var
                var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8)
                return v.toString(16)
            })
            return key
        },
        LOCALIZED_UTC_DATE: function (date,format) {
            var stillUtc = moment.utc(date).toDate();
            var formatted = moment(stillUtc).local().format(format)
            return  formatted
        },
        ELLIPSIS: function (text,length) {
            // '<div>Hello</div>' ==> 'Hello'
            text = text.replace(/<\/?[^>]+(>|$)/g, "");
            if (text.length > length) {
                return text.substring(0, length) + '...';
            }
            return text;
        },
        RESPONSE: function (action,data) {
            var scope = this
            
            if (action === 'notify') {

            }

            if (data.status == 401) {
                localStorage.removeItem(window.TOKEN_KEY)
                this.$router.push({name: 'auth'})
            }
        },
        SET_COOKIE: function (cname, cvalue, exdays) {
            var d = new Date();
            d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
            var expires = "expires="+d.toUTCString();
            document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
        },
        GET_COOKIE: function (cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for(var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') {
                c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                }
            }
            return null;
        },
        ROUTE: function (data) {
            var scope = this
            scope.$router.push(data)
        },
        POST: function (name,payload) {
            var scope = this
            // scope.credentials.error = null
            return scope.axios
            .post(window.API_URL + '/' + name, payload,{
                'headers': {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem(window.TOKEN_KEY)
                }
            })
            .then(response => {
                var data = response.data
                return data
            })
            .catch(function (error) {

                var data = error.response.data
                var code = error.response.status
                data.code = code
                data.success = 0

                return data
            })
        },
        GET: function (name,payload = {}) {
            var scope = this
            // scope.credentials.error = null
            return scope.axios
            .get(window.API_URL + '/' + name,{
                params: payload,
                'headers': {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem(window.TOKEN_KEY)
                }
            })
            .then(response => {
                var data = response.data
                if (data.success) {
                    return data
                }
            })
            .catch(function (error) {
                var data = error.response.data
                var code = error.response.status
                return {rows: [], data: data, code: code }
            })
        },
        DELETE: function (name,payload = {}) {
            var scope = this
            // scope.credentials.error = null
            return scope.axios
            .delete(window.API_URL + '/' + name,{
                params: payload,
                'headers': {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem(window.TOKEN_KEY)
                }
            })
            .then(response => {
                var data = response.data
                if (data.success) {
                    return data
                }
            })
            .catch(function (error) {
                var data = error.response.data
                var code = error.response.status
                return {rows: [], data: data, code: code }
            })
        },
        PUT: function (name,payload) {
            var scope = this
            // scope.credentials.error = null
            return scope.axios
            .put(window.API_URL + '/' + name, payload,{
                'headers': {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Authorization': 'Bearer ' + localStorage.getItem(window.TOKEN_KEY)
                }
            })
            .then(response => {
                var data = response.data
                if (data.success) {
                    return data
                }
            })
            .catch(function (error) {
                var data = error.response.data
                var code = error.response.status
                data.code = code
                data.success = 0
                
                return data
            })
        }
    }
}