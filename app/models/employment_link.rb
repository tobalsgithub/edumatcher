class EmploymentLink < ActiveRecord::Base
  belongs_to :company
  belongs_to :expert

  def as_json(options)
    super(:include => [:company])
  end
end
