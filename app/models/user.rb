class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: %i[github]

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :requested_friendships,
           -> { not_confirmed },
           class_name: "Friendship", foreign_key: "requester_id"

  has_many :received_friendships,
           -> { not_confirmed },
           class_name: "Friendship", foreign_key: "receiver_id"

  has_many :received_friends,
           class_name: "User",
           through: :received_friendships,
           source: :requester

  has_many :requested_friends,
           class_name: "User",
           through: :requested_friendships,
           source: :receiver

  has_many :confirmed_friendships,
           lambda { |object|
             unscope(where: :user_id).where(
               "(requester_id = ? OR receiver_id = ?) AND (confirmed =? )",
               object.id,
               object.id,
               true
             )
           },
           class_name: "Friendship"

  def friends
    User.where(
      id: confirmed_friendships.pluck(:requester_id) +
          confirmed_friendships.pluck(:receiver_id),
    ) -
      User.where("id =?", id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.ifo.name
    end
  end
end
