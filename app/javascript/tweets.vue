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
              | 検索キーワード（勉強会ハッシュタグなど）
            input(
              type="text"
              v-model="query"
              id="note_search_setting_attributes_query"
              name="note[search_setting_attributes][query]"
              placeholder="例：#sendagayarb"
            ).search-form__query.a-text-input
          .search-form__item
            label.a-label
              | 開始日時
            datetime_picker(
              v-model="start_datetime"
              format="yyyy/LL/d HH:mm" zone="Asia/Tokyo" type="datetime" :minute-step="MINUTE_STEP"
              input-id="note_search_setting_attributes_start_datetime" name="note[search_setting_attributes][start_datetime]"
            ).search-form__start-datetime.a-text-input
          .search-form__item
            label.a-label
              | 終了日時
            datetime_picker(
              v-model="end_datetime"
              format="yyyy/LL/d HH:mm" zone="Asia/Tokyo" type="datetime" :minute-step="MINUTE_STEP"
              input-id="note_search_setting_attributes_end_datetime" name="note[search_setting_attributes][end_datetime]"
            ).search-form__end-datetime.a-text-input
          .search-form__item
            .search-form__inner--center
              button(type="button" @click="searchTweets").search-form__button.a-button.is-secondary#search-form__button
                i.material-icons
                  | search
                | 検索
        .search-form__result
          label.a-label(v-if="this.isExistSearchResult === 1 && this.isSearched === 1")
            | 検索結果
          .search-form__no-search-result(v-if="this.isExistSearchResult === 0 && this.isSearched === 1")
            | 検索結果がありません
          .search-form__no-search-query(v-if="this.isExistSearchQuery === 0")
            | 「検索キーワード」が入力されていません
          draggable(:list="search_result_tweets" group="people" @update="changeMarkdown()" @remove="changeMarkdown()")#note-tweets-preview.cards--search-form
            tweet(:tweet="element" v-for="(element, index) in search_result_tweets" :key="element.id_str")
    .search-form__block
      .search-form-header
        h2.search-form-header__title
          | ノート
      .note
        .note__title
          label.a-label
            | {{ noteTitleHumanAttributeName }}
          input(type="text" name="note[title]" id="note_title" v-model="noteTitle").a-text-input
        .note__body
          .note-body__block.tabs
            input(v-model="isActive" @click="changeTweets()" type="radio" id="tab-preview" name="tab" value="preview").a-tab-radio
            label(for="tab-preview" :class="{'is-current': isActive === 'preview'}" :disabled="isActive ==='preview'").a-tab#preview-mode
              | Preview
            input(v-model="isActive" @click="changeMarkdown()" type="radio" id="tab-markdown" name="tab" value="markdown").a-tab-radio
            label(for="tab-markdown" :class="{'is-current': isActive ==='markdown'}" :disabled="isActive ==='markdown'").a-tab#text-mode
              | Markdown
          ul.note-body__block
            li(v-if="isActive === 'preview'")
              .note__inner.is-preview
                draggable(:list="note_tweets" group="people" @add="changeMarkdown()" @update="changeMarkdown()" @remove="changeMarkdown()").cards--note
                  tweet(:tweet="element" v-for="(element, index) in note_tweets" :key="element.id_str")
            li(v-if="isActive === 'markdown'")
              .note__inner.is-markdown
                .note-form
                  textarea(v-model="note_body" v-bind:rows="rows").note-form__textarea.a-text-input#note-form__textarea
    .search-form-footer
      .search-form-footer__items
        .search-form-footer__item
          button(type="button" @click="change_all_result_tweets_to_note_tweets()" :class="{'is-disabled': isActive ==='markdown'}" :disabled="isActive ==='markdown'")#change_all_result_tweets_to_note_tweets.a-button
            | 全てのツイートを貼る
        .search-form-footer__item
          button(type="submit").a-button.is-primary
            i.material-icons
              | cloud_upload
            | 保存
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
import { DateTime } from 'luxon'

export default {
  props: {
    noteTitleHumanAttributeName: String,
    noteTitle: String,
    noteEditMode: String,
    noteSearchSettingQuery: String,
    noteSearchSettingStartDatetime: String,
    noteSearchSettingEndDatetime: String,
    datetimeCurrent: String
  },
  components: {
    draggable: Draggable,
    tweet: Tweet,
    datetime_picker: Datetime
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
      isExistSearchResult: 1,
      isExistSearchQuery: 1,
      isSearched: 0,
      query: String
    }
  },
  created () {
    this.note_tweets = this.get_inner_json('#js-note-tweets')
    this.all_search_result_tweets = this.get_inner_json(
      '#js-note_all-search-result-tweets'
    )

    if (document.querySelector('#js-note-body') !== null) {
      this.note_body = document.querySelector('#js-note-body').innerText || null
    }

    let today = DateTime.fromISO(this.datetimeCurrent)

    if (this.noteSearchSettingStartDatetime == '') {
      this.start_datetime = today
        .minus({ hour: 1 })
        .minus({ minute: today.minute % this.MINUTE_STEP })
        .toISO()
    } else {
      this.start_datetime = this.string_to_datetime(
        this.noteSearchSettingStartDatetime
      )
    }

    if (this.noteSearchSettingEndDatetime == '') {
      this.end_datetime = today
        .minus({ minute: today.minute % this.MINUTE_STEP })
        .toISO()
    } else {
      this.end_datetime = this.string_to_datetime(
        this.noteSearchSettingEndDatetime
      )
    }

    if (this.noteEditMode !== '' && this.noteEditMode !== null) {
      this.isActive = this.noteEditMode
    }

    this.query = this.noteSearchSettingQuery
  },
  methods: {
    get_inner_json: function (str) {
      // if innerText is null then []

      if (
        document.querySelector(str) !== null &&
        document.querySelector(str).innerText
      ) {
        let innerText = document.querySelector(str).innerText
        if (innerText !== null) {
          return JSON.parse(innerText) || []
        } else {
          return []
        }
      } else {
        return []
      }
    },
    string_to_datetime: function (str) {
      return DateTime.local.apply(this, str.split(/[/ :]/).map(Number)).toISO()
    },
    change_all_result_tweets_to_note_tweets: function () {
      this.note_tweets = this.note_tweets.concat(this.search_result_tweets)
      this.search_result_tweets = []

      this.changeMarkdown()
    },
    change_all_note_tweets_to_result_tweets: function () {
      this.search_result_tweets = this.search_result_tweets.concat(
        this.note_tweets
      )
      this.note_tweets = []

      this.changeMarkdown()
    },
    changeMarkdown () {
      let m2t = new Markdown2Tweets({ tweets: this.note_tweets })
      const markdown = m2t.setMarkdown()
      this.note_body = markdown
    },
    changeTweets () {
      const markdown = this.note_body
      const tweets = this.all_search_result_tweets
      let m2t = new Markdown2Tweets({ markdown: markdown, tweets: tweets })
      this.note_tweets = m2t.setTweets()
    },
    copyToClipboard () {
      let copyTarget = document.getElementById('note_body')
      copyTarget.select()
      document.execCommand('Copy')
      alert('クリップボードにコピーしました')
    },
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    searchTweets: function () {
      if (this.query != '') {
        this.isExistSearchQuery = 1

        this.search_result_tweets = []
        const query = encodeURIComponent(this.query)
        const start_datetime = encodeURIComponent(
          moment(this.start_datetime).format('YYYY-MM-DD HH:mm')
        )
        const end_datetime = encodeURIComponent(
          moment(this.end_datetime).format('YYYY-MM-DD HH:mm')
        )

        fetch(
          `/api/tweets.json?query=${query}&start_datetime=${start_datetime}&end_datetime=${end_datetime}`,
          {
            method: 'GET',
            headers: {
              'Content-Type': 'application/json; charset=utf-8',
              'X-Requested-With': 'XMLHttpRequest',
              'X-CSRF-Token': this.token()
            },
            credentials: 'same-origin',
            redirect: 'manual'
          }
        )
          .then(response => {
            return response.json()
          })
          .then(json => {
            json.forEach(c => {
              this.search_result_tweets.push(c)
            })
            this._check_add_tweets(json)

            if (json == '') {
              this.isExistSearchResult = 0
            } else {
              this.isExistSearchResult = 1
            }
            this.isSearched = 1
          })
          .catch(error => {
            console.warn('Failed to parsing', error)
          })
      } else {
        this.isExistSearchQuery = 0
      }
    },
    _check_add_tweets (tweets) {
      let addTweets = []
      tweets.forEach(c => {
        let isMatch = 0
        for (let i = 0; i < this.all_search_result_tweets.length; i++) {
          if (
            this.all_search_result_tweets[i].id_str === c.id_str &&
            this.all_search_result_tweets[i].user.id_str === c.user.id_str
          ) {
            isMatch = 1
          }
        }
        if (isMatch === 0) {
          addTweets.push(c)
        }
      })
      addTweets.forEach(c => {
        this.all_search_result_tweets.push(c)
      })
    }
  },
  computed: {
    MINUTE_STEP: () => 10,
    tweetsString () {
      return JSON.stringify(this.note_tweets, null, 2)
    },
    rows: function () {
      const MIN = 10
      const MARGIN = 3
      if (this.note_body === '' || this.note_body === null) {
        return MIN
      }
      const size = this.note_body.split('\n').length + MARGIN
      return size > MIN ? size : MIN
    }
  }
}
</script>
