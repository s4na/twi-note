import uuid from 'uuid'

export default class Markdown2Tweet {
  constructor (text, tweets) {
    var orders = []
    for (const tweet of tweets) {
      var address = text.indexOf(tweet['markdown'])
      // indexOfは0originだけど、1origin だと思って書いていたので、バグがあるかも

      if (address >= 0) {
        orders.push({
          'address': address,
          'length': tweet['markdown'].length,
          'end_point': (address + tweet['markdown'].length),
          'data': tweet
        })
      }
    }

    this.orders = orders
  }
  setTweet (text) {
    this.orders = this.ascSort(this.orders)
    this.orders = this.changeFragment(this.orders, text)
    this.orders = this.addFirstAndLastFragmentText(this.orders, text)
    this.orders = this.ascSort(this.orders)
  }
  lists (text) {
    this.setTweet(text)

    this.lists = []
    for (var id = 0; id < this.orders.length; id++) {
      this.lists.push(this.orders[id]['data'])
    }
    return this.lists || []
  }
  ascSort (arrayHash) {
    // ascending orders
    return arrayHash.sort(function (a, b) { return (a['address'] < b['address'] ? -1 : 1) })
  }
  changeFragment (orders, text) {
    for (var id = 0; id < orders.length; id++) {
      if (id !== 0) {
        if (orders[id - 1]['end_point'] < orders[id]['address']) {
          const fragmentTextLength = orders[id]['address'] - orders[id - 1]['end_point']
          const fragmentText = text.substr(orders[id - 1]['end_point'], fragmentTextLength)
          const address = orders[id - 1]['end_point']

          orders.push({
            'address': address,
            'data': { 'id_str': uuid(), 'text': fragmentText }
          })
        }
      }
    }
    return orders
  }
  addFirstAndLastFragmentText (orders, text) {
    orders = this.addFirstFragmentTextText(orders, text)
    orders = this.addLastFragmentText(orders, text)
    return orders
  }
  addFirstFragmentTextText (orders, text) {
    const ordersFirstAddress = Math.min.apply(null, orders.map(function (o) { return o.address }))
    const firstOrder = orders.filter(o => o.address === ordersFirstAddress)[0]

    if (ordersFirstAddress !== 0) {
      const fragmentTextLength = firstOrder.address
      const fragmentText = text.substr(0, fragmentTextLength)

      orders.push({
        'address': 0,
        'data': { 'id_str': uuid(), 'text': fragmentText }
      })
    }
    return orders
  }
  addLastFragmentText (orders, text) {
    const ordersLastAddress = Math.max.apply(null, orders.map(function (o) { return o.address }))
    const lastOrder = orders.filter(o => o.address === ordersLastAddress)[0] + 1
    const textLength = text.length

    if (ordersLastAddress !== textLength) {
      const fragmentTextLength = textLength - lastOrder.end_point
      const fragmentText = text.substr(lastOrder.end_point, fragmentTextLength)
      const address = lastOrder.end_point

      orders.push({
        'address': address,
        'data': { 'id_str': uuid(), 'text': fragmentText }
      })
    }
    return orders
  }
}
