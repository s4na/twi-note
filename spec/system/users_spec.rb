# frozen_string_literal: true

require "rails_helper"

describe "followings", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }
  before { sign_in user_1 }

  context "show users" do
    before { visit users_path }
    it { expect(page).to have_content "ユーザー一覧" }
  end

  context "follow user_2" do
    before {
      visit user_path(user_2)
      click_on "フォローする"
    }
    it { expect(page).to have_content "フォローしました" }

    context "unfollow user_2" do
      before { click_on "フォロー中" }
      it { expect(page).to have_content "フォロー解除しました" }
    end
  end
end
