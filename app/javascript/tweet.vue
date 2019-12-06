<template lang="pug">
  .tweet
    | debug id_str[{{ tweet['id_str'] }}]
    .tweet(v-if="tweet['user'] == undefined")
      | {{ tweet["text"] }}
    blockquote(v-else class="twitter-tweet" data-lang="ja" data-dnt="true" data-theme="light")
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
