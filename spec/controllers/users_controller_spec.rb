require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }

  before(:each) do
    user.confirm!
    sign_in user
  end

  describe 'GET submitted_reviews' do
    before(:each) do
      user.reviews.destroy_all
      user.reviews << create(:review)
      user.reviews << create(:review)
      user.reviews << create(:review)

      @user2 = create(:user)
      @user2.reviews.destroy_all
      @user2.reviews << create(:review)
      @user2.reviews << create(:review)
    end

    it 'should return the submitted reviews by a user' do
      get :submitted_reviews, id: user.to_param, format: :json
      expect(json.size).to be 3
    end

    it 'should return the submitted reviews by any user' do
      get :submitted_reviews, id: @user2.to_param, format: :json
      expect(json.size).to be 2
    end

  end

  describe 'setting up a new expert' do

    it 'creates a new expert model' do
      post :set_expert, id: user.to_param, format: :json
      expect(user.expert.id).to be > 0
    end

    it 'returns an error if the user is already an expert' do
      expert = create(:expert)
      user.expert = expert
      user.save
      post :set_expert, id: user.to_param, format: :json
      expect(response.code).to eq("422")
    end
  end

  describe 'setting up a new educator' do
    it 'creates a new educator model' do
      post :set_educator, id: user.to_param, format: :json
      expect(user.educator.id).to be > 0
    end

    it 'returns an error if the user is already an educator' do
      educator = create(:educator)
      user.educator= educator
      user.save
      post :set_educator, id: user.to_param, format: :json
      expect(response.code).to eq("422")
    end
  end

end
