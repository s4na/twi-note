<template lang="pug">
  .div
    label
      | 本文
    //- h2
    //-   | {{ title }}
    textarea(name="note[body]" id="note_body")
      | {{ valueString }}
</template>
<script>
const props = {
  title: {
    required: true,
    type: String
  },
  value: {
    required: true
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
<style scoped>
pre {
  text-align: start;
}
</style>
<style scoped lang="scss">

textarea {
  // resize: vertical;
  resize: none;

  width: 100%;
  height: 2000px;
  // min-width: 100px;
  // min-height: 80px;
  // max-width:  400px;
  // max-height: 200px;

  // padding: 0.5em 1em;
  // margin: 2em 0;
  color: #5d627b;
  background: white;
  border-top: solid 5px #5d627b;
  box-shadow: 0 3px 5px rgba(0, 0, 0, 0.22);
}
</style>
