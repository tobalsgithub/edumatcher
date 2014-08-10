require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'basic validation checks' do
    it { should have_one(:educator) }
    it { should have_one(:expert) }
    it { should have_many(:ratings) }
    it { should validate_presence_of(:email) }
  end
end
