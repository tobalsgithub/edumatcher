require 'rails_helper'

RSpec.describe Expert, :type => :model do
  describe 'basic validation checks' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:subjects) }
  end
end
