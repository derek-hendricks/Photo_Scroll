class User < ActiveRecord::Base
  has_many :comments, dependent: :delete_all
  has_and_belongs_to_many :authors_users, :join_table => "authors_users", :class_name => "Author", :foreign_key => "join_user_id"
  has_and_belongs_to_many :votes, :join_table => "votes", :class_name => "Comment", :foreign_key => "vote_user_id"

  def feed
    Comment.where("user_id = ?", id)
  end

  class << self
    def from_omniauth(auth)
      provider = auth.provider
      uid = auth.uid
      info = auth.info.symbolize_keys!
      user = User.find_or_initialize_by(uid: uid, provider: provider)
      user.name = info.name
      user.avatar_url = info.image
      user.profile_url = info.urls.send(provider.capitalize.to_sym)
      user.save!
      user
    end

  end
end
