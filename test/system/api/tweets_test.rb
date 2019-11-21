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

    click_on "検索"
    assert_text "Markdown、初めて見たときはフォントのせいもあってか、「ゲジゲジみたいだな」って思った記憶"
  end
end
