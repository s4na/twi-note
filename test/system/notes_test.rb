# frozen_string_literal: true

require "application_system_test_case"

class NotesTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
    @user = users(:user_1)
    login_as(@user, scope: :user)

    @note = notes(:note_1)
  end

  test "show notes" do
    visit notes_url
    assert_selector "h1", text: "ノート一覧"
  end

  test "show note" do
    visit note_path(@note)
    assert_selector "h1", text: @note.title
  end

  test "create note" do
    visit notes_url
    click_on "追加"

    fill_in "note[title]", with: @note.title
    fill_in "note[body]", with: @note.body
    click_on "保存"

    assert_text "ノートを作成しました"
  end

  test "update note" do
    visit notes_url
    click_on "編集", match: :first

    fill_in "note[title]", with: @note.title
    fill_in "note[body]", with: @note.body
    click_on "保存"

    assert_text "ノートを更新しました"
  end

  test "destroy note" do
    visit notes_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "ノートを削除しました"
  end

  test "edit a saved note and save it again" do
    # ツイートをドラッグできないのが・・・
  end
end
