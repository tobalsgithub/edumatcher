class Expert < ActiveRecord::Base
  belongs_to :user
  has_many :knowledge_links, :as => :knowledgeable, :dependent => :destroy
  has_many :subjects, :through => :knowledge_links
  has_many :employment_links, :dependent => :destroy
  has_many :companies, :through => :employment_links
  has_many :ratings, as: :ratable

  def as_json(options)
    super(:include => [{:knowledge_links => { :include => :subject }}, {:employment_links => { :include => :company }}, :user])
  end

end
