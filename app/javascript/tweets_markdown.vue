<template lang="pug">
  .tweets_markdown
    label
      | 本文
    textarea(name="note[body]" id="note_body")
      | {{ to_markdown(valueString) }}
</template>
<script>
const props = {
  title: {
    type: String,
    required: true,
    default: ""
  },
  value: {
    required: true,
    default: ""
  }
};
export default {
  props,
  computed: {
    valueString() {
      return JSON.stringify(this.value, null, 2);
    }
  },
  methods: {
    to_markdown (tweets) {
      var result = "";
      tweets = JSON.parse(tweets);
      for(var tweet of tweets){
        result = result + `> [${tweet["text"]}](https://twitter.com/${tweet["user"]["screen_name"]}/status/${tweet["id_str"]}?ref_src=twsrc%5Etfw)`.replace(/\r?\n/g, ' ') + "\n\n";
      }
      return result;
    },
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
