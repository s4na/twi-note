<template lang="pug">
  .cards__body
    .cards__text.card(v-if="tweet['user'] == undefined")
      .card-content
        | {{ tweet["markdown"] }}
    .card(v-else class="twitter-tweet" data-lang="ja" data-dnt="true" data-theme="light").cards__text
      .card-content
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
