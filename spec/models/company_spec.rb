require 'rails_helper'

RSpec.describe Company, :type => :model do
  describe 'basic validation checks' do
    it { should have_and_belong_to_many(:experts) }
    it { should validate_presence_of(:name) }
  end
end
