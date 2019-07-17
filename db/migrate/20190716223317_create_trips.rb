# frozen_string_literal: true

class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true
      t.references :park, foreign_key: true
      t.string :title
      t.string :description
      t.string :season
      t.integer :year

      t.timestamps
    end
  end
end
