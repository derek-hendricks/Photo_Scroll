class AddDefaultAdminToAuthors < ActiveRecord::Migration
  def change
    change_column :authors, :admin,  :boolean, default: false 
  end
end
