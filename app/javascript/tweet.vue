<template lang="pug">
  .card
    template(v-if="tweet['user'] == undefined")
      p
        | {{ tweet["markdown"] }}
    template(v-else class="twitter-tweet" data-lang="ja" data-dnt="true" data-theme="light")
      p(lang="ja" dir="ltr")
        | {{ tweet["text"] }}
        br
        | &mdash; {{ tweet["user"]["name"] }} (@{{ tweet["user"]["screen_name"] }})
</template>
<script>
export default {
  props: {
    tweet: Object,
  },
}
</script>
