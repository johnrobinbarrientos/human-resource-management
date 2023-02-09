import Vue from 'vue'
import axios from 'axios'
import router from '../routes.js'

export default {
  strict: true, // make sure everything us mutated, no direct editing of state
  name: 'menu',
  state: {
    menus: null,
  },
  getters: {
    menus: state => {
        return state.menus
    },
  },
  mutations: {
    getMenus (state, payload) {
        var token = (window.TOKEN_KEY === null || localStorage.getItem(window.TOKEN_KEY) === '') ? 'INVALID' : localStorage.getItem(window.TOKEN_KEY)
        console.log(token)
        var headers = {
            'X-Requested-With': 'XMLHttpRequest',
            'Authorization': 'Bearer ' + token
        }
        axios
        .get(window.API_URL + '/menus',{ 
            params: { },
            'headers': headers 
        })
        .then(response => {
          if (response.data.success) {
            state.menus = response.data.menus
          }
        })
        .catch(function (error) {
            state.menus = []
        })
    },
  },
  actions: {
    getMenus ({ commit, state }, payload) {
        commit('getMenus', payload)
    },
  }
}
