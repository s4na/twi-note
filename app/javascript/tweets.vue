<template lang="pug">
  .search-form__inner
    .row
      .col.s6
        .search-form__title
          h3
            | ツイート検索
        .search-form__body.col.s12
          .search-form__items.col.s6
            .search-form__item
              label.search-form__query
                | 検索キーワード（例：#sendagayarb）
              input(ref="query" type="text" value="#sendagayarb")
            .search-form__item
              label.search-form__start-datetime
                | 開始日時
              input(ref="start_datetime" type="text" name="tweets-search[start_datetime]" value="2019-12-15 23:59")
            .search-form__item
              label.search-form__end-datetime
                | 終了日時
              input(ref="end_datetime" type="text" name="tweets-search[end_datetime]" value="2019-12-25 23:59")
              .search-form__button
                button(type="button" @click="searchTweets").a-search-button.waves-effect.waves-light.btn
                  | 検索

          //- .search-form__body
          .search-result.col.s6
            label
              | 検索結果
            draggable(:list="search_result_tweets" group="people")#note-tweets-preview.cards
              tweet(:tweet="element" v-for="(element, index) in search_result_tweets" :key="element.id_str")

      .note.col.s6
        .note__title
          h3
            | Notes
          .search-form__title
            label
              | {{ noteTitleHumanAttributeName }}
            input(type="text" name="note[title]" id="note_title" :value="noteTitle")
        .note__body
          .note-body__inner
            button(type="button" @click="changeMarkdown()").waves-effect.waves-light.btn
              | Markdownに切り替え
            button(type="button" @click="changeTweets()").waves-effect.waves-light.btn
              | Previewに切り替え
          .note-body__inner
            .note__inner.is-preview.col.s6
              draggable(:list="note_tweets" group="people").cards
                tweet(:tweet="element" v-for="(element, index) in note_tweets" :key="element.id_str")
            .note__inner.is-markdown.col.s6
              .note__form
                tweets_markdown.note__textarea(
                  ref="tweets_markdown"
                  :tweets="note_tweets"
                  :parent_all_search_result_tweets="all_search_result_tweets"
                  title="List 1"
                )
      .hide
        input.note_tweets(type="hidden" name="note[tweets]" :value="JSON.stringify(note_tweets)")
        input.note_all_search_result_tweets(type="hidden" name="note[all_search_result_tweets]" :value="JSON.stringify(all_search_result_tweets)")

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
    if (document.querySelector('#js-note_all-search-result-tweets') !== null) {
      this.all_search_result_tweets = JSON.parse(document.querySelector('#js-note_all-search-result-tweets').innerText || null) || []
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
    },
    changeTweets () {
      this.$refs.tweets_markdown.changeTweets()
    }
  }
}
</script>
