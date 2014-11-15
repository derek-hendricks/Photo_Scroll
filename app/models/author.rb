class Author < ActiveRecord::Base

	before_save { self.email = email.downcase }

	validates :username, uniqueness: true, presence: true, length: { maximum: 15 }
	validates :full_name,  presence: true, length: { maximum: 50 }
    validates :password, presence: true, length: { minimum: 6, maximum: 30 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
    has_secure_password
   
	has_and_belongs_to_many :favourites, :join_table => "favourites", :class_name => "Message", :foreign_key => "fav_author_id"
	has_many :author_follows
	has_many :follows, :through => :author_follows
	has_many :follow_authors, :class_name => "AuthorFollow", :foreign_key => :follow_id # 2
	has_many :followers, :through => :follow_authors, :source => :author # 3
	has_many :images

	def followed_messages 
		Message.followed_by(self.id)
	end
end

# each author can have many follows they are following. relationship follows represents the authors an author is
# following. the follows relationship is from an Author to the list of Authors they follow

#2 each author can have several rows in author_follows that represents people who follow them

#3 use through relationship to pass through AuthorFollow model, going straight to list of followers