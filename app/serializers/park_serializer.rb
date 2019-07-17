# frozen_string_literal: true

class ParkSerializer < ActiveModel::Serializer
  attributes :id, :latLong, :name, :fullname, :parkCode, :states, :designation, :url, :description, :weatherInfo, :pictures
end
