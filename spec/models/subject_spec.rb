require 'rails_helper'

RSpec.describe Subject, :type => :model do
  describe 'basic validation checks' do
    it { should validate_presence_of(:name) }
    it { should have_and_belong_to_many(:classrooms) }
    it { should have_and_belong_to_many(:experts) }
  end

end
