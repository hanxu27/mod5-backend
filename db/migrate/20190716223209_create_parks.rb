# frozen_string_literal: true

class CreateParks < ActiveRecord::Migration[5.2]
  def change
    create_table :parks do |t|
      t.string :latLong
      t.string :name
      t.string :fullname
      t.string :parkCode
      t.string :states
      t.string :designation
      t.string :url
      t.text :description
      t.text :weatherInfo

      t.timestamps
    end
  end
end
