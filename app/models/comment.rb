class Comment < ApplicationRecord
  validates :content,
            presence: true,
            length: {
              maximum: 200,
              too_long: "can't be longer than 200 characters."
            }

  belongs_to :user
  belongs_to :post
end
