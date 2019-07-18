# frozen_string_literal: true

class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by(username: s_params[:username])
    if user&.authenticate(s_params[:password])
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }, status: :accepted
    else
      render json: { message: 'Invalid Login' }, status: :unauthorized
    end
  end

  private

  def s_params
    params.require(:user).permit(:username, :password)
  end
end
