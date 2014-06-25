require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'basic validation checks' do
    it { should have_one(:educator) }
    it { should have_one(:expert) }
    it { should validate_presence_of(:email) }
  end

  describe 'creating a user' do
    let(:user) { create(:user) }
    it 'should create a valid user' do
      expect(user.valid?).to be(true)
    end
  end
end
