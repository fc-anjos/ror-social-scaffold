FactoryBot.define do
  factory :post, class: Post do
    content { Faker::Quotes::Shakespeare.romeo_and_juliet_quote }
  end
end
