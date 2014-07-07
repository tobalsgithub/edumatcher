require 'rails_helper'

RSpec.describe GradeLevelsController, :type => :controller do

  let(:valid_attributes) { create(:grade_level).attributes }

  let(:invalid_attributes) { {
    'name' => ''
  } }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:grade_level) { create(:grade_level) }

  before(:each) do
    user.confirm!
    user.save
    sign_in user
  end

  describe 'GET index' do

    before(:each) do
      create(:grade_level)
      get :index, format: :json
    end

    it 'should return all the grade levels' do
      expect(json.size).to_not be(0)
      expect(json[0]).to have_key('name')
    end

    it { should respond_with :success }
  end
end
