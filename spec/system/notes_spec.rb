# frozen_string_literal: true

require "rails_helper"

describe "note", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:note_1) { FactoryBot.create(:note, user: user_1) }
  let!(:search_setting_1) { FactoryBot.create(:search_setting, note: note_1) }

  before { sign_in user_1 }

  context "show notes" do
    before { visit notes_path }
    it { expect(page).to have_content "ノート一覧" }
  end

  context "show note" do
    before { visit note_path(note_1) }
    it { expect(page).to have_content note_1.title }
  end

  context "create note" do
    before do
      visit notes_path
      click_on "追加"

      find('label[for="tab-markdown"]').click
      fill_in "note[title]", with: note_1.title
      fill_in "note-form__textarea", with: note_1.body
      fill_in "note[search_setting_attributes][query]", with: search_setting_1.query
      click_on "保存"
    end

    it { expect(page).to have_content "ノートを作成しました" }
  end

  context "update note" do
    before do
      visit notes_path

      click_on "編集", match: :first

      find('label[for="tab-markdown"]').click
      fill_in "note[title]", with: note_1.title
      fill_in "note-form__textarea", with: note_1.body
      fill_in "note[search_setting_attributes][query]", with: search_setting_1.query
      click_on "保存"
    end

    it { expect(page).to have_content "ノートを更新しました" }
  end

  context "destroy note" do
    before do
      visit notes_path

      page.accept_confirm do
        click_on "削除", match: :first
      end
    end

    it { expect(page).to have_content "ノートを削除しました" }
  end

  # System test for Vue.js
  context "when note.body is empty" do
    before do
      visit note_path(note_1)
      click_on "編集"

      find('label[for="tab-markdown"]').click
      fill_in "note-form__textarea", with: ""

      click_on "保存"
    end
    it { expect(page).to have_content "ノートを更新しました" }

    context "check that it is empty even after converting to markdown and returning" do
      before do
        click_on "編集"

        find('label[for="tab-preview"]').click
        find('label[for="tab-markdown"]').click
        click_on "保存"
      end

      it { expect(find("#note-show__text").text).to have_content "> @s4na_penguin ありがとうございますー！ \n> [Tsuyoshi Hoshino](https://twitter.com/hoppiestar/status/1237048102919389185?ref_src=twsrc%5Etfw)" }
    end
  end
end
