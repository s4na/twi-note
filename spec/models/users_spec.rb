# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe ".find_for_twitter_oauth" do
    let(:auth) {
      OmniAuth::AuthHash.new({
        provider: "Twitter",
        uid: 1,
        info: { nickname: "Alice" }
      })
    }
    let(:user) { User.find_for_twitter_oauth(auth) }

    it { expect("Alice").to eq user.name }
    it { expect("1").to eq user.uid }
    it { expect("Twitter").to eq user.provider }
  end
end
