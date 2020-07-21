require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  let(:friend) { create :user }
  let!(:friendship) { create :friendship, user: user, friend: friend }

  context 'Requested and received friendships' do
    it 'User should be in received_friends' do
      expect(friend.received_friends).to include(user)
    end

    it 'Friend should be in requested_friends' do
      expect(user.requested_friends).to include(friend)
    end
  end

  context 'Confirmed friendships' do
    let!(:friendship) { create :friendship, user: user, friend: friend }

    it 'Friend should be in friends' do
      friendships_pair = Friendship.where(
        "(user_id = #{user.id} AND friend_id = #{friend.id})
      OR (user_id = #{friend.id} AND friend_id = #{user.id})"
      )

      friendships_pair.update_all(status: 'confirmed')
      expect(user.friends).to include(friend)
    end

    it 'User should be in friends' do
      friendships_pair = Friendship.where(
        "(user_id = #{user.id} AND friend_id = #{friend.id})
      OR (user_id = #{friend.id} AND friend_id = #{user.id})"
      )

      friendships_pair.update_all(status: 'confirmed')
      expect(friend.friends).to include(user)
    end
  end
end
