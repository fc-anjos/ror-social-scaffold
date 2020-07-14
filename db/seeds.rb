require "faker"

requester = User.create(
  {
    name: "julio",
    email: "julio@julio.com",
    password: 123_456,
    password_confirmation: 123_456,
  }
)

receiver = User.create(
  {
    name: "felipe",
    email: "felipe@felipe.com",
    password: 123_456,
    password_confirmation: 123_456,
  }
)

Friendship.create(requester_id: requester.id, receiver_id: receiver.id)

10.times do
  User.create(
    {
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: "123456",
      password_confirmation: "123456",
    }
  )
end

User.all.each do |user|
  friendable = User.all.ids
  3.times do
    friend_id = friendable.delete(rand(0..User.all.length))
    Friendship.create({ requester_id: user.id, receiver_id: friend_id })
  end
end
