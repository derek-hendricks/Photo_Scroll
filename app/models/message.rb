class Message < ActiveRecord::Base
	mount_uploader :picture, PictureUploader
	validate  :picture_size
	
	has_and_belongs_to_many :favourites, :join_table => "favourites", :class_name => "Author", :association_foreign_key => "fav_author_id"
	belongs_to :author
	validates :contents, :length => { :minimum => 3, :maximum => 140 }

	scope :followed_by, -> id {where("author_id IN (SELECT follow_id FROM author_follows WHERE author_id = ?)", id)}
    default_scope { order('created_at DESC') }
	
	def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
	end
	
end


