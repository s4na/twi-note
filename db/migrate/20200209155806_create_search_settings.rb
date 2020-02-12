# frozen_string_literal: true

class CreateSearchSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :search_settings do |t|
      t.belongs_to :note, foreign_key: true

      t.string :query
      t.string :start_datetime
      t.string :end_datetime

      t.timestamps
    end
  end
end
