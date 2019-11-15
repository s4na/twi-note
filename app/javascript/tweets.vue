<template lang="pug">
  .app
    p
      | {{ this.tweets }}
    button(@click="searchTweets")
      | 検索
    
</template>
<script>
export default {
  data: function () {
    return {
      tweets: [],
      message: "Hello tweets!"
    }
  },
  methods: {
    token () {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    searchTweets: function() {
      const query = 's4na_penguin';
      const start_datetime = '2019-11-01%2023:59';
      const end_datetime = '2019-11-11%2023:59';
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
