class EducatorStaffing < ActiveRecord::Base
  belongs_to :educator
  belongs_to :staffable, :polymorphic => true
end
