require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create :user }
  let(:friend) { create :user }
  let!(:friendship) do
    create(:friendship, requester: user, receiver: friend, confirmed: true)
  end

  context '::reciprocate_friendship' do
    it 'appends user to friend friends' do
      expect(friend.friends).to include(user)
    end
  end

  context '::destroy_frienship' do
    it 'removes user to friend friends' do
      friendship.destroy
      expect(friend.friends).not_to include(user)
    end
  end

  context '::uniqueness_of_mirrored_pairs' do
    let!(:friendship) { create :friendship, requester: user, receiver: friend }
    let!(:friendship2) { build :friendship, requester: friend, receiver: user }
    it 'validates that if a user has sent an invitation to other user, this last one cannot invite that same user' do
      expect(friendship2).not_to be_valid
    end
  end

  context '::prevent_self_association' do
    let!(:friendship) { build :friendship, requester: user, receiver: user }
    it 'validates that a user cannot be friends with himself' do
      expect(friendship).not_to be_valid
    end
  end
end
