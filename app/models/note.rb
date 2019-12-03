# frozen_string_literal: true

class Note < ApplicationRecord
  has_many :tweet_repositories, dependent: :destroy
end
