# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.find(params[:user_id]).followers
  end
end
