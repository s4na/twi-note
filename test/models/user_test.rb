# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test ".find_for_twitter_oauth" do
    auth = OmniAuth::AuthHash.new({
      provider: "Twitter",
      uid: 1,
      info: { nickname: "Alice" }
    })

    user = User.find_for_twitter_oauth(auth)

    assert_equal "Alice", user.name
    assert_equal "1", user.uid
    assert_equal "Twitter", user.provider
  end
end
