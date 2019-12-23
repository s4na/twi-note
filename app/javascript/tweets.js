import Vue from 'vue'
import Tweets from './tweets.vue'

document.addEventListener('DOMContentLoaded', () => {
  const tweets = document.getElementById('js-tweets')
  if (tweets) {
    const noteTitleHumanAttributeName = tweets.getAttribute('data-note-title-human-attribute-name')
    const noteTitle = tweets.getAttribute('data-note-title')
    if (tweets) {
      new Vue({
        render: h => h(Tweets, { props: {
          noteTitleHumanAttributeName: noteTitleHumanAttributeName,
          noteTitle: noteTitle
        } })
      }).$mount('#js-tweets')
    }
  }
})
