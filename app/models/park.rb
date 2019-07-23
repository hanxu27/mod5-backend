# frozen_string_literal: true

class Park < ApplicationRecord
  has_many :pictures
  has_many :trips
  has_many :users, through: :trips

  def self.designation_select(designation = '')
    Park.all.select { |p| p.designation.downcase.include?(designation.downcase) }
  end

  def self.others
    Park.all.select do |p|
      parkDesignation = p.designation.downcase
        parkDesignation != 'national park' &&
        parkDesignation != 'national monument' &&
        parkDesignation.include?('preserve') &&
        parkDesignation != 'national historic site' &&
        parkDesignation != 'national historic park'
    end
end
end
