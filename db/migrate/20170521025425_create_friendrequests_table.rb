class CreateFriendrequestsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :friendrequests do |t|
      t.integer :user_id
      t.integer :otheruser_id
    end
  end
end
