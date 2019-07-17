# frozen_string_literal: true

class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.references :park, foreign_key: true
      t.references :user, foreign_key: true
      t.references :trip, foreign_key: true
      t.string :url
      t.string :title
      t.string :caption

      t.timestamps
    end
  end
end
