class EmploymentLink < ActiveRecord::Base
  belongs_to :company
  belongs_to :expert
  validates_presence_of :company
  validates_presence_of :expert

  def as_json(options)
    super(:include => [:company, :expert])
  end
end
