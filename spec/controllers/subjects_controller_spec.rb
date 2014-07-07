require 'rails_helper'

RSpec.describe SubjectsController, :type => :controller do

  let(:valid_attributes) { create(:subject).attributes }

  let(:invalid_attributes) { {
    'name' => ''
  } }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:subject) { create(:subject) }

  before(:each) do
    user.confirm!
    user.save
    sign_in user
  end

  describe 'GET index' do
    before(:each) do
      create(:subject)
      get :index, format: :json
    end

    it 'should return the list of subjects' do
      expect(json[0]).to have_key('id')
    end

    xit { should respond_with :success }
  end

  describe 'POST create' do

    let(:subject) { build(:subject) }

    describe 'with valid attributes' do
      before(:each) do
        post :create, subject: subject, format: :json
      end

      it "creates a new Subject" do
        expect {
          post :create, subject: subject, format: :json
        }.to change(Subject, :count).by(1)
      end

      it "returns the created subject" do
        expect(json).to have_key('id')
        expect(json).to have_key('name')
      end

      xit { should respond_with 201 }
    end

    describe 'with invalid attributes' do

      describe 'without a name' do
        before(:each) do
          subject.name = nil
          post :create, subject: subject, format: :json
        end

        it 'does not create a new Subject' do
          expect{
            post :create, subject: subject, format: :json
          }.to_not change(Subject, :count)
        end

        it 'returns an error' do
          expect(json).to have_key('errors')
        end

        xit { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'PUT update' do

    describe 'with valid attributes' do

      before(:each) do
        subject.name = 'New name'
        put :update, id: subject.to_param, subject: subject, format: :json
      end

      it 'updates the subject' do
        subject.reload
        expect(subject.name).to eq('New name')
      end

      it 'returns the subject as json' do
        expect(json).to have_key('name')
      end
    end

    describe 'with invalid attriutes' do

      describe 'without a name' do
        before(:each) do
          subject.name = nil
          put :update, id: subject.to_param, subject: subject, format: :json
        end

        it 'does not update the subject' do
          subject.reload
          expect(subject.name).to_not be(nil)
        end

        xit { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'GET show' do

    before(:each) do
      get :show, id: subject.to_param, format: :json
    end

    it 'should return the subject as json' do
      expect(json).to have_key('name')
    end

    xit { should respond_with :ok }
  end
end
