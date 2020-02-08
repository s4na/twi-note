import Vue from 'vue'
import Tweets from './tweets.vue'

document.addEventListener('DOMContentLoaded', () => {
  const tweets = document.getElementById('js-tweets')
  if (tweets) {
    const noteTitleHumanAttributeName = tweets.getAttribute('data-note-title-human-attribute-name')
    const noteTitle = tweets.getAttribute('data-note-title')
    const noteEditMode = tweets.getAttribute('data-note-edit-mode')

    if (tweets) {
      new Vue({
        render: h => h(Tweets, { props: {
          propNoteTitleHumanAttributeName: noteTitleHumanAttributeName,
          propNoteTitle: noteTitle,
          propNoteEditMode: noteEditMode
        } })
      }).$mount('#js-tweets')
    }
  }
})
