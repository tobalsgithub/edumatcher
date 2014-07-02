class Educator < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :school_districts
  has_and_belongs_to_many :classrooms
  has_and_belongs_to_many :schools

end
