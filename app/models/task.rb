class Task < ActiveRecord::Base
  validates :name, :description, :duration, :presence => true
  validates :name, :uniqueness => true
  validates_numericality_of :duration, {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 240}
end
