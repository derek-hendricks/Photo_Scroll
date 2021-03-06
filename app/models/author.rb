class Author < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :username, uniqueness: true, presence: true, length: { maximum: 30 }
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  
  acts_as_messageable
   
  has_and_belongs_to_many :favourites, :join_table => "favourites", :class_name => "Message", :foreign_key => "fav_author_id"
  has_and_belongs_to_many :authors_users, :join_table => "authors_users", :class_name => "User", :association_foreign_key => "join_user_id"
  has_many :author_follows
  has_many :follows, :through => :author_follows
  has_many :follow_authors, :class_name => "AuthorFollow", :foreign_key => :follow_id 
  has_many :followers, :through => :follow_authors, :source => :author 


  def name
    return downcase_email
  end
  
  def mailboxer_email(object)
    return downcase_email
  end
  
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
  
 # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    AuthorMailer.account_activation(self).deliver
  end
  
  def create_reset_digest
    self.reset_token = Author.new_token
    update_attribute(:reset_digest,  Author.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    AuthorMailer.password_reset(self).deliver
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private 
  
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = Author.new_token
      self.activation_digest = Author.digest(activation_token)
    end
  
end

