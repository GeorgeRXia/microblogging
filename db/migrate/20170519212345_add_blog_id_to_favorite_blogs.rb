class AddBlogIdToFavoriteBlogs < ActiveRecord::Migration[5.1]
  def change
    change_table :favoriteblogs do |t|
        t.integer :blog_id
    end
  end
end
