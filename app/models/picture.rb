# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :park
  belongs_to :user, optional: true
  belongs_to :trip, optional: true
  has_many :likes, as: :likable

  def like_count
    likes.count
  end
end
