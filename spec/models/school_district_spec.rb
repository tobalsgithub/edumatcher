require 'rails_helper'

RSpec.describe SchoolDistrict, :type => :model do

  describe 'basic validation checks' do
    it { should have_many(:schools) }
    it { should validate_presence_of(:name) }
    it { should have_and_belong_to_many(:educators) }
  end
end
