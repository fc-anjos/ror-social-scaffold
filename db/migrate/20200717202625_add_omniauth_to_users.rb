class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :priveder, :string
    add_column :users, :uid, :string
  end
end
