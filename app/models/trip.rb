# frozen_string_literal: true

class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :park
  has_many :pictures
  has_many :likes, as: :likable

  def like_count
    likes.count
  end
end
