class Classroom < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :educators
  validates :name, presence: true
end
