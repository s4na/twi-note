import uuid from 'uuid'

export default class Markdown2Tweet {
  constructor (text, tweets) {
    this.text = text
    this.orders = []
    if (this.text !== '') {
      for (const tweet of tweets) {
        var address = text.indexOf(tweet.markdown)

        if (address >= 0) {
          this.orders.push({
            'address': address,
            'length': tweet.markdown.length,
            'end_point': (address + tweet.markdown.length),
            'data': tweet
          })
        }
      }
      this.setOrder()
    }
  }
  setOrder () {
    this.ascendingSort()
    this.changeFragment()
    this.addFirstFragmentTextText()
    this.addLastFragmentText()
    this.ascendingSort()
  }
  lists () {
    this.lists = []
    for (var id = 0; id < this.orders.length; id++) {
      this.lists.push(this.orders[id].data)
    }
    return this.lists || []
  }
  ascendingSort () {
    this.orders = this.orders.sort(function (a, b) { return (a.address < b.address ? -1 : 1) })
  }
  changeFragment () {
    for (var id = 0; id < this.orders.length; id++) {
      if (id !== 0) {
        if (this.orders[id - 1].end_point < this.orders[id].address) {
          const fragmentTextLength = this.orders[id].address - this.orders[id - 1].end_point
          const fragmentText = this.text.substr(this.orders[id - 1].end_point, fragmentTextLength)
          const address = this.orders[id - 1].end_point

          this.orders.push({
            'address': address,
            'data': { 'id_str': uuid(), 'text': fragmentText }
          })
        }
      }
    }
  }
  addFirstFragmentTextText () {
    const ordersFirstAddress = Math.min.apply(null, this.orders.map(function (o) { return o.address }))
    const firstOrder = this.orders.filter(o => o.address === ordersFirstAddress)[0]

    if (ordersFirstAddress !== 0) {
      const fragmentTextLength = firstOrder.address
      const fragmentText = this.text.substr(0, fragmentTextLength)

      this.orders.push({
        'address': 0,
        'data': { 'id_str': uuid(), 'text': fragmentText }
      })
    }
  }
  addLastFragmentText () {
    const ordersLastAddress = Math.max.apply(null, this.orders.map(function (o) { return o.address }))
    const lastOrder = this.orders.filter(o => o.address === ordersLastAddress)[0]
    const textLength = this.text.length

    if (ordersLastAddress !== textLength) {
      const fragmentTextLength = textLength - lastOrder.end_point
      const fragmentText = this.text.substr(lastOrder.end_point, fragmentTextLength)
      const address = lastOrder.end_point + 1

      const fragmentOrder = {
        'address': address,
        'data': { 'id_str': uuid(), 'text': fragmentText }
      }
      this.orders.push(fragmentOrder)
    }
  }
}
