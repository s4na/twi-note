# frozen_string_literal: true

require "rails_helper"

describe "followings_notes", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }

  let!(:user_2) { FactoryBot.create(:user) }
  let!(:note_2) { FactoryBot.create(:note, user: user_2, title: "user_2_note_title") }
  let!(:search_setting_2) { FactoryBot.create(:search_setting, note: note_2) }

  let!(:user_3) { FactoryBot.create(:user) }
  let!(:note_3) { FactoryBot.create(:note, user: user_3, title: "user_3_note_title") }
  let!(:search_setting_2) { FactoryBot.create(:search_setting, note: note_3) }

  before {
    sign_in user_1
    user_1.follow(user_2)
    user_1.follow(user_3)
  }

  context "show followings_notes" do
    before { visit followings_notes_path }

    it { expect(page).to have_content "user_2_note_title" }
    it { expect(page).to have_content "user_3_note_title" }
  end
end
