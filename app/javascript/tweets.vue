<template lang="pug">
  .search-form__items
    .search-form__item
      h2.search-form__title
        label
          | {{ noteTitleHumanAttributeName }}
        input(type="text" name="note[title]" id="note_title" :value="noteTitle")
    .search-form__item
      p
        | 検索欄
    .search-form__item
      label.search-form__query
        | query
      input(ref="query" type="text" value="#sendagayarb")
    .search-form__item
      label.search-form__start-datetime
        | start_datetime
      input(ref="start_datetime" type="text" name="tweets-search[start_datetime]" value="2019-12-01 23:59")
    .search-form__item
      label.search-form__end-datetime
        | end_datetime
      input(ref="end_datetime" type="text" name="tweets-search[end_datetime]" value="2019-12-25 23:59")
      .search-form__button
        button(type="button" @click="searchTweets")
          | 検索

    .search-form__body
      .search-result
        label
          | Tweets
        draggable(class="list-group" :list="search_result_tweets" group="people")#note-tweets-preview
          .list-group-item(v-for="(element, index) in search_result_tweets" :key="element.id_str")
            tweet(:tweet="element")

      .note
        .note__inner.is-preview
          label
            | Notes
          button(type="button" @click="changeMarkdown()")
            | Markdownに切り替え
          draggable(class="list-group" :list="note_tweets" group="people")
            .list-group-item(v-for="(element, index) in note_tweets" :key="element.id_str")
              tweet(:tweet="element")
          input.note_tweets(type="hidden" name="note[tweets]" :value="JSON.stringify(note_tweets)")
        .note__inner.is-markdown
          .note__form
            tweets_markdown.note__textarea(ref="tweets_markdown"
              :tweets="note_tweets"
              :parent_all_search_result_tweets="all_search_result_tweets"
              title="List 1"
            )

</template>
<script>
import Draggable from 'vuedraggable'
import Tweet from 'tweet'
import TweetsMarkdown from 'tweets_markdown'
import Markdown2Tweets from './markdown2tweets.js'

export default {
  props: {
    noteTitleHumanAttributeName: String,
    noteTitle: String,
  },
  components: {
    'draggable': Draggable,
    'tweet': Tweet,
    'tweets_markdown': TweetsMarkdown,
  },
  data: function () {
    return {
      all_search_result_tweets: [],
      search_result_tweets: [],
      note_tweets: [],
      note_body: String
    }
  },
  created() {
    // if innerText is null then []
    if (document.querySelector('#js-note-tweets') !== null) {
      this.note_tweets = JSON.parse(document.querySelector('#js-note-tweets').innerText || null) || []
    }
    if (document.querySelector('#js-note-body') !== null) {
      this.note_body = document.querySelector('#js-note-body').innerText || null
    }
  },
  methods: {
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    searchTweets: function() {
      this.search_result_tweets = []
      const query = encodeURIComponent(this.$refs.query.value)
      const start_datetime = encodeURIComponent(this.$refs.start_datetime.value)
      const end_datetime = encodeURIComponent(this.$refs.end_datetime.value)

      fetch(`/api/tweets.json?query=${query}&start_datetime=${start_datetime}&end_datetime=${end_datetime}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin',
        redirect: 'manual',
      })
        .then(response => { return response.json() })
        .then(json=> {
          json.forEach(c => {
            this.search_result_tweets.push(c)
            this.all_search_result_tweets.push(c)
          })
        })
        .catch(error => { console.warn('Failed to parsing', error) })
    },
    changeMarkdown () {
      var m2t = new Markdown2Tweets({'tweets': this.note_tweets})
      this.$refs.tweets_markdown.body = m2t.setMarkdown()
    }
  }
}
</script>
<style scoped lang="scss">
.search-form__body {
  display: flex;
  flex-direction: row;
  .search-result {
    width: 33%;
  }
  .note {
    display: flex;
    width: 66%;
    .note__inner {
      width: 50%;
    }
  }
}
</style>
