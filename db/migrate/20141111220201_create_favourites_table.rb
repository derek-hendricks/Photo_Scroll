class CreateFavouritesTable < ActiveRecord::Migration
  def change
    create_table :favourites, :id => false do |t|
    	t.integer :author_id 
    	t.integer :message_id
    end
  end
end
