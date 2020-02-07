<template lang="pug">
  .search-form__inner
    .search-form__block
      .search-form-header
        h2.search-form-header__title
          | ツイート検索
      .search-form__body
        .search-form__items
          .search-form__item
            label.a-label
              | 検索キーワード
            input(ref="query" type="text" value="#Ruby").search-form__query.a-text-input
          .search-form__item
            label.a-label
              | 開始日時
            datetime(v-model="start_datetime" format="yyyy/LL/d HH:mm" zone="Asia/Tokyo" type="datetime" minute-step="10" input-id="start_datetime" name="tweets-search[start_datetime]").search-form__start-datetime.a-text-input
          .search-form__item
            label.a-label
              | 終了日時
            datetime(v-model="end_datetime" format="yyyy/LL/d HH:mm" zone="Asia/Tokyo" type="datetime" minute-step="10" input-id="end_datetime" name="tweets-search[end_datetime]").search-form__end-datetime.a-text-input
          .search-form__item
            .search-form__inner--center
              button(type="button" @click="searchTweets").search-form__button.a-button.is-secondary#search-form__button
                i.material-icons
                  | search
                | 検索
        .search-form__result
          label.a-label
            | 検索結果
          draggable(:list="search_result_tweets" group="people" @update="changeMarkdown()" @remove="changeMarkdown()")#note-tweets-preview.cards--search-form
            tweet(:tweet="element" v-for="(element, index) in search_result_tweets" :key="element.id_str")
    .search-form__small-block
      .search-form__tools
        .search-form__tool
          button(type="button" @click="change_all_result_tweets_to_note_tweets()" :class="{'is-disabled': isActive ==='markdown'}" :disabled="isActive ==='markdown'")#change_all_result_tweets_to_note_tweets.a-button
            | >>
        .search-form__tool
          button(type="button" @click="change_all_note_tweets_to_result_tweets()" :class="{'is-disabled': isActive ==='markdown'}" :disabled="isActive ==='markdown'")#change_all_note_tweets_to_result_tweets.a-button
            | <<
    .search-form__block
      .search-form-header
        h2.search-form-header__title
          | ノート
        .search-form-header__items
          .search-form-header__item
            button(type="button" @click="copyToClipboard()" :class="{'is-disabled': isActive ==='preview'}" :disabled="isActive ==='preview'").a-button
              i.material-icons
                | content_copy
              .search-form-header__inner-text
                | コピー
          .search-form-header__item
            button(type="submit").a-button.is-primary
              i.material-icons
                | save
              .search-form-header__inner-text
                | ノートを保存
      .note
        .note__title
          label.a-label
            | {{ noteTitleHumanAttributeName }}
          input(type="text" name="note[title]" id="note_title" :value="noteTitle").a-text-input
        .note__body
          .note-body__inner.tabs
            input(v-model="isActive" @click="changeTweets()" type="radio" id="tab-preview" name="tab" value="preview").a-tab-radio
            label(for="tab-preview" :class="{'is-current': isActive === 'preview'}" :disabled="isActive ==='preview'").a-tab#preview-mode
              | Preview
            input(v-model="isActive" @click="changeMarkdown()" type="radio" id="tab-markdown" name="tab" value="markdown").a-tab-radio
            label(for="tab-markdown" :class="{'is-current': isActive ==='markdown'}" :disabled="isActive ==='markdown'").a-tab#text-mode
              | Text
          ul.note-body__inner
            li(v-if="isActive === 'preview'")
              .note__inner.is-preview
                draggable(:list="note_tweets" group="people" @add="changeMarkdown()" @update="changeMarkdown()" @remove="changeMarkdown()").cards--note
                  tweet(:tweet="element" v-for="(element, index) in note_tweets" :key="element.id_str")
            li(v-if="isActive === 'markdown'")
              .note__inner.is-markdown
                .note-form
                  textarea(v-model="note_body" v-bind:rows="rows").note-form__textarea.a-text-input#note-form__textarea
    .hide
      input.note_tweets(type="hidden" name="note[tweets]" :value="JSON.stringify(note_tweets)")
      input.note_all_search_result_tweets(type="hidden" name="note[all_search_result_tweets]" :value="JSON.stringify(all_search_result_tweets)")
      input#note_body.note_body(type="hidden" name="note[body]" :value="note_body")
      input#note_edit_mode.note_edit_mode(type="hidden" name="note[edit_mode]" :value="isActive")

</template>
<script>
import Draggable from 'vuedraggable'
import moment from 'moment'
import Tweet from 'tweet'
import Markdown2Tweets from './markdown2tweets.js'
import { Datetime } from 'vue-datetime'
import { DateTime } from 'luxon';

export default {
  props: {
    noteTitleHumanAttributeName: String,
    noteTitle: String,
    noteEditMode: String,
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
      isActive: 'preview',
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

    this.start_datetime = DateTime.local().minus({ days: 7 }).toISO()
    this.end_datetime = DateTime.local().toISO()

    if (this.noteEditMode !== '' && this.noteEditMode !== null){
      this.isActive = this.noteEditMode
    }
  },
  methods: {
    change_all_result_tweets_to_note_tweets: function() {
      this.note_tweets = this.note_tweets.concat(this.search_result_tweets)
      this.search_result_tweets = []
      
      this.changeMarkdown()
    },
    change_all_note_tweets_to_result_tweets: function() {
      this.search_result_tweets = this.search_result_tweets.concat(this.note_tweets)
      this.note_tweets = []

      this.changeMarkdown()
    },
    changeMarkdown () {
      let m2t = new Markdown2Tweets({'tweets': this.note_tweets})
      const markdown = m2t.setMarkdown()
      this.note_body = markdown
    },
    changeTweets () {
      const markdown = this.note_body
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
        const min = 10
        const margin = 3
        const size = this.note_body.split("\n").length + margin;

        return (size > min) ? size : min;
    }
  }
}
</script>
