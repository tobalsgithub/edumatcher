class Company < ActiveRecord::Base
  has_and_belongs_to_many :experts
  validates :name, presence: true
end
