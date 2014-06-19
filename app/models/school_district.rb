class SchoolDistrict < ActiveRecord::Base
  validates :name, presence: true
  has_many :schools
  has_and_belongs_to_many :educators
end
