# frozen_string_literal: true

require "application_system_test_case"
require "webmock"

class TweetsTest < ApplicationSystemTestCase
  setup do
    @note = notes(:note_1)
  end

  test "show tweets" do
    visit notes_url
    click_on "追加"

    fill_in "tweets-search[start_datetime]", with: "2019-11-10 23:59"
    fill_in "tweets-search[end_datetime]", with: "2019-11-20 23:59"

    click_on "検索"
    assert_text "Markdown、初めて見たときはフォントのせいもあってか、「ゲジゲジみたいだな」って思った記憶"
  end

  test "change tweet to markdown" do
    # visit notes_url
    visit "/notes/#{notes(:note_3).id}/edit"
    
    # sleep(100)
    assert_text "ノートの編集"

    within(".note-tweets") do
      # fill_in("product[body]", with: "test")
      assert_text "export default class xxx {}としてなくてWebpack errorが出て数十分溶かしたnnJSへの理解がまだまだ足りない😢nnそしてexport, importするとstrictモードらしいので、これまで… https://t.co/7v6kQYLl4K\n— s4na / Nabetani 🐧そうだ！Rubyを書こう！ (@s4na_penguin)\n@hase_kun_ ありがとうございます！！nnそうですね😢nIEがclass使えないので・・・nnReact.jsのtestらへんがclass使っているみたいなので、参考にしようかと思っています\n— s4na / Nabetani 🐧そうだ！Rubyを書こう！ (@s4na_penguin)"
    end
    
    click_on "Previewに切り替え"

    # sleep(100)
    within("#note_body") do
      # fill_in("product[body]", with: "test")
      assert_text "export default class xxx {}としてなくてWebpack errorが出て数十分溶かしたnnJSへの理解がまだまだ足りない😢nnそしてexport, importするとstrictモードらしいので、これまで… https://t.co/7v6kQYLl4K\n— s4na / Nabetani 🐧そうだ！Rubyを書こう！ (@s4na_penguin)\n@hase_kun_ ありがとうございます！！nnそうですね😢nIEがclass使えないので・・・nnReact.jsのtestらへんがclass使っているみたいなので、参考にしようかと思っています\n— s4na / Nabetani 🐧そうだ！Rubyを書こう！ (@s4na_penguin)"
    end

    # click_on "追加"

    # fill_in "tweets-search[start_datetime]", with: "2019-11-10 23:59"
    # fill_in "tweets-search[end_datetime]", with: "2019-11-20 23:59"

    # click_on "検索"
    # assert_text "Markdown、初めて見たときはフォントのせいもあってか、「ゲジゲジみたいだな」って思った記憶"
  end
end
