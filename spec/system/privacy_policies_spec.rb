# frozen_string_literal: true

require "rails_helper"

describe "privacy_policies", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }
  before { sign_in user_1 }

  context "show privacy policies" do
    before { visit privacy_policies_path }
    it { expect(page).to have_content "プライバシーポリシー" }
  end
end
