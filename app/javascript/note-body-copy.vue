<template lang="pug">
  .note-show__item.note-body-copy
    button(type="button" @click="copyNoteBodyToClipboard()").a-button
      i.material-icons
        | content_copy
      | コピー
</template>
<script>
export default {
  methods: {
    copyNoteBodyToClipboard () {
      const element = document.querySelector('#note-show__text')
      const range = document.createRange()
      range.selectNodeContents(element)

      const selection = window.getSelection()
      selection.removeAllRanges()
      selection.addRange(range)
      document.execCommand('copy')
      alert('クリップボードにコピーしました')
      selection.removeAllRanges()
    }
  }
}
</script>
