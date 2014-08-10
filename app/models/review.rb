class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates_presence_of :user, presence: true
  validates_presence_of :reviewable, presence: true
end
