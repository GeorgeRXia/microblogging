class AddReblogidTable < ActiveRecord::Migration[5.1]
  def change
    change_table :blogs do |i|
      i.integer :otheruser_id

    end
  end
end
