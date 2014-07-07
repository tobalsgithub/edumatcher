class GradeLevel < ActiveRecord::Base
  has_many :classrooms
  validates :name, presence: true
end
