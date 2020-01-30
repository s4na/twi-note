# frozen_string_literal: true

require "application_system_test_case"

class PrivacyPoliciesTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
  end

  test "show privacy policies" do
    visit root_path
    assert_selector "h1", text: "プライバシーポリシー"
  end
end
