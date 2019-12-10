import Markdown2Tweet from '../../app/javascript/markdown2tweet.js'
import datas from './datas/markdown2tweet.json'

test('load json file datas', () => {
  const text = datas.text
  const tweets = datas.tweets
  const lists = datas.list

  expect(text).not.toBe(null)
  expect(tweets).not.toBe(null)
  expect(lists).not.toBe(null)
})

test('Markdown2Tweet', () => {
  const text = datas.text
  const tweets = datas.tweets
  var m2t = new Markdown2Tweet(text, tweets)

  const lists = m2t.lists(text)
  var removeKeyLists = lists
  var removeKeyDataLists = datas.lists
  for (var list of removeKeyLists) {
    delete (list.id_str)
  }
  for (var list2 of removeKeyDataLists) {
    delete (list2.id_str)
  }
  removeKeyLists = JSON.stringify(removeKeyLists)
  removeKeyDataLists = JSON.stringify(removeKeyDataLists)
  expect(removeKeyLists).toBe(removeKeyDataLists)
})
