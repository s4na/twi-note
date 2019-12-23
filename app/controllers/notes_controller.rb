# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = current_user.notes.all
  end

  def show
  end

  def new
    @note = Note.new
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
      @note = current_user.notes.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :body, :tweets, :all_search_result_tweets)
    end
end
