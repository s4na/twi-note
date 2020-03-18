# frozen_string_literal: true

module UsersHelper
  def follow_or_unfollow(other_user)
    unless other_user == current_user
      follow = current_user.follows.find_by(followee: other_user)

      if follow
        button_to follow, method: :delete, class: "a-button is-primary add-padding" do
          # content_tag(:div, "person_outline", class: "i material-icons") + "フォロー中"
          "フォロー中"
        end

        # i.material-icons.global-nav-item__image
        #   | people
      else
        button_to [:follows, followee_id: other_user.id], class: "a-button is-primary add-padding" do
          # content_tag(:div, "person_add", class: "i material-icons") + "フォローする"
          "フォローする"
        end
      end
    end
  end
end
