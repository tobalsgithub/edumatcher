class Expert < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :subjects
  has_many :employment_links
  has_many :companies, :through => :employment_links

  def as_json(options)
    super(:include => [:subjects, :user])
  end

end
