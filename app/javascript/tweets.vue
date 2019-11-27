<template lang="pug">
  .tweets
    | {{ this.result_tweets }}

    | 検索欄
    .search
      label
        | query
      input(ref="query" type="text" value="s4na_penguin")
      label
        | start_datetime
      input(ref="start_datetime" type="text" name="tweets-search[start_datetime]" value="2019-11-20 23:59")
      label
        | end_datetime
      input(ref="end_datetime" type="text" name="tweets-search[end_datetime]" value="2019-11-25 23:59")
      .search
        button(type="button" @click="searchTweets")
          | 検索

    .form__items
      .form__item
        .search-tweets
          p
            | Tweets
          draggable(class="list-group" :list="result_tweets" group="people")
            .list-group-item(v-for="(element, index) in result_tweets" :key="element.name")
              tweet(:tweet="element")
      .form__item
        .note-tweets
          p
            | Notes
          draggable(class="list-group" :list="note_tweets" group="people")
            .list-group-item(v-for="(element, index) in note_tweets" :key="element.name")
              tweet(:tweet="element")
      .form__item
        .tweets_markdown
          tweets_markdown(:value="note_tweets" title="List 1")

</template>
<script>
import Draggable from 'vuedraggable'
import Tweet from 'tweet'
import TweetsMarkdown from 'tweets_markdown'

export default {
  props: {},
  components: {
    'draggable': Draggable,
    'tweet': Tweet,
    'tweets_markdown': TweetsMarkdown,
  },
  data: function () {
    return {
      result_tweets: [],
      note_tweets: []
    }
  },
  created() {
    this.note_tweets = JSON.parse(document.querySelector('#js-tweets-body').innerText);
  },
  methods: {
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    searchTweets: function() {
      this.result_tweets = [];
      const query = encodeURI(this.$refs.query.value);
      const start_datetime = encodeURI(this.$refs.start_datetime.value);
      const end_datetime = encodeURI(this.$refs.end_datetime.value);

      fetch(`/api/tweets.json?start_datetime=${start_datetime}&end_datetime=${end_datetime}&query=${query}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin',
        redirect: 'manual',
      })
        .then(response => { return response.json(); })
        .then(json=> {
          json.forEach(c => { this.result_tweets.push(c); });
        })
        .catch(error => { console.warn('Failed to parsing', error); })
  }
}
</script>
<style scoped lang="scss">
.form__items {
  display: flex;
  flex-direction: row;
}
.form__item {
  width: 33%;
}
</style>
