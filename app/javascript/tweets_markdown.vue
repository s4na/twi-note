<template lang="pug">
  .tweets_markdown
    .input-field.col.s12
      textarea(
        ref="textArea"
        v-model="body"
        name="note[body]"
        id="note_body"
        v-bind:rows="rows"
      ).materialize-textarea
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
    },
    rows:function() {
        let size = this.body.split("\n").length;
        let min = 40
        return (size > min) ? size : min;
    }
  },
  created() {
    let indexs = JSON.parse(this.tweetsString)
    for(let index of indexs){
      this.body = this.body + index["markdown"]
    }
  },
  methods: {
    changeTweets() {
      const markdown = this.$refs.textArea.value
      const tweets = this.parent_all_search_result_tweets
      let m2t = new Markdown2Tweets({ 'markdown': markdown, 'tweets': tweets })

      const lists = m2t.setTweets()
      this.$parent.note_tweets = lists
    }
  }
}
</script>
