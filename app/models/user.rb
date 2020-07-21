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
           -> { requested },
           class_name: 'Friendship'

  has_many :received_friendships,
           -> { received },
           class_name: 'Friendship'

  has_many :confirmed_friendships,
           -> { confirmed },
           class_name: 'Friendship'

  has_many :received_friends,
           class_name: "User",
           through: :received_friendships,
           source: :friend

  has_many :requested_friends,
           class_name: "User",
           through: :requested_friendships,
           source: :friend


  has_many :friends,
           class_name: 'User',
           through: :confirmed_friendships,
           source: :friend

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  def timeline_posts
    ids = friends.pluck(:id) << id
    Post.all.ordered_by_most_recent.where(user_id: ids).includes(:user)
  end
end
