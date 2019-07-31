# frozen_string_literal: true

class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :park
  has_many :pictures
  has_many :likes, as: :likable

  validates :year, :title, :description, :season, presence: true
  validates :year, inclusion: { in: 1900..Date.today.year, message: ' is invalid' }
  
  # validate if user and park are valid, no idea if works, would need postman to test
  # validate :valid_user_id, :valid_park_id

  # def valid_user_id
  #   users = User.all.map(&:id)
  #   unless user_id.present? && users.include?(user_id)
  #     errors.add('Invalid User for Trip')
  #   end
  # end

  # def valid_park_id
  #   parks = Park.all.map(&:id)
  #   unless park_id.present? && parks.include?(park_id)
  #     errors.add('Invalid Park for Trip')
  #   end
  # end

  def like_count
    likes.count
  end
end
