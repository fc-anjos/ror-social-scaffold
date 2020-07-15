class Friendship < ApplicationRecord
  belongs_to :receiver, class_name: 'User'
  belongs_to :requester, class_name: 'User'

  validate :uniqueness_of_mirrored_pairs
  validate :prevent_self_association

  scope :not_confirmed, -> { where(confirmed: false) }
  scope :confirmed, -> { where(confirmed: true) }

  private

  def uniqueness_of_mirrored_pairs
    if self.class.where(requester_id: requester.id, receiver_id: receiver.id)
        .or(self.class.where(requester_id: receiver.id, receiver_id: requester.id))
        .exists?
      errors.add(:base, 'This friendship exists')
    end
  end

  def prevent_self_association
    errors.add(:base, 'Requester and receiver have to be different') if requester_id == receiver_id
  end
end
