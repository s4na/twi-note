# frozen_string_literal: true

require "application_system_test_case"

class NotesTest < ApplicationSystemTestCase
  setup do
    @note = notes(:note_1)
  end

  test "show notes" do
    visit notes_url
    assert_selector "h1", text: "ノート一覧"
  end

  test "create note" do
    visit notes_url
    click_on "追加"

    fill_in "note[title]", with: @note.title
    fill_in "note[body]", with: @note.body
    click_on "登録する"

    assert_text "ノートを作成しました"
    click_on "一覧へ"
  end

  test "update note" do
    visit notes_url
    click_on "編集", match: :first

    fill_in "note[title]", with: @note.title
    fill_in "note[body]", with: @note.body
    click_on "更新"

    assert_text "ノートを更新しました"
    click_on "一覧へ"
  end

  test "destroy note" do
    visit notes_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "ノートを削除しました"
  end
end
