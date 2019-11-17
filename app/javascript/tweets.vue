<template lang="pug">
  .tweets
    label
      | query
    input(ref="query" type="text" value="s4na_penguin")
    label
      | tart_datetime
    input(ref="start_datetime" type="text" value="2019-11-15 23:59")
    label
      | end_datetime
    input(ref="end_datetime" type="text" value="2019-11-16 23:59")
    .search
      button(@click="searchTweets")
        | 検索
    .results
      | {{ this.tweets }}
</template>
<script>
export default {
  props: {},
  components: {
  },
  data: function () {
    return {
      tweets: []
    }
  },
  methods: {
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    searchTweets: function() {
      this.tweets = [];
      const query = encodeURI(this.$refs.query.value);
      const start_datetime = encodeURI(this.$refs.start_datetime.value);
      const end_datetime = encodeURI(this.$refs.end_datetime.value);

      fetch(`/api/tweets.json?start_datetime=${start_datetime}&end_datetime=${end_datetime}&query=${query}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin',
        redirect: 'manual',
      })
        .then(response => { return response.json(); })
        .then(json=> {
          json.forEach(c => { this.tweets.push(c); });
        })
        .catch(error => { console.warn('Failed to parsing', error); })
    }
  }
}
</script>
