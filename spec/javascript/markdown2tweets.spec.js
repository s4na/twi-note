import Markdown2Tweets from '../../app/javascript/markdown2tweets.js'
import { deleteIdStr } from './supports/delete_id_str.js'

import dataNormal from './data/markdown2tweets/normal.json'
import dataWithFragment from './data/markdown2tweets/with_fragment.json'
import dataNull from './data/markdown2tweets/null.json'

describe('set data', () => {
  const data = dataNormal

  const markdown = data.markdown
  const tweets = data.tweets
  const returnTweets = data.return_tweets

  it('', () => { expect(markdown).not.toBe(null) })
  it('', () => { expect(tweets).not.toBe(null) })
  it('', () => { expect(returnTweets).not.toBe(null) })

  describe('Convert markdown to tweets', () => {
    let m2t = new Markdown2Tweets({ tweets: tweets })
    let returnMarkdown = m2t.setMarkdown()

    it('', () => { expect(returnMarkdown).toBe(data.return_markdown) })
  })
})

describe('Convert tweets to markdown', () => {
  const data = dataNormal
  const markdown = data.markdown
  const tweets = data.tweets

  let m2t = new Markdown2Tweets({ markdown: markdown, tweets: tweets })
  let returnTweets = m2t.setTweets()

  returnTweets = deleteIdStr(returnTweets)
  data.return_tweets = deleteIdStr(data.return_tweets)

  it('', () => { expect(returnTweets).toMatchObject(data.return_tweets) })
})

describe('data with fragment', () => {
  const data = dataWithFragment
  const markdown = data.markdown
  const tweets = data.tweets

  describe('Change Markdown to Tweets', () => {
    let m2t = new Markdown2Tweets({ markdown: markdown, tweets: tweets })

    let returnTweets = m2t.setTweets()

    returnTweets = deleteIdStr(returnTweets)
    data.return_tweets = deleteIdStr(data.return_tweets)

    it('', () => { expect(returnTweets).toMatchObject(data.return_tweets) })

    describe('Change Tweets to Markdown', () => {
      let m2t2 = new Markdown2Tweets({ tweets: returnTweets })
      let returnMarkdown = m2t2.setMarkdown()

      let m2t3 = new Markdown2Tweets({ markdown: returnMarkdown, tweets: returnTweets })

      describe('Change Markdown to Tweets', () => {
        let returnTweets3 = m2t3.setTweets()
        returnTweets3 = deleteIdStr(returnTweets3)

        it('', () => { expect(returnTweets3).toMatchObject(data.return_tweets) })
      })
    })
  })
})

describe('data with fragment in markdown', () => {
  const data = dataWithFragment
  const markdown = data.markdown
  const tweets = data.tweets
  let m2t = new Markdown2Tweets({ markdown: markdown, tweets: tweets })

  let returnTweets = m2t.setTweets()
  returnTweets = deleteIdStr(returnTweets)
  data.return_tweets = deleteIdStr(data.return_tweets)

  it('', () => { expect(returnTweets).toMatchObject(data.return_tweets) })
})

describe('data is null', () => {
  const data = dataNull
  const markdown = data.markdown
  const tweets = data.tweets
  let m2t = new Markdown2Tweets({ markdown: markdown, tweets: tweets })

  let returnTweets = m2t.setTweets()
  returnTweets = deleteIdStr(returnTweets)

  it('', () => { expect(returnTweets).toMatchObject([]) })
})
