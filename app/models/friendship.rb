class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # validate :uniqueness_of_mirrored_pairs, on: :create
  # validate :prevent_self_association

  scope :requested, -> { where(status: 'requested') }
  scope :received, -> { where(status: 'received') }
  scope :confirmed, -> { where(status: 'confirmed') }

  private

  def uniqueness_of_mirrored_pairs
    if new_record? && self.class.where(requester: requester, receiver: receiver)
        .or(self.class.where(requester: receiver, receiver: requester))
        .exists?
      errors.add(:base, 'This friendship exists')
    end
  end

  def prevent_self_association
    errors.add(:base, 'Requester and receiver have to be different') if requester == receiver
  end
end
