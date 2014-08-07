class SchoolDistrict < ActiveRecord::Base
  self.table_name = "school_districts"
  validates :name, presence: true

  has_many :schools
  has_many :educator_staffings, :as => :staffable, :dependent => :destroy
  has_many :educators, :through => :educator_staffings
end
