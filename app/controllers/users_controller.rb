# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def get_user
    render json: current_user, status: :ok
  end

  def show
    user = User.find(params[:id])
    render json: user, status: :ok
  end

  def create
    user = User.new(s_params)
    if @user.save!
      token = enconde_token(user_id: user.id)
      render json: { user: user, token: token }, status: :created
    else
      render json: user.errors.full_messages, status: :not_acceptable
    end
  end

  private

  def s_params
    params.require(:user).permit(:username, :password, :firstname, :lastname, :profile_url)
  end
end
