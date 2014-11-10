class Image < ActiveRecord::Base
  belongs_to :user
  validates(:caption, :description, :url, :rating, :presence => true)
  validates(:caption, :url, :uniqueness => true)
  validates_numericality_of :rating, {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
end
