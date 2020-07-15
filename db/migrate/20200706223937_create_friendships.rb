class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.index :requester
      t.index :receiver
      t.boolean :confirmed, default: false
      t.timestamps
    end

    add_foreign_key :friendships, :users, column: :requester_id
    add_foreign_key :friendships, :users, column: :receiver_id
  end
end
