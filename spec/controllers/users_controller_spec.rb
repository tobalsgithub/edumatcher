require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }

  before(:each) do
    user.confirm!
    sign_in user
  end

  describe 'setting up a new expert' do

    it 'creates a new expert model' do
      post :set_expert, format: :json
      expect(user.expert.class).to eq(Expert)
    end

    it 'returns an error if the user is already an expert' do
      expert = create(:expert)
      user.expert = expert
      user.save
      post :set_expert, format: :json
      expect(response.code).to eq("422")
    end
  end

  xdescribe 'setting up a new educator' do
    it 'creates a new educator model' do

    end

    it 'returns an error if the user is already an educator' do

    end
  end

end
