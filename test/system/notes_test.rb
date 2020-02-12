# frozen_string_literal: true

require "application_system_test_case"

class NotesTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:user_1)
    @search_setting = search_settings(:search_setting_1)
    login_as(@user, scope: :user)

    @note = notes(:note_1)
  end

  test "show notes" do
    visit notes_path
    assert_selector "h1", text: "ノート一覧"
  end

  test "show note" do
    visit note_path(@note)
    assert_selector "h1", text: @note.title
  end

  test "create note" do
    visit notes_url
    click_on "追加"

    find('label[for="tab-markdown"]').click
    fill_in "note[title]", with: @note.title
    fill_in "note-form__textarea", with: @note.body
    fill_in "note[search_setting_attributes][query]", with: @search_setting.query

    click_on "ノートを保存"

    assert_text "ノートを作成しました"
  end

  test "update note" do
    visit notes_url
    click_on "編集", match: :first

    find('label[for="tab-markdown"]').click
    fill_in "note[title]", with: @note.title
    fill_in "note-form__textarea", with: @note.body
    fill_in "note[search_setting_attributes][query]", with: @search_setting.query

    click_on "ノートを保存"

    assert_text "ノートを更新しました"
  end

  test "destroy note" do
    visit notes_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "ノートを削除しました"
  end
end
