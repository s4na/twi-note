# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["HEADED"]
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  else
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400] do |driver_options|
      driver_options.add_argument("--disable-dev-shm-usage")
      driver_options.add_argument("--no-sandbox")
    end
  end
end
