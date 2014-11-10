class Task < ActiveRecord::Base

  belongs_to :user

  validates :name, :description, :duration, :presence => true
  validates :name, :uniqueness => true
  validates_numericality_of :duration, {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 240}
  validates_numericality_of :priority, {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 10}
  validate :due_in_future, :on=>:create

  scope :search_by_name_and_description, -> search { where("name like ? OR description like ?", "%#{search}%", "%#{search}%") }
  scope :complete_is, -> status { where(complete: status) }

  def due_in_future
    if due_date < Date.today then
      errors.add(:due_date, "cannot be in the past")
    end
  end
end
