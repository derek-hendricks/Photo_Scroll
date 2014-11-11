class Message < ActiveRecord::Base
	has_and_belongs_to_many :favourites, :join_table => "favourites", :class_name => "Author"
	belongs_to :author
	validates :contents, :length => { :minimum => 3, :maximum => 140 }
end
