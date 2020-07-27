require 'faker'

user = User.create(
  {
    name: 'julio',
    email: 'julio@julio.com',
    password: 123_456,
    password_confirmation: 123_456
  }
)

requested_friend = User.create(
  {
    name: 'felipe',
    email: 'felipe@felipe.com',
    password: 123_456,
    password_confirmation: 123_456
  }
)

# true_friend = User.create(
#   {
#     name: "Real",
#     email: "so@real.com",
#     password: 123_456,
#     password_confirmation: 123_456,
#   }
# )

# received_friend = User.create(
#   {
#     name: "john",
#     email: "john@john.com",
#     password: 123_456,
#     password_confirmation: 123_456,
#   }
# )

# Friendship.create({ user: user, friend: true_friend, status: 'confirmed' })
# Friendship.create({ user: user, friend: requested_friend, status: 'requested' })
# Friendship.create({ user: user, friend: received_friend, status: 'received' })

30.times do
  User.create(
    {
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: '123456',
      password_confirmation: '123456'
    }
  )
end

User.all.each do |user|
  friendable = User.all.ids
  rand(8..12).times do
    friend_id = friendable.delete(rand(0..User.all.length))
    status = %w[confirmed requested received].sample
    Friendship.create({ user_id: user.id, friend_id: friend_id, status: status })
    post = Post.create(user: user, content: Faker::Quotes::Shakespeare.romeo_and_juliet_quote)
  end
end

Post.all.each do |post|
  rand(1..5).times do
    Like.create(user_id: rand(0..User.all.length), post: post)
    Comment.create(user_id: rand(0..User.all.length), post: post, content: Faker::Quotes::Shakespeare.romeo_and_juliet_quote)
  end
end
