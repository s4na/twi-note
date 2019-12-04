<template lang="pug">
  .tweets
    | 検索欄
    .search-form
      label
        | query
      input(ref="query" type="text" value="s4na_penguin")
      label
        | start_datetime
      input(ref="start_datetime" type="text" name="tweets-search[start_datetime]" value="2019-12-01 23:59")
      label
        | end_datetime
      input(ref="end_datetime" type="text" name="tweets-search[end_datetime]" value="2019-12-25 23:59")
      .search-form__button
        button(type="button" @click="searchTweets")
          | 検索

    .form__items
      .form__item
        .search-tweets
          label
            | Tweets
          draggable(class="list-group" :list="search_result_tweets" group="people")
            .list-group-item(v-for="(element, index) in search_result_tweets" :key="element.name")
              tweet(:tweet="element")
      .form__item
        .note-tweets
          label
            | Notes
          button(type="button" @click="changTweets()")
            | Tweetsに切り替え
          draggable(class="list-group" :list="note_tweets" group="people")
            .list-group-item(v-for="(element, index) in note_tweets" :key="element.name")
              tweet(:tweet="element")
          input.note_tweets(type="hidden" name="note[tweets]" :value="JSON.stringify(note_tweets)")
      .form__item
        .tweets_markdown
          tweets_markdown(ref="tweets_markdown"
            :tweets="note_tweets"
            :parent_all_search_result_tweets="all_search_result_tweets"
            title="List 1"
          )

</template>
<script>
import Draggable from 'vuedraggable'
import Tweet from 'tweet'
import TweetsMarkdown from 'tweets_markdown'

export default {
  props: {
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
      this.note_tweets = JSON.parse(document.querySelector('#js-note-tweets').innerText || null) || [];
    }
    if (document.querySelector('#js-note-body') !== null) {
      this.note_body = document.querySelector('#js-note-body').innerText || null;
    }
  },
  methods: {
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    searchTweets: function() {
      this.search_result_tweets = [];
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
          json.forEach(c => {
            this.search_result_tweets.push(c);
            this.all_search_result_tweets.push(c);
          });
        })
        .catch(error => { console.warn('Failed to parsing', error); })
    },
    changTweets () {
      var body = "";
      var indexs = JSON.parse(JSON.stringify(this.note_tweets, null, 2));
      for(var index of indexs){
        body = body + index["markdown"];
      }
      this.$refs.tweets_markdown.body = body;
    }
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
