class Subject < ActiveRecord::Base
  has_many :knowledge_links, :dependent => :destroy
  has_many :experts, :through => :knowledge_links, :source => :knowledgeable, :source_type => 'Expert'
  has_many :classrooms, :through => :knowledge_links, :source => :knowledgeable, :source_type => 'Classroom'
  validates :name, presence: true
end
