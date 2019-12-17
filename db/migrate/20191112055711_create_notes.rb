# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :body
      t.text :tweets
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
