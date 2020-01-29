import Vue from 'vue'
import NoteBodyCopy from './note-body-copy.vue'

document.addEventListener('DOMContentLoaded', () => {
  const noteBodyCopy = document.getElementById('js-note-body-copy')
  if (noteBodyCopy) {
    new Vue({
      render: h => h(NoteBodyCopy, {})
    }).$mount('#js-note-body-copy')
  }
})
