<template lang="pug">
  .tweet
    //- | {{ tweet }}
    blockquote(class="twitter-tweet" data-lang="ja" data-dnt="true" data-theme="light")
      p(lang="ja" dir="ltr")
        | {{ tweet["text"] }}
        //- a(:href="hashtag_url")
          //- | #fjordbootcamp
      | &mdash; {{ tweet["user"]["name"] }} (@{{ tweet["user"]["screen_name"] }})
      a(:href="tweet_url()")
        //- | 2019年11月21日
        //- 日付をtweetから取得するようにする

    //- blockquote(class="twitter-tweet" data-lang="ja" data-dnt="true" data-theme="light")
    //-   p(lang="ja" dir="ltr")
    //-     | 昨日来ていただいた<br><br>・サイバーセキュリティクラウドさん<br>・アクトインディさん<br>・ラグザイアさん<br><br>良い会社でした〜<br>
    //-     //- a(href="https://twitter.com/hashtag/fjordbootcamp?src=hash&amp;ref_src=twsrc%5Etfw")
    //-       //- | #fjordbootcamp
    //-   | &mdash; s4na / Nabetani 🐧そうだ！Rubyを書こう！ (@s4na_penguin)
    //-   a(href="https://twitter.com/s4na_penguin/status/1197343638591721472?ref_src=twsrc%5Etfw")
    //-     | 2019年11月21日
    //- script(async src="https://platform.twitter.com/widgets.js" charset="utf-8")
</template>
<script>
export default {
  props: {
    tweet: Object,
  },
  components: {
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
<style scoped lang="scss">

</style>
