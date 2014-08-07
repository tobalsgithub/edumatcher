require 'rails_helper'

RSpec.describe CompaniesController, :type => :controller do

  let(:valid_attributes) { create(:company).attributes }

  let(:invalid_attributes) { {
    'name' => ''
  } }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:company) { create(:company) }

  before(:each) do
    user.confirm!
    user.save
    sign_in user
  end

  describe 'POST create' do

    let(:company) { build(:company) }

    describe 'with valid attributes' do
      before(:each) do
        post :create, company: company, format: :json
      end

      it "creates a new Company" do
        expect {
          post :create, company: company, format: :json
        }.to change(Company, :count).by(1)
      end

      it "returns the created company" do
        expect(json).to have_key('id')
        expect(json).to have_key('name')
      end

      it { should respond_with 201 }

    end

    describe 'with invalid attributes' do

      describe 'without a name' do
        before(:each) do
          company.name = nil
          post :create, company: company, format: :json
        end

        it 'does not create a new Company' do
          expect{
            post :create, company: company, format: :json
          }.to_not change(Company, :count)
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
        company.name = 'New name'
        company.website = 'http://www.newwebsite.com'
        put :update, id: company.to_param, company: company, format: :json
      end

      it 'updates the company' do
        company.reload
        expect(company.name).to eq('New name')
        expect(company.website).to eq('http://www.newwebsite.com')
      end

      it 'returns the company as json' do
        expect(json).to have_key('name')
      end
    end

    describe 'with invalid attriutes' do

      describe 'without a name' do
        before(:each) do
          company.name = nil
          put :update, id: company.to_param, company: company, format: :json
        end

        it 'does not update the company' do
          company.reload
          expect(company.name).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'GET show' do

    before(:each) do
      get :show, id: company.to_param, format: :json
    end

    it 'should return the company as json' do
      expect(json).to have_key('name')
    end

    it 'should return the school_id' do
      expect(json).to have_key('website')
    end

    it { should respond_with :ok }
  end

  describe 'GET search' do
    before(:all) do
      comp1 = create(:company)
      comp2 = create(:company)
      comp3 = create(:company)
      comp4 = create(:company)
      comp1.name = 'Apple'
      comp2.name = 'Google'
      comp3.name = 'Epic'
      comp4.name = 'Epic Gaming Company'
      comp1.save!
      comp2.save!
      comp3.save!
      comp4.save!
    end

    it 'should not return any results if the search text is empty' do
      text = ''
      get :search, search_text: text, format: :json
      expect(json.size).to be 0
    end

    describe 'matching on name' do

      it 'should match the beginning of a name' do
        text = 'ap'
        get :search, search_text: text, format: :json
        expect(json.size).to be 1
      end

      it 'should match the middle of a name' do
        text = 'oogl'
        get :search, search_text: text, format: :json
        expect(json.size).to be 1
      end

      it 'should match multiple results' do
        text = 'Epic'
        get :search, search_text: text, format: :json
        expect(json.size).to be 2
      end

      it 'should match multiple words' do
        text = 'Epic Gaming'
        get :search, search_text: text, format: :json
        expect(json.size).to be 1
      end

    end      
  end
end
