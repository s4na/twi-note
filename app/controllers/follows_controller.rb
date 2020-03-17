# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    other_user = User.find(params[:followee_id])
    current_user.follow(other_user)
    redirect_back fallback_location: root_path, notice: t(".created")
  end

  def destroy
    Follow.destroy(params[:id])
    redirect_back fallback_location: root_path, notice: t(".destroyed")
  end
end
