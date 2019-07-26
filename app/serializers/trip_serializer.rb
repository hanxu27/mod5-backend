# frozen_string_literal: true

class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :season, :year, :user, :park, :like_count, :pictures

  def user
    UserSerializer.new(object.user)
  end
end
