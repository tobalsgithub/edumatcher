require 'rails_helper'

RSpec.describe EmploymentLinksController, :type => :controller do

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:employment_link) { create(:employment_link) }
  let(:company) { create(:company) }
  let(:expert) { create(:expert) }

  before(:each) do
    user.confirm!
    user.save
    sign_in user
  end

  describe 'POST create' do

    let(:employment_link) { build(:employment_link) }

    describe 'with valid attributes' do
      before(:each) do
        post :create, employment_link: employment_link, format: :json
      end

      it "creates a new EmploymentLink" do
        expect {
          post :create, employment_link: employment_link, format: :json
        }.to change(EmploymentLink, :count).by(1)
      end

      it "returns the created employment_link" do
        expect(json).to have_key('company')
        expect(json).to have_key('expert')
      end

      it { should respond_with 201 }

    end

    describe 'with invalid attributes' do

      describe 'without a company' do
        before(:each) do
          employment_link.company = nil
          post :create, employment_link: employment_link, format: :json
        end

        it 'does not create a new EmploymentLink' do
          expect{
            post :create, employment_link: employment_link, format: :json
          }.to_not change(EmploymentLink, :count)
        end

        it 'returns an error' do
          expect(json).to have_key('errors')
        end

        it { should respond_with :unprocessable_entity}
      end

      describe 'without an expert' do
        before(:each) do
          employment_link.expert = nil
          post :create, employment_link: employment_link, format: :json
        end

        it 'does not create a new EmploymentLink' do
          expect{
            post :create, employment_link: employment_link, format: :json
          }.to_not change(EmploymentLink, :count)
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
        @company = create(:company)
        @expert = create(:expert)
        employment_link.company = @company
        employment_link.expert = @expert
        put :update, id: employment_link.to_param, employment_link: employment_link, format: :json
      end

      it 'updates the employment_link' do
        employment_link.reload
        expect(employment_link.company.id).to eq(@company.id)
        expect(employment_link.expert.id).to eq(@expert.id)
      end

      it 'returns the employment_link as json' do
        expect(json).to have_key('company')
        expect(json).to have_key('expert')
      end
    end

    describe 'with invalid attriutes' do

      describe 'without a company' do
        before(:each) do
          employment_link.company = nil
          put :update, id: employment_link.to_param, employment_link: employment_link, format: :json
        end

        it 'does not update the employment_link' do
          employment_link.reload
          expect(employment_link.company).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end

      describe 'without an expert' do
        before(:each) do
          employment_link.expert = nil
          put :update, id: employment_link.to_param, employment_link: employment_link, format: :json
        end

        it 'does not update the employment_link' do
          employment_link.reload
          expect(employment_link.expert).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'GET show' do

    before(:each) do
      get :show, id: employment_link.to_param, format: :json
    end

    it 'should return the company' do
      expect(json).to have_key('company')
    end

    it 'should return the expert' do
      expect(json).to have_key('expert')
    end

    it { should respond_with :ok }
  end
end
