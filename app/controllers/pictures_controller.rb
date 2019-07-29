# frozen_string_literal: true

require 'open-uri'

class PicturesController < ApplicationController
  skip_before_action :authorized, only: %i[create flickr_pictures]

  # def index
  #   page = params[:page] || 1
  #   @pagy, @pictures = pagy_array(Picture.all.sort_by { |p| p['updated_at'] }.reverse)
  #   render json: @pictures, status: :ok
  # end

  def flickr_pictures
    sort = '&sort=relevance'
    url_flickr = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json'
    api_key = "&api_key=#{ENV['FLICKR_API_KEY']}"
    extras = '&extras=url_h,url_l'
    tags = "&tags=#{params[:tag]}"
    per_page = '&per_page=15'
    page = "&page=#{params[:page] || 1}"
    pictures = JSON.parse(open(url_flickr + api_key + extras + tags + per_page + page).read.split('(')[1].split(')')[0])['photos']['photo']
    display_pictures = pictures.map do |p|
      picture = {}
      picture[:id] = p['id']
      picture[:caption] = p['title']
      picture[:src] = p['url_h'] || p['url_l']
      picture[:width] = (p['width_h'] || p['width_l']).to_i
      picture[:height] = (p['height_h'] || p['height_l']).to_i
      picture
    end
    render json: display_pictures, status: :ok
  end

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
