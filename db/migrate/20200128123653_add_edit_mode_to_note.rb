# frozen_string_literal: true

class AddEditModeToNote < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :edit_mode, :string
  end
end
