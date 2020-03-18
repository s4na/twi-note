# frozen_string_literal: true

require "rails_helper"

describe "disclaimers", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }
  before { sign_in user_1 }

  context "show disclaimers" do
    before { visit disclaimers_path }
    it { expect(page).to have_content "免責事項" }
  end
end
