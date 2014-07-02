class School < ActiveRecord::Base
  belongs_to :school_district
  has_many :classrooms
  has_and_belongs_to_many :educators
  validates_presence_of :school_district
  validates :name, presence: true

  def as_json(options)
    super(:include => [:school_district])
  end
end
