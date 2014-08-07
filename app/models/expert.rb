class Expert < ActiveRecord::Base
  belongs_to :user
  has_many :knowledge_links, :as => :knowledgeable, :dependent => :destroy
  has_many :subjects, :through => :knowledge_links
  has_many :employment_links
  has_many :companies, :through => :employment_links

  def as_json(options)
    super(:include => [:subjects, :user])
  end

end
