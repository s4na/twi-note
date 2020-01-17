<template lang="pug">
  .search-form__inner
    .row
      .col.s8
        .search-form__title
          h3
            | ツイート検索
        .search-form__body.col.s12
          .search-form__items.col.s6
            .search-form__item
              label.search-form__query
                | 検索キーワード（例：#Ruby）
              input(ref="query" type="text" value="#Ruby")
            .search-form__item
              label.search-form__start-datetime
                | 開始日時
              datetime(
                v-model="start_datetime"
                type="datetime"
                input-id="start_datetime"
                format="yyyy/LL/d hh:mm"
                name="tweets-search[start_datetime]"
              )
            .search-form__item
              label.search-form__end-datetime
                | 終了日時
              datetime(
                v-model="end_datetime"
                type="datetime"
                input-id="end_datetime"
                format="yyyy/LL/d hh:mm"
                name="tweets-search[end_datetime]"
              )
            .search-form__item
              .search-form__button
                button(type="button" @click="searchTweets").a-search-button.waves-effect.waves-light.btn.blue.lighten-2
                  | 検索
          .search-result.col.s6
            label
              | 検索結果
            draggable(:list="search_result_tweets" group="people")#note-tweets-preview.cards
              tweet(:tweet="element" v-for="(element, index) in search_result_tweets" :key="element.id_str")
      .note.col.s4
        .note__title
          h3
            | Notes
          .search-form__title
            label
              | {{ noteTitleHumanAttributeName }}
            input(type="text" name="note[title]" id="note_title" :value="noteTitle")
        .note__body
          button(type="button" @click="copyToClipboard()").waves-effect.waves-light.btn.grey
            | コピー
          .note-body__inner
            input(
              type="radio" id="tab1" name="tab" value="1" v-model="isActive"
              @click="changeTweets()"
            )
            label(
              for="tab1"
              :class="{'blue lighten-2': isActive === '1'}"
              :disabled="isActive ==='1'"
            ).waves-effect.waves-light.btn.grey
              | Markdown
            input(
              type="radio" id="tab2" name="tab" value="2" v-model="isActive"
              @click="changeMarkdown()"
            )
            label(
              for="tab2"
              :class="{'blue lighten-2': isActive ==='2'}"
              :disabled="isActive ==='2'"
            ).waves-effect.waves-light.btn.grey
              | Preview
          ul.note-body__inner
            li(v-if="isActive === '1'")
              .note__inner.is-preview.col.s12
                draggable(:list="note_tweets" group="people").cards
                  tweet(:tweet="element" v-for="(element, index) in note_tweets" :key="element.id_str")
            li(v-if="isActive === '2'")
              .note__inner.is-markdown.col.s12
                .note__form
                  .tweets_markdown
                    .input-field.col.s12
                      textarea(
                        ref="textArea"
                        v-model="markdownBody"
                        name="note[body]"
                        id="note_body"
                        v-bind:rows="rows"
                      ).materialize-textarea
      .hide
        input.note_tweets(type="hidden" name="note[tweets]" :value="JSON.stringify(note_tweets)")
        input.note_all_search_result_tweets(type="hidden" name="note[all_search_result_tweets]" :value="JSON.stringify(all_search_result_tweets)")

</template>
<script>
import Draggable from 'vuedraggable'
import moment from 'moment'
import Tweet from 'tweet'
import Markdown2Tweets from './markdown2tweets.js'
import { Datetime } from 'vue-datetime'

export default {
  props: {
    noteTitleHumanAttributeName: String,
    noteTitle: String,
  },
  components: {
    'draggable': Draggable,
    'tweet': Tweet,
    'datetime': Datetime,
  },
  data: function () {
    return {
      all_search_result_tweets: [],
      search_result_tweets: [],
      note_tweets: [],
      note_body: String,
      start_datetime: '',
      end_datetime: '',
      isActive: '1',
      markdownBody: '',
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

    const today = new Date()
    const oneWeekBefore = moment(today).add(-7, "days").toDate()
    this.start_datetime = oneWeekBefore.toISOString()
    this.end_datetime = today.toISOString()
  },
  methods: {
    changeMarkdown () {
      let m2t = new Markdown2Tweets({'tweets': this.note_tweets})
      const markdown = m2t.setMarkdown()
      this.markdownBody = markdown
    },
    changeTweets () {
      const markdown = this.markdownBody
      const tweets = this.all_search_result_tweets
      let m2t = new Markdown2Tweets({ 'markdown': markdown, 'tweets': tweets })

      this.note_tweets = m2t.setTweets()
    },
    copyToClipboard() {
      let copyTarget = document.getElementById("note_body");
      copyTarget.select();
      document.execCommand("Copy");
      alert("クリップボードにコピーしました");
    },
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    searchTweets: function() {
      this.search_result_tweets = []
      const query = encodeURIComponent(this.$refs.query.value)
      const start_datetime = encodeURIComponent(moment(this.start_datetime).format('YYYY-MM-DD HH:mm'));
      const end_datetime = encodeURIComponent(moment(this.end_datetime).format('YYYY-MM-DD HH:mm'));

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
          json.forEach(c => { this.search_result_tweets.push(c) })
          this._check_add_tweets(json)
        })
        .catch(error => { console.warn('Failed to parsing', error) })
    },
    _check_add_tweets (tweets) {
      let addTweets = []
      tweets.forEach(c => {
        let isMatch = 0
        for(let i = 0; i < this.all_search_result_tweets.length ; i++){
          if (this.all_search_result_tweets[i].id_str === c.id_str && this.all_search_result_tweets[i].user.id_str === c.user.id_str){ isMatch = 1 }
        }
        if ( isMatch === 0){ addTweets.push(c) }
      })
      addTweets.forEach(c => { this.all_search_result_tweets.push(c) })
    }
  },
  computed: {
    tweetsString() {
      return JSON.stringify(this.note_tweets, null, 2)
    },
    rows:function() {
        let size = this.markdownBody.split("\n").length;
        let min = 40
        return (size > min) ? size : min;
    }
  }
}
</script>
