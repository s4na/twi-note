<template lang="pug">
  .tweet
    blockquote(class="twitter-tweet" data-lang="ja" data-dnt="true" data-theme="light")
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
