# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test ".find_for_twitter_oauth" do
    auth = MiniTest::Mock.new
    info = MiniTest::Mock.new.expect(:nickname, "Alice")

    auth.expect :uid, 1 do
      auth.expect :provider, "Twitter" do
        auth.expect :info, info do
          user = User.find_for_twitter_oauth(auth)

          assert_equal "Alice", user.name
          assert_equal "1", user.uid
          assert_equal "Twitter", user.provider
        end
      end
    end
  end
end
