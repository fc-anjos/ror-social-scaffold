class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :friend_id, index: true, foreign_key: true
      t.string :status, default: 'requested'
      t.timestamps
    end

    add_foreign_key :friendships, :users, column: :user_id
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
