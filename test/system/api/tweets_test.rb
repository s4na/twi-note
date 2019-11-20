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
    assert_text '"id": 1195372469411958800'
  end
end
