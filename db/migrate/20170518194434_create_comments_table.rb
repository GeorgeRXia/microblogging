class CreateCommentsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |i|
      i.integer :user_id
      i.integer :blog_id
      i.string :acomment
      i.timestamps null: false

    end

  end
end
