require 'rails_helper'

RSpec.describe Rating, :type => :model do
  describe 'basic validation checks' do
    it { should belong_to(:user) }
    it { should belong_to(:ratable) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:ratable) }

  end
end
