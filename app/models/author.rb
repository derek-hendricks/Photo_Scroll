class Author < ActiveRecord::Base
	has_and_belongs_to_many :favourites, :join_table => "favourites", :class_name => "Message", :foreign_key => "fav_author_id"
	has_many :author_follows
	has_many :follows, :through => :author_follows
	has_many :follow_authors, :class_name => "AuthorFollow", :foreign_key => :follow_id # 2
	has_many :followers, :through => :follow_authors, :source => :author # 3
	has_many :images
	validates :username, :uniqueness => true
	validates :username, :password, :full_name, :presence => true

	def followed_messages 
		Message.followed_by(self.id)
	end
end

# each author can have many follows they are following. relationship follows represents the authors an author is
# following. the follows relationship is from an Author to the list of Authors they follow

#2 each author can have several rows in author_follows that represents people who follow them

#3 use through relationship to pass through AuthorFollow model, going straight to list of followers