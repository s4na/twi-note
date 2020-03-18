# frozen_string_literal: true

class Users::NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.includes(:notes).find(params[:user_id])
    @notes = @user.notes
  end
end
