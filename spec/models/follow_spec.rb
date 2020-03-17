# frozen_string_literal: true

require "rails_helper"

RSpec.describe Follow, type: :model do
  let!(:current_user) { FactoryBot.create(:user, name: "current_user", uid: "1072823223190835202", email: "1072823223190835202-twitter@example.com") }
  let!(:other_user) { FactoryBot.create(:user, name: "other_user", uid: "1072823223190835203", email: "1072823223190835203-twitter@example.com") }

  describe "フォローした時" do
    subject! { current_user.follow(other_user) }

    it { expect(current_user.follows.count).to be 1 }
    it { expect(current_user.followings.first).to eq other_user }
    it { expect(other_user.followers.first).to eq current_user }

    describe "フォロー解除した時" do
      subject! { current_user.unfollow(other_user) }

      it { expect(current_user.follows.count).to be 0 }
    end
  end
end
