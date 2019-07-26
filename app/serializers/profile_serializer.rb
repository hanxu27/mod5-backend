# frozen_string_literal: true

class ProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :firstname,
             :lastname,
             :profile_url,
             :sorted_trips,
             :most_liked_trips,
             :most_liked_pictures,
             :last_picture,
             :national_park_progress,
             :national_monument_progress,
             :national_preserve_progress,
             :historic_site_progress,
             :historical_park_progress
end
