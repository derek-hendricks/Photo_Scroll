class CreateAuthorsUsersTable < ActiveRecord::Migration
  def change
    create_table :authors_users, :id => false do |t|
      t.integer :join_user_id 
    	t.integer :author_id
    end
  end
end
