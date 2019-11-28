<template lang="pug">
  .tweets_markdown
    label
      | 本文
    textarea(name="note[body]" id="note_body")
      | {{ valueString }}
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
