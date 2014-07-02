class SchoolDistrict < ActiveRecord::Base
  self.table_name = "school_districts"
  has_many :schools
  has_and_belongs_to_many :educators
  validates :name, presence: true
end
