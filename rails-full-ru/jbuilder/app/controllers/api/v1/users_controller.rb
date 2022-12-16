# frozen_string_literal: true

class Api::V1::UsersController < Api::ApplicationController
  # BEGIN
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
  # END
end
