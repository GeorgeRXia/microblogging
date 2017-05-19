class CreateFavoriteblogsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :favoriteblogs do |t|
      t.integer :user_id
      t.string :blogcontent

    end
  end
end
