# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.references :followee, foreign_key: { to_table: :users }
      t.index [:user_id, :followee_id], unique: true

      t.timestamps
    end
  end
end
