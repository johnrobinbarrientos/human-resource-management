import Vue from 'vue'
import axios from 'axios'
import router from '../routes.js'

export default {
  strict: true, // make sure everything us mutated, no direct editing of state
  name: 'auth',
  state: {
    user: null,
    isAuthenticated: false
  },
  getters: {
    isAuthenticated: state => {
        return state.isAuthenticated
    },
    getAuthenticatedUser: state => {
        return state.user
    },
  },
  mutations: {
    authenticate  (state, payload) {
        localStorage.setItem(window.TOKEN_KEY, payload.token);
        state.isAuthenticated = true
        state.user = payload.user
        this.dispatch('getMenus',{})

        setTimeout(function(){
            //router.push({name: 'dashboard'})
            location.href = (!payload.redirect) ? '/dashboard' :  payload.redirect
        },0);
    },
    revoke (state, payload) {
        var token = (localStorage.getItem(window.TOKEN_KEY) === null || localStorage.getItem(window.TOKEN_KEY) === '') ? 'INVALID' : localStorage.getItem(window.TOKEN_KEY)
        var headers = {
            'X-Requested-With': 'XMLHttpRequest',
            'Authorization': 'Bearer ' + token
        }

        axios
        .get(window.API_URL + '/auth/revoke',{ 
            params: { },
            'headers': headers 
        })
        .then(response => {
          if (response.data.success) {
            state.isAuthenticated = false
            state.user = null
            localStorage.removeItem(window.TOKEN_KEY);
            router.push({name: 'auth'})
          }
        })
        .catch(function (error) {
            state.isAuthenticated = false
            state.user = null
            localStorage.removeItem(window.TOKEN_KEY)
            router.push({name: 'auth'})
        })
    },
    checkAuthenticated (state, payload) {
        var token = (localStorage.getItem(window.TOKEN_KEY) === null || localStorage.getItem(window.TOKEN_KEY) === '') ? 'INVALID' : localStorage.getItem(window.TOKEN_KEY)
        var headers = {
            'X-Requested-With': 'XMLHttpRequest',
            'Authorization': 'Bearer ' + token
        }

        axios
        .get(window.API_URL + '/auth/check',{ 
            params: { },
            'headers': headers 
        })
        .then(response => {
          if (response.data.success) {
            state.isAuthenticated = true
            state.user = response.data.user
          } else {
            state.isAuthenticated = false
            state.user = null
            router.push({name: 'auth'})
            localStorage.clear()
          }
        })
        .catch(function (error) {
            var data = error.response.data
            var code = error.response.status
            if (code === 401) {
                //router.push({name: 'auth'})
                localStorage.clear()
            }
        })
    },
    updateAvatar(state, payload) {
        state.user.avatar = payload.avatar
    },
  },
  actions: {
    authenticate ({ commit, state }, payload) {
        commit('authenticate', payload)
    },
    revoke ({ commit, state }, payload) {
        commit('revoke', payload)
    },
    checkAuthenticated ({ commit, state }, payload) {
        commit('checkAuthenticated', payload)
    },
    updateAvatar ({ commit, state }, payload) {
        commit('updateAvatar', payload)
    }
  }
}
