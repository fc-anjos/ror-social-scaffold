module UserHelper
  def friendship_interaction(user)
    return nil if user == current_user

    new_friendship_path =
      friendships_path({ user_id: current_user.id, friend_id: user.id })

    class_html = 'profile-link'
    friendship = find_friendship(user)

    if current_user.friends.include?(user)
      render html: link_to(
        'Unfriend',
        "/friendships/destroypair/#{friendship.id}",
        method: :delete, class: class_html
      )
    elsif current_user.received_friends.include?(user)
      reject_friendship =
        link_to(
          'Reject Friendship',
          "/friendships/destroypair/#{friendship.id}",
          method: :delete, class: class_html
        )

      accept_friendship =
        link_to(
          'Accept Friendship',
          "/friendships/acceptpair/#{friendship.id}",
          method: :patch, class: class_html
        )

      render html: "#{accept_friendship} | #{reject_friendship} ".html_safe
    elsif current_user.requested_friends.include?(user)
      render html: link_to(
        'Drop invitation',
        "/friendships/destroypair/#{friendship.id}",
        method: :delete, class: class_html
      )
    else
      render html: link_to(
        'Invite friend',
        new_friendship_path,
        method: :post, class: class_html
      )
    end
  end

  def find_friendship(user)
    Friendship.find_by_user_id_and_friend_id(current_user.id, user.id)
  end
end
