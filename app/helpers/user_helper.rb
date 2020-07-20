module UserHelper
  def friendship_interaction(user)
    return nil if user == current_user

    new_friendship_path =
      friendships_path({ user: current_user, friend: user })
    class_html = 'profile-link'

    if current_user.friends.include?(user)
      render html: link_to(
        'Unfriend',
        find_friendship(user),
        method: :delete, class: class_html
      )
    elsif current_user.received_friends.include?(user)
      id = find_friendship(user, true)

      reject_friendship =
        link_to(
          'Reject Friendship',
          find_friendship(user),
          method: :delete, class: class_html
        )

      accept_friendship =
        link_to(
          'Accept Friendship',
          friendship_path({ id: id, confirmed: true }),
          method: :put, class: class_html
        )

      render html: "#{accept_friendship} | #{reject_friendship} ".html_safe
    elsif current_user.requested_friends.include?(user)
      render html: link_to(
        'Drop invitation',
        find_friendship(user),
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
      [Friendship.find_by_user_id_and_friend_id(current_user.id, user.id), Friendship.find_by_friend_id_and_user_id(current_user.id, user.id)]
  end
end
