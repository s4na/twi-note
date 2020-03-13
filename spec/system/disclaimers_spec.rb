# frozen_string_literal: true

require "rails_helper"

describe "disclaimers", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }

  before do
    sign_in user_1
  end

  context "show disclaimers" do
    before do
      visit disclaimers_path
    end

    it "check title" do
      expect(page).to have_content "免責事項"
    end
  end
end
