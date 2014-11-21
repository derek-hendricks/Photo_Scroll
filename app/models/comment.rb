class Comment < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :body, presence: true, length: {maximum: 2000}
  has_and_belongs_to_many :votes, :join_table => "votes", :class_name => "User", :association_foreign_key => "vote_user_id"
 

end
