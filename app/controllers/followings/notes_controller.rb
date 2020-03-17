# frozen_string_literal: true

class Followings::NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    followings = current_user.followings.includes(:notes)
    @notes = followings.map { |u| u.notes }.flatten
  end
end
