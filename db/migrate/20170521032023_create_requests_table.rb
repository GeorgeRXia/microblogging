class CreateRequestsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |i|
      i.integer :user_id
      i.integer :otheruser_id
    end
  end
end
