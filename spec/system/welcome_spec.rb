# frozen_string_literal: true

require "rails_helper"

describe "welcomes", type: :system do
  context "show welcome when user is not logged in" do
    before { visit root_path }
    it { expect(page).to have_content "ノートにツイートを貼れるサービス" }
  end
end
