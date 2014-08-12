require 'rails_helper'

RSpec.describe Review, :type => :model do
  describe 'basic validation checks' do
    it { should belong_to(:user) }
    it { should belong_to(:reviewable) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:reviewable) }

  end

  describe 'as_json' do

    let(:review) { create(:review) }
    let(:expert) { create(:expert) }
    let(:user) { create(:user) }

    describe 'Review of an expert' do

      before(:each) do
        expert.user = user
        review.reviewable = expert
        @json = review.as_json({})
      end

      it 'should return the fullname of the user reviewed for an expert' do
        expect(@json).to have_key("reviewable_title")
        expect(@json["reviewable_title"]).to eq(user.fullname)
      end

    end

  end
end
