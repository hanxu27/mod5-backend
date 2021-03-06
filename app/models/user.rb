# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :pictures
  has_many :trips
  has_many :parks, through: :trips
  has_many :likes

  validates :username, :password, :firstname, :lastname, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 5 }
  validate :valid_image_url

  def valid_image_url
    url = profile_url
    if URI.parse(url).is_a?(URI::HTTP)
      url_ext = url.split('.')[-1].downcase
      pic_ext = %w[
        tif tiff gif jpeg jpg png
      ]
      unless pic_ext.include?(url_ext) && open(url).status[0] == '200'
        errors.add(:url, 'error: please provide a valid URL of an image')
      end
    else
      errors.add(:url, 'error: please provide a valid URL')
    end
  end

  def last_picture
    pictures.empty? ? false : LastPictureSerializer.new(pictures.max_by(&:updated_at))
  end

  def sorted_trips
    sort_arr = %w[Spring Summer Fall Winter]
    trips.sort_by { |t| [t['year'], sort_arr.index(t['season'])] }.reverse.map { |t| TripSerializer.new(t) }
  end

  def most_liked_trips
    trips.sort_by(&:likes).reverse[0...2]
  end

  def most_liked_pictures
    pictures.sort_by(&:likes).reverse[0...2]
  end

  def parks_progress(designation)
    {
      visited: parks.select { |p| p.designation.downcase.include?(designation.downcase) }.count,
      total: Park.designation_select(designation).count
    }
  end

  def national_park_progress
    parks_progress('national park')
  end

  def national_monument_progress
    parks_progress('national monument')
  end

  def national_preserve_progress
    parks_progress('preserve')
  end

  def historic_site_progress
    parks_progress('national historic site')
  end

  def historical_park_progress
    parks_progress('national historical park')
  end
end
