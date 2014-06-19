require 'rails_helper'

RSpec.describe School, :type => :model do

  describe 'basic validation checks' do
    it { should belong_to(:SchoolDistrict) }
    it { should have_many(:classrooms) }
    it { should validate_presence_of(:name) }
    it { should have_and_belong_to_many(:educators) }
  end
end
