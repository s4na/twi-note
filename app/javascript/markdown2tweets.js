import uuid from 'uuid'

export default class Markdown2Tweets {
  constructor (params) {
    this.markdown = params['markdown']
    this.tweets = params['tweets']
  }

  setTweets () {
    this.returnTweets = []
    if (this.markdown !== '') {
      this._setReturnTweets()
    }
    return this.returnTweets || []
  }

  setMarkdown () {
    this.returnMarkdown = ''
    if (this.tweets.length !== 0) {
      this._setReturnMarkdown()
    }
    return this.returnMarkdown || ''
  }

  _setReturnMarkdown () {
    let indexs = JSON.parse(JSON.stringify(this.tweets, null, 2))
    for (let index of indexs) {
      this.returnMarkdown += index['markdown'] + '\n\n'
    }
  }

  _setReturnTweets () {
    this._setOrder()
    this._ascendingSort()
    this._changeFragmentToTweet()
    this._addFirstFragmentTextToTweet()
    this._addLastFragmentTextToTweet()
    this._ascendingSort()

    for (let id = 0; id < this.orders.length; id++) {
      this.returnTweets.push(this.orders[id].data)
    }
  }

  _setOrder () {
    this.orders = []
    for (const tweet of this.tweets) {
      const address = this.markdown.indexOf(tweet.markdown)

      if (address >= 0) {
        let newTweet = this._checkLineBreak(tweet, address)
        this.orders.push(newTweet)
      }
    }
  }

  _checkLineBreak (tweet, address) {
    let length = tweet.markdown.length
    let endPoint = address + length
    const tweetSpace = this.markdown.substr(endPoint, 2)

    if (tweetSpace === '\n\n') {
      length += 2
      endPoint += 2
    } else if (tweetSpace.substr(0, 1) === '\n') {
      length += 1
      endPoint += 1
    }

    return {
      address: address,
      length: length,
      end_point: endPoint,
      data: tweet
    }
  }

  _ascendingSort () {
    this.orders = this.orders.sort(function (a, b) {
      return a.address < b.address ? -1 : 1
    })
  }

  _changeFragmentToTweet () {
    for (let id = 0; id < this.orders.length; id++) {
      if (id !== 0) {
        if (this.orders[id - 1].end_point < this.orders[id].address) {
          const fragmentTextLength =
            this.orders[id].address - this.orders[id - 1].end_point
          const fragmentText = this.markdown.substr(
            this.orders[id - 1].end_point,
            fragmentTextLength
          )
          const address = this.orders[id - 1].end_point

          this.orders.push({
            address: address,
            data: { id_str: uuid(), markdown: fragmentText }
          })
        }
      }
    }
  }

  _addFirstFragmentTextToTweet () {
    const ordersFirstAddress = Math.min.apply(
      null,
      this.orders.map(function (o) {
        return o.address
      })
    )
    const firstOrder = this.orders.filter(
      o => o.address === ordersFirstAddress
    )[0]

    if (ordersFirstAddress !== 0) {
      const fragmentTextLength = firstOrder.address
      const fragmentText = this.markdown.substr(0, fragmentTextLength)

      this.orders.push({
        address: 0,
        data: { id_str: uuid(), markdown: fragmentText }
      })
    }
  }

  _addLastFragmentTextToTweet () {
    const ordersLastAddress = Math.max.apply(
      null,
      this.orders.map(function (o) {
        return o.address
      })
    )
    const lastOrder = this.orders.filter(
      o => o.address === ordersLastAddress
    )[0]
    const markdownLength = this.markdown.length

    if (lastOrder.end_point !== markdownLength) {
      const fragmentTextLength = markdownLength - lastOrder.end_point
      const fragmentText = this.markdown.substr(
        lastOrder.end_point,
        fragmentTextLength
      )
      const address = lastOrder.end_point + 1

      const fragmentOrder = {
        address: address,
        data: { id_str: uuid(), markdown: fragmentText }
      }
      this.orders.push(fragmentOrder)
    }
  }
}
