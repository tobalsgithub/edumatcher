class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :ratable, polymorphic: true

  validates_presence_of :user, presence: true
  validates_presence_of :ratable, presence: true
end
