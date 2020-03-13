# frozen_string_literal: true

require "rails_helper"

describe "welcomes", type: :system do
  context "show welcome when user is not logged in" do
    before do
      visit root_path
    end

    it "check title" do
      expect(page).to have_content "ノートにツイートを貼れるサービス"
    end
  end
end
