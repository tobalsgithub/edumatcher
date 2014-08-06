class EmploymentLink < ActiveRecord::Base
  belongs_to :company
  belongs_to :expert
end
