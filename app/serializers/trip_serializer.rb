# frozen_string_literal: true

class TripSerializer < ActiveModel::Serializer
  attributes :title, :description, :season, :year, :user, :park, :user_id, :like_count, :pictures
end
