class Author < ActiveRecord::Base
	has_and_belongs_to_many :favourites, :join_table => "favourites", :class_name => "Message", :foreign_key => "fav_author_id"
	validates :username, :uniqueness => true
	validates :username, :password, :full_name, :presence => true
end
