require 'rails_helper'

RSpec.describe SchoolDistrictsController, :type => :controller do

  let(:valid_attributes) { create(:school_district).attributes }

  let(:invalid_attributes) { {
    'name' => ''
  } }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:educator) { create(:educator) }
  let(:school) { create(:school) }
  let(:school_district) { create(:school_district) }

  before(:each) do
    user.confirm!
    user.educator = educator
    user.save
    sign_in user
  end

  describe 'POST create' do

    let(:school_district) { build(:school_district) }

    describe 'with valid attributes' do
      before(:each) do
        post :create, school_district: school_district, format: :json
      end

      it "creates a new SchoolDistrict" do
        expect {
          post :create, school_district: school_district, format: :json
        }.to change(SchoolDistrict, :count).by(1)
      end

      it "returns the created school_district" do
        expect(json).to have_key('id')
        expect(json).to have_key('name')
      end

      it { should respond_with 201 }
    end

    describe 'with invalid attributes' do

      describe 'without a name' do
        before(:each) do
          school_district.name = nil
          post :create, school_district: school_district, format: :json
        end

        it 'does not create a new SchoolDistrict' do
          expect{
            post :create, school_district: school_district, format: :json
          }.to_not change(SchoolDistrict, :count)
        end

        it 'returns an error' do
          expect(json).to have_key('errors')
        end

        it { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'PUT update' do

    describe 'with valid attributes' do

      before(:each) do
        school_district.name = 'New name'
        school_district.website = 'http://www.newwebsite.com'
        put :update, id: school_district.to_param, school_district: school_district, format: :json
      end

      it 'updates the school_district' do
        school_district.reload
        expect(school_district.name).to eq('New name')
        expect(school_district.website).to eq('http://www.newwebsite.com')
      end

      it 'returns the school_district as json' do
        expect(json).to have_key('name')
      end
    end

    describe 'with invalid attriutes' do

      describe 'without a name' do
        before(:each) do
          school_district.name = nil
          put :update, id: school_district.to_param, school_district: school_district, format: :json
        end

        it 'does not update the school_district' do
          school_district.reload
          expect(school_district.name).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'GET show' do

    before(:each) do
      get :show, id: school_district.to_param, format: :json
    end

    it 'should return the school_district as json' do
      expect(json).to have_key('name')
    end

    it { should respond_with :ok }
  end
end
