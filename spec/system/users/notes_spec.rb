# frozen_string_literal: true

require "rails_helper"

describe "notes", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }
  let!(:note_2) { FactoryBot.create(:note, user: user_2, title: "user_2_note_title") }
  let!(:search_setting_2) { FactoryBot.create(:search_setting, note: note_2) }

  before {
    sign_in user_1
    user_1.follow(user_2)
  }

  context "show notes" do
    before { visit user_notes_path(user_2) }
    it { expect(page).to have_content "user_2のノート一覧" }
  end
end
