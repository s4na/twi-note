# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  class Auth
    def provider
      "Twitter"
    end

    def uid
      1
    end

    def info
      Info.new
    end
  end

  class Info
    def nickname
      "Alice"
    end
  end

  private_constant :Auth, :Info

  test ".find_for_twitter_oauth" do
    user = User.find_for_twitter_oauth(Auth.new)

    assert_equal "Alice", user.name
    assert_equal "1", user.uid
    assert_equal "Twitter", user.provider
  end
end
