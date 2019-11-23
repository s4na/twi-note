<template lang="pug">
  .tweet
    blockquote(class="twitter-tweet" data-lang="ja" data-dnt="true" data-theme="light")
      p(lang="ja" dir="ltr")
        | {{ tweet["text"] }}
      | &mdash; {{ tweet["user"]["name"] }} (@{{ tweet["user"]["screen_name"] }})
      a(:href="tweet_url()")
</template>
<script>
export default {
  props: {
    tweet: Object,
  },
  components: {
  },
  created() {
    let ckeditor = document.createElement('script');
    ckeditor.setAttribute('src',"//platform.twitter.com/widgets.js");
    document.head.appendChild(ckeditor);
  },
  data: function () {
    return {
    }
  },
  methods: {
    tweet_url () {
      return `https://twitter.com/${this.tweet["user"]["screen_name"]}/status/${this.tweet["id_str"]}?ref_src=twsrc%5Etfw`;
    }
  }
}
</script>
