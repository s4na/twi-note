# frozen_string_literal: true

class CreateTweetRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :tweet_repositories do |t|
      t.integer :note_id, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
