<template lang="pug">
  .tweets_markdown
    button(type="button" @click="changeTweets()")
      | Previewに切り替え
    label
      | 本文
    textarea(ref="textArea" v-model="body" name="note[body]" id="note_body")
</template>
<script>
import Markdown2Tweets from './markdown2tweets.js'

export default {
  props: {
    title: {
      type: String,
      required: true,
      default: ""
    },
    tweets: {
      required: true,
      default: []
    },
    parent_all_search_result_tweets: {
      type: Array
    }
  },
  data: function () {
    return {
      body: ""
    }
  },
  computed: {
    tweetsString() {
      return JSON.stringify(this.tweets, null, 2)
    }
  },
  created() {
    var indexs = JSON.parse(this.tweetsString)
    for(var index of indexs){
      this.body = this.body + index["markdown"]
    }
  },
  methods: {
    changeTweets() {
      const text = this.$refs.textArea.value
      const tweets = this.parent_all_search_result_tweets
      var m2t = new Markdown2Tweets(text, tweets)

      const lists = m2t.lists()
      this.$parent.note_tweets = lists
    }
  }
}
</script>
<style scoped lang="scss">
textarea {
  resize: none;

  width: 100%;
  height: 2000px;
}
</style>
