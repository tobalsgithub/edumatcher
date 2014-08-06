require 'rails_helper'

RSpec.describe Company, :type => :model do
  describe 'basic validation checks' do
    it { should have_many(:employment_links) }
    it { should have_many(:experts).through(:employment_links) }
    it { should validate_presence_of(:name) }
  end
end
