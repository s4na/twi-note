import Markdown2Tweets from '../../app/javascript/markdown2tweets.js'
import data from './data/markdown2tweets/normal.json'
import dataWithFragment from './data/markdown2tweets/with_fragment.json'
import dataNull from './data/markdown2tweets/null.json'

test('load json file data', () => {
  const markdown = data.markdown
  const tweets = data.tweets
  const lists = data.return_tweets

  expect(markdown).not.toBe(null)
  expect(tweets).not.toBe(null)
  expect(lists).not.toBe(null)
})

test('Convert tweets to markdown', () => {
  const markdown = data.markdown
  const tweets = data.tweets
  var m2t = new Markdown2Tweets({ 'markdown': markdown, 'tweets': tweets })

  var lists = m2t.setTweets()
  var list
  for (list of lists) { delete (list.id_str) }
  for (list of data.return_tweets) { delete (list.id_str) }

  expect(JSON.stringify(lists)).toBe(JSON.stringify(data.return_tweets))
})

test('When there is fragment data in markdown, convert it to tweets', () => {
  const data = dataWithFragment
  const markdown = data.markdown
  const tweets = data.tweets
  var m2t = new Markdown2Tweets({ 'markdown': markdown, 'tweets': tweets })

  var lists = m2t.setTweets()
  var list
  for (list of lists) { delete (list.id_str) }
  for (list of data.return_tweets) { delete (list.id_str) }

  expect(JSON.stringify(lists)).toBe(JSON.stringify(data.return_tweets))
})

test('If the data is null, return null', () => {
  const data = dataNull
  const markdown = data.markdown
  const tweets = data.tweets
  var m2t = new Markdown2Tweets({ 'markdown': markdown, 'tweets': tweets })

  var lists = m2t.setTweets()
  var list
  for (list of lists) { delete (list.id_str) }
  for (list of data.return_tweets) { delete (list.id_str) }

  expect(JSON.stringify(lists)).toBe(JSON.stringify(data.return_tweets))
})
