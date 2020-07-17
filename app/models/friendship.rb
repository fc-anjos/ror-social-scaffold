class Friendship < ApplicationRecord
  belongs_to :receiver, class_name: "User"
  belongs_to :requester, class_name: "User"

  validate :uniqueness_of_mirrored_pairs
  validate :prevent_self_association

  scope :not_confirmed, -> { where(confirmed: false) }
  scope :confirmed, -> { where(confirmed: true) }

  private

  def uniqueness_of_mirrored_pairs
    if self.class.where(requester: requester, receiver: receiver, confirmed: true)
      .or(self.class.where(requester: receiver, receiver: requester, confirmed: false))
      .exists?
      errors.add(:base, "This friendship exists")
    end
  end

  def prevent_self_association
    errors.add(:base, "Requester and receiver have to be different") if requester == receiver
  end
end
