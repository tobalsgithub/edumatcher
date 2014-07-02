require 'rails_helper'

RSpec.describe School, :type => :model do

  describe 'basic validation checks' do
    it { should belong_to(:school_district) }
    it { should have_many(:classrooms) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:school_district)}
    it { should have_and_belong_to_many(:educators) }
  end
end
