# frozen_string_literal: true

class Notes::DownloadController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_note, only: [:show]

  def show
    respond_to do |format|
      format.text { text_export }
    end
  end

  private
    def set_note
      @note = current_user.notes.find(params[:id])
    end

    def note_params
      params.require(:note).permit(
        :title, :body, :tweets, :all_search_result_tweets, :edit_mode,
        search_setting_attributes: [:query, :start_datetime, :end_datetime]
      )
    end

    def text_export
      if @note.title.nil?
        send_data(
          "#{@note.body}\n",
          filename: "note.text"
        )
      else
        send_data(
          "# #{@note.title}\n\n#{@note.body}\n",
          filename: "#{@note.title}.text"
        )
      end
    end
end
