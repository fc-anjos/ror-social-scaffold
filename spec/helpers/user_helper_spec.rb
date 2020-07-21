require 'rails_helper'
RSpec.describe UserHelper, type: :helper do
  let(:current_user) { create :user }
  let(:other_user) { create :user }
  let!(:friendship) { create :friendship, user: current_user, friend: other_user }

  context '#find_friendships' do
    it 'Finds the correct friendship passing the friend' do
      found_friendship = find_friendship(other_user)
      expect(found_friendship).to eql(friendship)
    end
  end

  context '#friendship_interaction' do
    it 'returns nil if the user is the current_user' do
      expect(friendship_interaction(current_user)).to eql(nil)
    end
  end

  context 'Current user has received an invitation' do
    let!(:friendship) { create :friendship, user: current_user, friend: other_user }
    it 'Returns drop invitation message' do
      interaction = friendship_interaction(other_user)
      expect(interaction).to include('Drop invitation')
      expect(interaction).to include('delete')
    end
  end

  context 'Current user has sent an invitation' do
    let!(:friendship) { create :friendship, user: other_user, friend: current_user }
    it 'Returns Accpet invitation message' do
      interaction = friendship_interaction(other_user)
      expect(interaction).to include('Accept Friendship')
      expect(interaction).to include('patch')
      expect(interaction).to include('Reject Friendship')
      expect(interaction).to include('delete')
    end
  end

  context 'Current user and friend are friends' do
    let!(:friendship) { create :friendship, user: current_user, friend: other_user }
    it 'Returns unfriend message' do
      friendships_pair = Friendship.where(
        "(user_id = #{current_user.id} AND friend_id = #{other_user.id})
      OR (user_id = #{other_user.id} AND friend_id = #{current_user.id})"
      )

      friendships_pair.update_all(status: 'confirmed')

      interaction = friendship_interaction(other_user)

      expect(interaction).to include('Unfriend')
      expect(interaction).to include('delete')
    end
  end

  context 'Current user and friend are not related' do
    it 'Returns unfriend message' do
      friendship.destroy
      interaction = friendship_interaction(other_user)
      expect(interaction).to include('Invite friend')
      expect(interaction).to include('post')
    end
  end
end
