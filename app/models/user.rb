# frozen_string_literal: true

class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_many :follows, dependent: :destroy

  has_many :followings, through: :follows, source: :followee
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "followee_id"
  has_many :followers, through: :reverse_of_follows, source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.find_for_twitter_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        provider: auth.provider,
        uid:      auth.uid,
        name:     auth.info.nickname,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  def follow(other_user)
    unless self == other_user
      self.follows.find_or_create_by(followee: other_user)
    end
  end

  def unfollow(other_user)
    follow = self.follows.find_by(followee: other_user)
    follow.destroy if follow
  end

  private
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
