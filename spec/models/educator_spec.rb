require 'rails_helper'

RSpec.describe Educator, :type => :model do

  describe 'basic validation checks' do
    it { should have_and_belong_to_many(:classrooms) }
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:schools) }
    it { should have_and_belong_to_many(:school_districts) }
  end
end
