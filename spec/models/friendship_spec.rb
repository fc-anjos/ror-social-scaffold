require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create :user }
  let(:friend) { create :user }
  let!(:friendship) { create(:friendship, user: user, friend: friend) }

  context '::reciprocate_friendship' do
    it 'appends user to friend friends' do
      expect(friend.received_friends).to include(user)
    end
  end

  context '::destroy_frienship' do
    it 'removes user to friend friends' do
      friendship.destroy
      expect(friend.friends).not_to include(user)
    end
  end

  context '::prevent_self_association' do
    let!(:friendship) { build :friendship, user: user, friend: user }
    it 'validates that a user cannot be friends with himself' do
      expect(friendship).not_to be_valid
    end
  end
end
