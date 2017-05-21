class CreateFriendsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |i|
      i.integer :user_id
      i.integer :friend_id

    end
  end
end
