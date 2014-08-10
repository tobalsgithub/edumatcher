require 'rails_helper'

RSpec.describe RatingsController, :type => :controller do

  let(:valid_attributes) { create(:rating).attributes }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:expert) { create(:expert) }
  let(:rating) { create(:rating) }

  before(:each) do
    user.confirm!
    user.save
    sign_in user
  end

  describe 'POST create' do
    let(:rating) { build(:rating) }

    describe 'with valid attributes' do
      before(:each) do
        post :create, rating: rating, format: :json
      end

      it "creates a new Rating" do
        expect {
          post :create, rating: rating, format: :json
        }.to change(Rating, :count).by(1)
      end

      it "returns the created rating" do
        expect(json).to have_key('id')
        expect(json).to have_key('notes')
      end

      it { should respond_with 201 }
    end

    describe 'with invalid attributes' do

      describe 'without a ratable object' do

        before(:each) do
          rating.ratable = nil
          post :create, rating: rating, format: :json
        end

        it 'does not create a new Classroom' do
          expect{
            post :create, rating: rating, format: :json
          }.to_not change(Rating, :count)
        end

        it 'returns an error' do
          expect(json).to have_key('errors')
        end

        it { should respond_with :unprocessable_entity}
      end
    end

  end

  describe 'GET show' do
    before(:each) do
      get :show, id: rating.to_param, format: :json
    end

    it 'should return the rating in json format' do
      expect(json).to have_key('notes')
      expect(json).to have_key('title')
    end

    it { should respond_with 200 }

  end

  describe 'PUT update' do
    before(:each) do
      rating.notes = "New notes"
      put :update, id: rating.to_param, rating: rating, format: :json
    end

    it 'updates the rating' do
      rating.reload
      expect(rating.notes).to eq('New notes')
    end
  end

  describe 'DELETE destroy' do

    before(:each) do
      @rating = create(:rating)
    end

    it 'deletes the rating' do
      expect{
        delete :destroy, id: @rating.to_param , format: :json
      }.to change(Rating,:count).by(-1)
    end
  end

end
