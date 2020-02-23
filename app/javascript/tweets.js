import Vue from 'vue'
import Tweets from './tweets.vue'

document.addEventListener('DOMContentLoaded', () => {
  const tweets = document.getElementById('js-tweets')
  if (tweets) {
    const noteTitleHumanAttributeName = tweets.getAttribute(
      'data-note-title-human-attribute-name'
    )
    const noteTitle = tweets.getAttribute('data-note-title')
    const noteEditMode = tweets.getAttribute('data-note-edit_mode')
    const noteSearchSettingQuery = tweets.getAttribute(
      'data-note-search_setting-query'
    )
    const noteSearchSettingStartDatetime = tweets.getAttribute(
      'data-note-search_setting-start_datetime'
    )
    const noteSearchSettingEndDatetime = tweets.getAttribute(
      'data-note-search_setting-end_datetime'
    )
    const datetimeCurrent = tweets.getAttribute('data-datetime-current')

    new Vue({
      render: h =>
        h(Tweets, {
          props: {
            noteTitleHumanAttributeName: noteTitleHumanAttributeName,
            noteTitle: noteTitle,
            noteEditMode: noteEditMode,
            noteSearchSettingQuery: noteSearchSettingQuery,
            noteSearchSettingStartDatetime: noteSearchSettingStartDatetime,
            noteSearchSettingEndDatetime: noteSearchSettingEndDatetime,
            datetimeCurrent: datetimeCurrent
          }
        })
    }).$mount('#js-tweets')
  }
})
