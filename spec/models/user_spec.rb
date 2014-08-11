require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'basic validation checks' do
    it { should have_one(:educator) }
    it { should have_one(:expert) }
    it { should have_many(:reviews) }
    it { should validate_presence_of(:email) }
  end

  describe 'Method: is_expert?' do

    it 'should return true for an expert' do
      user = create(:user)
      user.expert = create(:expert)
      user.educator = nil
      expect(user.is_expert?).to eq true
    end

    it 'should return false for an educator' do
      user = create(:user)
      user.expert = nil
      user.educator = create(:educator)
      expect(user.is_expert?).to eq false
    end

  end

  describe 'Method: is_educator?' do
    it 'should return false for an expert' do
      user = create(:user)
      user.expert = create(:expert)
      user.educator = nil
      expect(user.is_educator?).to eq false
    end

    it 'should return true for an educator' do
      user = create(:user)
      user.expert = nil
      user.educator = create(:educator)
      expect(user.is_educator?).to eq true
    end
  end

  describe 'as_json' do

    describe 'for an expert' do
      before(:each) do
        @user = create(:user)
        @user.expert = create(:expert)
        @user.educator = nil
        @json = @user.as_json({})
      end


      it 'should have key is_expert? == true for an expert' do
        expect(@json).to have_key("is_expert")
        expect(@json["is_expert"]).to eq(true)
      end

      it 'should have key is_educator? == false for an expert' do
        expect(@json).to have_key("is_expert")
        expect(@json["is_educator"]).to eq(false)
      end

    end

    describe 'for an educator' do
      before(:each) do
        @user = create(:user)
        @user.expert = nil
        @user.educator = create(:educator)
        @json = @user.as_json({})
      end

      it 'should have key is_expert? == false for an educator' do
        expect(@json).to have_key("is_expert")
        expect(@json["is_expert"]).to eq(false)
      end

      it 'should have key is_educator? == true for an educator' do
        expect(@json).to have_key("is_expert")
        expect(@json["is_educator"]).to eq(true)
      end

    end
  end
end
