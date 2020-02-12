# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user, touch: true

  has_one :search_setting, dependent: :destroy
  accepts_nested_attributes_for :search_setting, update_only: true
end
