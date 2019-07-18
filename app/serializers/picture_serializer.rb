# frozen_string_literal: true

class PictureSerializer < ActiveModel::Serializer
  attributes :id, :park_id, :trip_id, :user_id, :url, :title, :caption, :like_count
end
