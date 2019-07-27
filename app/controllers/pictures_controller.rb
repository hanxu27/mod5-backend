# frozen_string_literal: true

class PicturesController < ApplicationController
  skip_before_action :authorized, only: [:create]

  # def index
  #   page = params[:page] || 1
  #   @pagy, @pictures = pagy_array(Picture.all.sort_by { |p| p['updated_at'] }.reverse)
  #   render json: @pictures, status: :ok
  # end

  def create
    picture = Picture.new(s_params)
    if picture.save!
      render json: picture, status: :created
    else
      render json: picture.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    picture = Picture.find(params[:id])
    if current_user.id == picture.user.id
      picture.destroy
      render json: picture, status: :ok
    else
      render json: { message: ['cannot delete picture that are not yours'] }, status: :unauthorized
    end
  end

  private

  def s_params
    params.require(:picture).permit(:park_id, :user_id, :trip_id, :url, :title, :caption)
  end
end
