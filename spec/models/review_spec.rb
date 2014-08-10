require 'rails_helper'

RSpec.describe Review, :type => :model do
  describe 'basic validation checks' do
    it { should belong_to(:user) }
    it { should belong_to(:reviewable) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:reviewable) }

  end
end
