# frozen_string_literal: true

require "rails_helper"

describe "notes", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }
  let!(:note_2) { FactoryBot.create(:note, user: user_2) }
  let!(:search_setting_2) { FactoryBot.create(:search_setting, note: note_2) }
  subject! { user_1.follow(user_2) }

  before { sign_in user_1 }

  context "show notes" do
    before { visit user_notes_path(user_2) }
    it { expect(page).to have_content "User_2のノート一覧" }
  end
end
