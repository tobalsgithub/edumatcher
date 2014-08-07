class Educator < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :school_districts
  has_and_belongs_to_many :schools

  has_many :educator_staffings, :dependent => :destroy
  has_many :classrooms, :through => :educator_staffings, :source => :staffable, :source_type => 'Classroom'

end
