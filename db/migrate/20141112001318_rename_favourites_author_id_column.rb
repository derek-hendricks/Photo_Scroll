class RenameFavouritesAuthorIdColumn < ActiveRecord::Migration
  def change
  	rename_column :favourites, :author_id, :fav_author_id
  end
end
