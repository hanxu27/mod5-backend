# frozen_string_literal: true
require 'open-uri'

class Picture < ApplicationRecord
  belongs_to :park
  belongs_to :user, optional: true
  belongs_to :trip, optional: true
  has_many :likes, as: :likable

  validates :url, :title, :caption, presence: true
  validate :valid_image_url

  def valid_image_url
      if URI.parse(url).kind_of?(URI::HTTP)  
      url_ext = url.split('.')[-1].downcase
      pic_ext = %w[
        tif tiff gif jpeg jpg png
      ]
      byebug
      unless open(url).status[0] == '200' &&  pic_ext.include?(url_ext)
        errors.add(:url, 'error: please provide a valid URL of an image')
      end
    else
      errors.add(:url, 'error: please provide a valid URL') 
    end
  end

  def like_count
    likes.count
  end
end
