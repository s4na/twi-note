<template lang="pug">
  .card
    template(v-if="tweet['user'] == undefined")
      p
        | {{ tweet["markdown"] }}
    template(v-else class="twitter-tweet" data-lang="ja" data-dnt="true" data-theme="light")
      p(lang="ja" dir="ltr")
        | {{ tweet["text"] }}
        br
        //- img(:src="image_src").card__twitter-logo
        img(:src="image_src").card__twitter-logo
        | &mdash; {{ tweet["user"]["name"] }} (@{{ tweet["user"]["screen_name"] }})
</template>
<script>
import image_src from "../assets/images/welcome/Twitter_Logo_Blue.png"

export default {
  props: {
    tweet: Object
  },
  data () {
    return {
      image_src: image_src
    }
  }
}
</script>
