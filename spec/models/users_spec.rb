# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe ".find_for_twitter_oauth" do
    it "" do
      auth = OmniAuth::AuthHash.new({
        provider: "Twitter",
        uid: 1,
        info: { nickname: "Alice" }
      })

      user = User.find_for_twitter_oauth(auth)

      expect("Alice").to eq user.name
      expect("1").to eq user.uid
      expect("Twitter").to eq user.provider
    end
  end
end
