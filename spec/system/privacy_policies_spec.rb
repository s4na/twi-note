# frozen_string_literal: true

require "rails_helper"

describe "privacy_policies", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }

  before do
    sign_in user_1
  end

  context "show privacy policies" do
    before do
      visit privacy_policies_path
    end

    it "check title" do
      expect(page).to have_content "プライバシーポリシー"
    end
  end
end
