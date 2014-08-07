class School < ActiveRecord::Base
  validates_presence_of :school_district
  validates :name, presence: true
  belongs_to :school_district
  has_many :classrooms
  has_many :educator_staffings, :as => :staffable, :dependent => :destroy
  has_many :educators, :through => :educator_staffings

  def as_json(options)
    super(:include => [:school_district])
  end
end
