# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :park
  belongs_to :user, optional: true
  belongs_to :trip, optional: true
  has_many :likes, as: :likable

  validates :url, :title, :caption, presence: true
  validate :valid_user_id, :valid_park_id

  def valid_user_id
    users = User.all.map(&:id)
    unless user_id.present? && users.include?(user_id)
      errors.add('Invalid User for Trip')
    end
  end

  def valid_park_id
    parks = Park.all.map(&:id)
    unless park_id.present? && parks.include?(park_id)
      errors.add('Invalid Park for Trip')
    end
  end

  def like_count
    likes.count
  end
end
