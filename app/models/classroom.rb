class Classroom < ActiveRecord::Base
  validates :name, presence: true
  validates_presence_of :school

  belongs_to :school
  has_many :educator_staffings, :as => :staffable, :dependent => :destroy
  has_many :educators, :through => :educator_staffings
  has_many :knowledge_links, :as => :knowledgeable, :dependent => :destroy
  has_many :subjects, :through => :knowledge_links
  belongs_to :grade_level

  def as_json(options)
    super(:include => [:school, {:knowledge_links => { :include => :subject }},{ :educator_staffings => { :include => :educator}}])
  end
end
