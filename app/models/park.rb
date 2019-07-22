# frozen_string_literal: true

class Park < ApplicationRecord
  has_many :pictures
  has_many :trips
  has_many :users, through: :trips

  def self.designation_select(designation = '')
    # National Historic Site, National Monument, National Historic Site, National Perserve, National Scenic River, National
    Park.all.select { |p| p.designation.downcase.include?(designation.downcase) }
  end
end
