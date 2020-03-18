# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followee, class_name: "User"

  validates :user_id, presence: true
  validates :followee_id, presence: true
end
