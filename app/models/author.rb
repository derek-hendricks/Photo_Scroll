class Author < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :username, uniqueness: true, presence: true, length: { maximum: 30 }
	validates :full_name,  presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
   
	has_and_belongs_to_many :favourites, :join_table => "favourites", :class_name => "Message", :foreign_key => "fav_author_id"
	has_many :author_follows
	has_many :follows, :through => :author_follows
	has_many :follow_authors, :class_name => "AuthorFollow", :foreign_key => :follow_id 
	has_many :followers, :through => :follow_authors, :source => :author 
	has_many :images

	def followed_messages 
		Message.followed_by(self.id)
	end
	
	def Author.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end
  	
 	def Author.new_token
    	SecureRandom.urlsafe_base64
  	end
  	
 	def remember
		self.remember_token = Author.new_token
    update_attribute(:remember_digest, Author.digest(remember_token))
	end
  
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end

