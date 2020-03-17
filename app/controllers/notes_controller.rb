# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :set_note, only: [:show]
  before_action :set_current_user_note, only: [:edit, :update, :destroy]

  CONTENTS_NUM = 10
  def index
    if user_signed_in?
      @notes = current_user.notes.order(updated_at: "DESC").page(params[:page]).per(CONTENTS_NUM)
    else
      render template: "welcome/index", layout: "welcome"
    end
  end

  def show
  end

  def new
    @note = Note.new
    @note.build_search_setting
  end

  def edit
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user

    if @note.save
      redirect_to @note, notice: "ノートを作成しました"
    else
      render :new
    end
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: "ノートを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_url, notice: "ノートを削除しました"
  end

  private
    def set_note
      @note = Note.find(params[:id])
    end

    def set_current_user_note
      @note = current_user.notes.find(params[:id])
    end

    def note_params
      params.require(:note).permit(
        :title, :body, :tweets, :all_search_result_tweets, :edit_mode,
        search_setting_attributes: [:query, :start_datetime, :end_datetime]
      )
    end
end
