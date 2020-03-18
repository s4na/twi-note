# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.find(params[:user_id]).followings
  end
end
