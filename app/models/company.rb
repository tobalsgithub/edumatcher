class Company < ActiveRecord::Base
  has_many :employment_links
  has_many :experts, :through => :employment_links
  validates :name, presence: true
end
