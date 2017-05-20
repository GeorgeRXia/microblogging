class AddTitleToBlogsTable < ActiveRecord::Migration[5.1]
  def change
  	change_table :blogs do |t|
  		t.title :title
  	end
  end
end
