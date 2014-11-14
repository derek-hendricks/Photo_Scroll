class ChangeImageColumn < ActiveRecord::Migration
  def change
  	rename_column :images, :user_id, :author_id
  end
end
