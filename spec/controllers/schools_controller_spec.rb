require 'rails_helper'

RSpec.describe SchoolsController, :type => :controller do

  let(:valid_attributes) { create(:school).attributes }

  let(:invalid_attributes) { {
    'name' => ''
  } }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:educator) { create(:educator) }
  let(:classroom) { create(:classroom) }
  let(:school) { create(:school) }
  let(:school_district) { create(:school_district)}

  before(:each) do
    user.confirm!
    user.educator = educator
    user.save
    sign_in user
  end

  describe 'POST create' do

    let(:school) { build(:school) }

    describe 'with valid attributes' do
      before(:each) do
        #school.school_district = school_district
        post :create, school: school, format: :json
      end

      it "creates a new School" do
        expect {
          post :create, school: school, format: :json
        }.to change(School, :count).by(1)
      end

      it "returns the created school" do
        expect(json).to have_key('id')
        expect(json).to have_key('name')
      end

      it { should respond_with 201 }
    end

    describe 'with invalid attributes' do

      describe 'without a school' do

        before(:each) do
          school.school_district = nil
          post :create, school: school, format: :json
        end

        it 'does not create a new School' do
          expect{
            post :create, school: school, format: :json
          }.to_not change(School, :count)
        end

        it 'returns an error' do
          expect(json).to have_key('errors')
        end

        it { should respond_with :unprocessable_entity}
      end

      describe 'without a name' do
        before(:each) do
          school.name = nil
          post :create, school: school, format: :json
        end

        it 'does not create a new School' do
          expect{
            post :create, school: school, format: :json
          }.to_not change(School, :count)
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
        school.name = 'New name'
        school.website = 'http://www.newwebsite.com'
        put :update, id: school.to_param, school: school, format: :json
      end

      it 'updates the school' do
        school.reload
        expect(school.name).to eq('New name')
        expect(school.website).to eq('http://www.newwebsite.com')
      end

      it 'returns the school as json' do
        expect(json).to have_key('name')
        expect(json).to have_key('school_district_id')
      end
    end

    describe 'with invalid attriutes' do

      describe 'without a name' do
        before(:each) do
          school.name = nil
          put :update, id: school.to_param, school: school, format: :json
        end

        it 'does not update the school' do
          school.reload
          expect(school.name).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end

      describe 'without a school_district_id' do
        before(:each) do
          school.school_district = nil
          put :update, id: school.to_param, school: school, format: :json
        end

        it 'does not update the school' do
          school.reload
          expect(school.school_district).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'GET show' do

    before(:each) do
      get :show, id: school.to_param, format: :json
    end

    it 'should return the school as json' do
      expect(json).to have_key('name')
    end

    it 'should return the school_disctrict_id' do
      expect(json).to have_key('school_district_id')
    end

    it 'should include the school_disctict' do
      expect(json).to have_key('school_district')
      expect(json['school_district']).to have_key('name')
    end

    it { should respond_with :ok }
  end
end
