# frozen_string_literal: true

require "rails_helper"
require "webmock"

describe "tweets", type: :system do
  include ActiveSupport::Testing::TimeHelpers

  let!(:user_1) { FactoryBot.create(:user) }
  let!(:note_1) { FactoryBot.create(:note, user: user_1) }
  let!(:search_setting_1) { FactoryBot.create(:search_setting, note: note_1) }

  subject(:search_tweets) {
    -> {
      travel_to Time.zone.parse("2021-11-24 11:22:33")

      visit notes_path
      click_on "追加"

      fill_in "note[search_setting_attributes][query]", with: search_setting_1.query
      find("#note_search_setting_attributes_start_datetime").click

      expect(page).to have_content "November 2021"
    
      find(".vdatetime-calendar__month__day", text: "16").click
      find(".vdatetime-popup__actions__button--confirm", text: "Ok").click
      find(".vdatetime-time-picker__item", text: "22").click
      find(".vdatetime-time-picker__item", text: "30").click
      find(".vdatetime-popup__actions__button--confirm", text: "Ok").click

      find("#note_search_setting_attributes_end_datetime").click

      expect(page).to have_content "November 2021"

      find(".vdatetime-calendar__month__day", text: "16").click
      find(".vdatetime-popup__actions__button--confirm", text: "Ok").click
      find(".vdatetime-time-picker__item", text: "23").click
      find(".vdatetime-time-picker__item", text: "30").click
      find(".vdatetime-popup__actions__button--confirm", text: "Ok").click
      click_on "検索"

      travel_back
    }
  }

  before { sign_in user_1 }

  context "search tweets" do
    before { search_tweets.call }
    it { expect(page).to have_content "Markdown、初めて見たときはフォントのせいもあってか、「ゲジゲジみたいだな」って思った記憶" }
  end
end
