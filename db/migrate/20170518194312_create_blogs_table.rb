class CreateBlogsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |i|
      i.integer :user_id
      i.string :content
      i.timestamps null: false
    end
  end
end
