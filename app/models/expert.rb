class Expert < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :companies

  def as_json(options)
    super(:include => [:subjects, :user])
  end

end
