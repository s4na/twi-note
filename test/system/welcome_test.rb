# frozen_string_literal: true

require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
  end

  test "show welcome when user is not logged in" do
    visit root_path
    assert_selector "h1", text: "勉強会のノートに、ツイートを貼ろう"
  end
end
