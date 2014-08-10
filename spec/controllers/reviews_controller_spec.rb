require 'rails_helper'

RSpec.describe ReviewsController, :type => :controller do

  let(:valid_attributes) { create(:review).attributes }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:expert) { create(:expert) }
  let(:review) { create(:review) }

  before(:each) do
    user.confirm!
    user.save
    sign_in user
  end

  describe 'POST create' do
    let(:review) { build(:review) }

    describe 'with valid attributes' do
      before(:each) do
        post :create, review: review, format: :json
      end

      it "creates a new Review" do
        expect {
          post :create, review: review, format: :json
        }.to change(Review, :count).by(1)
      end

      it "returns the created review" do
        expect(json).to have_key('id')
        expect(json).to have_key('notes')
      end

      it { should respond_with 201 }
    end

    describe 'with invalid attributes' do

      describe 'without a reviewable object' do

        before(:each) do
          review.reviewable = nil
          post :create, review: review, format: :json
        end

        it 'does not create a new Classroom' do
          expect{
            post :create, review: review, format: :json
          }.to_not change(Review, :count)
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
      get :show, id: review.to_param, format: :json
    end

    it 'should return the review in json format' do
      expect(json).to have_key('notes')
      expect(json).to have_key('title')
    end

    it { should respond_with 200 }

  end

  describe 'PUT update' do
    before(:each) do
      review.notes = "New notes"
      put :update, id: review.to_param, review: review, format: :json
    end

    it 'updates the review' do
      review.reload
      expect(review.notes).to eq('New notes')
    end
  end

  describe 'DELETE destroy' do

    before(:each) do
      @review = create(:review)
    end

    it 'deletes the review' do
      expect{
        delete :destroy, id: @review.to_param , format: :json
      }.to change(Review,:count).by(-1)
    end
  end

end
