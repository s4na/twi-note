import Vue from 'vue'
import Tweets from './tweets.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = document.getElementById('js-tweets')
  if (app) {
    new Vue({
      render: h => h(Tweets, {})
    }).$mount('#js-tweets')
  }
})
