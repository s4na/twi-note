# frozen_string_literal: true

require "rails_helper"

describe "note", type: :system do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:note_1) { FactoryBot.create(:note, user: user_1) }
  let!(:search_setting_1) { FactoryBot.create(:search_setting, note: note_1) }

  before do
    sign_in user_1
  end

  context "show notes" do
    before do
      visit notes_path
    end

    it "check title" do
      expect(page).to have_content "ノート一覧"
    end
  end

  context "show note" do
    before do
      visit note_path(note_1)
    end

    it "check title" do
      expect(page).to have_content note_1.title
    end
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

    it "check title" do
      expect(page).to have_content "ノートを作成しました"
    end
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

    it "check title" do
      expect(page).to have_content "ノートを更新しました"
    end
  end

  context "destroy note" do
    before do
      visit notes_path

      page.accept_confirm do
        click_on "削除", match: :first
      end
    end

    it "check title" do
      expect(page).to have_content "ノートを削除しました"
    end
  end


  context "when note.body is empty, check that it is empty even after converting to markdown and returning" do
    before do
      visit note_path(note_1)
      click_on "編集"

      find('label[for="tab-markdown"]').click
      fill_in "note-form__textarea", with: ""

      click_on "保存"
    end

    it "check title" do
      expect(page).to have_content "ノートを更新しました"
      click_on "編集"

      find('label[for="tab-preview"]').click
      find('label[for="tab-markdown"]').click
      click_on "保存"

      expect(find("#note-show__text").text).to have_content "> @s4na_penguin ありがとうございますー！ \n> [Tsuyoshi Hoshino](https://twitter.com/hoppiestar/status/1237048102919389185?ref_src=twsrc%5Etfw)"
    end
  end
end
