class Classroom < ActiveRecord::Base
  belongs_to :school
  has_and_belongs_to_many :educators
  validates :name, presence: true
  validates_presence_of :school
  has_and_belongs_to_many :subjects

  def as_json(options)
    super(:include => [:school, :subjects])
  end
end
