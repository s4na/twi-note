<template lang="pug">
  .tweets_markdown
    button(type="button" @click="changeNotes()")
      | Notesに切り替え
    label
      | 本文
    textarea(ref="textArea" v-model="body" name="note[body]" id="note_body")
</template>
<script>
import uuid from 'uuid'

export default {
  props: {
    title: {
      type: String,
      required: true,
      default: ""
    },
    tweets: {
      required: true,
      default: []
    },
    parent_all_search_result_tweets: {
      type: Array
    }
  },
  data: function () {
    return {
      body: ""
    }
  },
  computed: {
    tweetsString() {
      return JSON.stringify(this.tweets, null, 2);
    }
  },
  created() {
    var indexs = JSON.parse(this.tweetsString)
    for(var index of indexs){
      this.body = this.body + index["markdown"];
    }
  },
  methods: {
    changeNotes() {
      this.$parent.note_tweets = this._markdown2tweet(this.$refs.textArea.value);
    },
    _markdown2tweet(text) {
      var order = [];
      const tweets = this.parent_all_search_result_tweets;

      for(const tweet of tweets) {
        var tweet_address = text.indexOf(tweet["markdown"]);
        if (tweet_address >= 0) {
          order.push({
            "address": tweet_address,
            "length": tweet["markdown"].length,
            "end_point": (tweet_address + tweet["markdown"].length),
            "data": tweet
          })
        }
      }      
      order = this._asc_sort(order);
      
      for (var tweet_id = 0; tweet_id < order.length; tweet_id++) {
        if (tweet_id !== 0) {
          if ( order[tweet_id - 1]["end_point"] < order[tweet_id]["address"] ) {
            const fragment_text_length = order[tweet_id]["address"] - order[tweet_id - 1]["end_point"];
            const fragment_text = text.substr(order[tweet_id - 1]["end_point"], fragment_text_length);
            const address = order[tweet_id - 1]["end_point"];

            order.push({
              "address": address,
              "data": { "id_str": uuid(), "text": fragment_text }
            });
          }
        }
      }
      order = this._add_first_and_last_fragment_text(order, text);
      
      order = this._asc_sort(order);
      
      var lists = [];
      for (var tweet_id = 0; tweet_id < order.length; tweet_id++) {
        lists.push(order[tweet_id]["data"]);
      }
      return lists || [];
    },
    _asc_sort(array_hash) {
      // ascending order
      return array_hash.sort(function(a,b){
        return (a["address"] < b["address"] ? -1 : 1);
      });
    },
    _add_first_and_last_fragment_text(order, text) {
      order = this._add_first_fragment_text(order, text);
      order = this._add_last_fragment_text(order, text);
      return order
    },
    _add_first_fragment_text(order, text) {
      const order_first_address = Math.min.apply(null, order.map(function(o){ return o.address; }));
      const first_order = order.filter(o => o.address === order_first_address)[0];

      if (order_first_address !== 0) {
        const fragment_text_length = first_order.address;
        const fragment_text = text.substr(0, fragment_text_length);

        order.push({
          "address": 0,
          "data": { "id_str": uuid(), "text": fragment_text }
        });
      }
      return order
    },
    _add_last_fragment_text(order, text) {
      const order_last_address = Math.max.apply(null, order.map(function(o){ return o.address; }));
      const last_order = order.filter(o => o.address === order_last_address)[0];

      const text_length = text.length;

      if ( order_last_address !== text_length) {
        const fragment_text_length = text_length - last_order.end_point;
        const fragment_text = text.substr(last_order.end_point, fragment_text_length);
        const address = last_order.end_point;

        order.push({
          "address": address,
          "data": { "id_str": uuid(), "text": fragment_text }
        });
      }
      return order
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
