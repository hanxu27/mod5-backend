# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user, status: :ok
  end

  def create; end

  private

  def s_params
    params.require(:user).permit(:username, :password, :firstname, :lastname, :profile_url)
  end
end
