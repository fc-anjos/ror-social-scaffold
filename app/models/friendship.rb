class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :reciprocate_friendship

  scope :requested, -> { where(status: 'requested') }
  scope :received, -> { where(status: 'received') }
  scope :confirmed, -> { where(status: 'confirmed') }

  private

  def uniqueness_of_mirrored_pairs
    if new_record? &&
       self.class.where(requester: requester, receiver: receiver).or(
         self.class.where(requester: receiver, receiver: requester)
       )
         .exists?
      errors.add(:base, 'This friendship exists')
    end
  end

  def prevent_self_association
    if requester == receiver
      errors.add(:base, 'Requester and receiver have to be different')
    end
  end

  def reciprocate_friendship
    new_friendship = Friendship.new({ user: friend, friend: user, status: 'received' })
    unless Friendship.where({ user: friend, friend: user }).exists?
      new_friendship.save
    end
  end
end
