class AddIndexToAuthorsUsername < ActiveRecord::Migration
  def change
    add_index :authors, :username, unique: true
  end
end
