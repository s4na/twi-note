# frozen_string_literal: true

require "rails_helper"

describe "followers", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }
  before { sign_in user_1 }

  context "user_1 follow user_2" do
    subject! { user_1.follow(user_2) }

    context "show followers" do
      before { visit user_followers_path(user_1) }
      it { expect(page).to have_content "フォロワー一覧" }
    end
  end
end
