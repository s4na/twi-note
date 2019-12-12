# frozen_string_literal: true

require 'rails_helper'

# require "application_system_test_case"
# require "webmock"

RSpec.describe "Notes", type: :system do
  # let(:user) { FactoryBot.create(:user) }
  # let(:project) {
  #   FactoryBot.create(:project,
  #     name: "RSpec tutorial",
  #     owner: user)
  # }
  # let!(:task) { project.tasks.create!(name: "Finish RSpec tutorial") }

  scenario "aiueo", js: true do
    # sign_in user

    visit notes_url

    click_on "追加"

    expect(page).to_not have_content "Completed"
    # go_to_project "RSpec tutorial"

    # complete_task "Finish RSpec tutorial"
    # expect_complete_task "Finish RSpec tutorial"

    # undo_complete_task "Finish RSpec tutorial"
    # expect_incomplete_task "Finish RSpec tutorial"
  end
end

