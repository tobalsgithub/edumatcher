class School < ActiveRecord::Base
  belongs_to :SchoolDistrict
  has_many :classrooms
  has_and_belongs_to_many :educators
  validates :name, presence: true
end
