class Message < ActiveRecord::Base
	belongs_to :author
	validates :contents, :length => { :minimum => 3, :maximum => 140 }
end
