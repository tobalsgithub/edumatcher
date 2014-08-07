require 'rails_helper'

RSpec.describe SchoolDistrict, :type => :model do
  it { should have_many(:schools) }
  it { should validate_presence_of(:name) }
  it { should have_many(:educator_staffings) }
  it { should have_many(:educators).through(:educator_staffings) }
end
