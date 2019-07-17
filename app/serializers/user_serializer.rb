# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :firstname,
             :lastname,
             :profile_url,
             :trips,
             :most_liked_trips,
             :most_liked_pictures,
             :national_park_progress,
             :national_monument_progress,
             :national_preserve_progress
end
