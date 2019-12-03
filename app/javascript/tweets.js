import Vue from 'vue'
import Tweets from './tweets.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = document.getElementById('js-tweets')
  const note_id = app.getAttribute('data-note-id')
  if (app) {
    new Vue({
      render: h => h(Tweets, { props: {
        note_id: note_id
      }})
    }).$mount('#js-tweets')
  }
})
