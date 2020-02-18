# frozen_string_literal: true

require "application_system_test_case"
require "webmock"

class TweetsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:user_1)
    login_as(@user, scope: :user)

    @search_setting = search_settings(:search_setting_1)
    @note = notes(:note_1)
  end

  test "show tweets" do
    travel_to Time.zone.parse("2021-11-24 11:22:33")

    visit notes_url
    click_on "追加"

    fill_in "note[search_setting_attributes][query]", with: @search_setting.query
    find("#note_search_setting_attributes_start_datetime").click
    assert_text "November 2021"
    find(".vdatetime-calendar__month__day", text: "16").click
    find(".vdatetime-popup__actions__button--confirm", text: "Ok").click
    find(".vdatetime-time-picker__item", text: "22").click
    find(".vdatetime-time-picker__item", text: "30").click
    find(".vdatetime-popup__actions__button--confirm", text: "Ok").click

    find("#note_search_setting_attributes_end_datetime").click
    assert_text "November 2021"
    find(".vdatetime-calendar__month__day", text: "16").click
    find(".vdatetime-popup__actions__button--confirm", text: "Ok").click
    find(".vdatetime-time-picker__item", text: "23").click
    find(".vdatetime-time-picker__item", text: "30").click
    find(".vdatetime-popup__actions__button--confirm", text: "Ok").click
    click_on "検索"

    travel_back

    assert find(".card", text: "Markdown、初めて見たときはフォントのせいもあってか、「ゲジゲジみたいだな」って思った記憶")
  end
end
