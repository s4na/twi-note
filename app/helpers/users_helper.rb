# frozen_string_literal: true

module UsersHelper
  def follow_or_unfollow(other_user)
    unless other_user == current_user
      follow = current_user.follows.find_by(followee: other_user)

      if follow
        button_to follow, method: :delete, class: "a-button is-primary add-padding" do
          "フォロー中"
        end

      else
        button_to [:follows, followee_id: other_user.id], class: "a-button is-primary add-padding" do
          "フォローする"
        end
      end
    end
  end
end
