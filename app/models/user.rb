# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :pictures
  has_many :trips
  has_many :parks, through: :trips
  has_many :likes

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

  def national_monument
    parks_progress('national park')
  end

  def national_preserve
    parks_preserve('national perserve')
  end
end