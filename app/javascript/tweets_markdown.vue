<template lang="pug">
  .tweets_markdown
    button(type="button" @click="changeNotes()")
      | Notesに切り替え
    label
      | 本文
    textarea(ref="textArea" v-model="body" name="note[body]" id="note_body")
</template>
<script>
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
      return JSON.stringify(this.tweets, null, 2);
    }
  },
  created() {
    var indexs = JSON.parse(this.tweetsString)
    for(var index of indexs){
      body = body + index["markdown"];
    }
  },
  methods: {
    changeNotes() {
      this.$parent.note_tweets = this._markdown2tweet(this.$refs.textArea.value);
    },
    _markdown2tweet(text) {
      var lists = [];
      const tweets = this.parent_all_search_result_tweets;
      for(const tweet of tweets) {
        if (text.indexOf(tweet["markdown"]) >= 0) {
          lists.push(tweet);
        }
      }
      return lists || [];
    }
  }
};
</script>
<style scoped lang="scss">
textarea {
  resize: none;

  width: 100%;
  height: 2000px;
}
</style>
