require 'rails_helper'

RSpec.describe KnowledgeLinksController, :type => :controller do

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }

  before(:each) do
    user.confirm!
    user.save
    sign_in user
  end

  describe 'POST create' do

    describe 'with valid attributes' do

      describe 'with a classroom' do
        let(:classroom_knowledge_link) { build(:classroom_knowledge_link) }

        before(:each) do
          post :create, knowledge_link: classroom_knowledge_link, format: :json
        end

        it "creates a new KnowledgeLink" do
          expect {
            post :create, knowledge_link: classroom_knowledge_link, format: :json
          }.to change(KnowledgeLink, :count).by(1)
        end

        it "returns the created knowledge_link" do
          expect(json).to have_key('subject')
          expect(json).to have_key('knowledgeable')
          expect(json).to have_key('knowledgeable_type')
        end

        it { should respond_with 201 }

      end

      describe 'with an expert' do
        let(:expert_knowledge_link) { build(:expert_knowledge_link) }

        before(:each) do
          post :create, knowledge_link: expert_knowledge_link, format: :json
        end

        it "creates a new KnowledgeLink" do
          expect {
            post :create, knowledge_link: expert_knowledge_link, format: :json
          }.to change(KnowledgeLink, :count).by(1)
        end

        it "returns the created knowledge_link" do
          expect(json).to have_key('subject')
          expect(json).to have_key('knowledgeable')
          expect(json).to have_key('knowledgeable_type')
        end

        it { should respond_with 201 }
      end

    end

    describe 'with invalid attributes' do
      let(:knowledge_link) { build(:expert_knowledge_link) }

      describe 'without a subject' do

        before(:each) do
          knowledge_link.subject = nil
          post :create, knowledge_link: knowledge_link, format: :json
        end

        it 'does not create a new KnowledgeLink' do
          expect{
            post :create, knowledge_link: knowledge_link, format: :json
          }.to_not change(KnowledgeLink, :count)
        end

        it 'returns an error' do
          expect(json).to have_key('errors')
        end

        it { should respond_with :unprocessable_entity}
      end

      describe 'without an expert' do
        before(:each) do
          knowledge_link.knowledgeable = nil
          post :create, knowledge_link: knowledge_link, format: :json
        end

        it 'does not create a new KnowledgeLink' do
          expect{
            post :create, knowledge_link: knowledge_link, format: :json
          }.to_not change(KnowledgeLink, :count)
        end

        it 'returns an error' do
          expect(json).to have_key('errors')
        end

        it { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'PUT update' do
    let(:knowledge_link) { create(:expert_knowledge_link) }

    describe 'with valid attributes' do
      before(:each) do
        @subject = create(:subject)
        @expert = create(:expert)
        knowledge_link.subject = @subject
        knowledge_link.knowledgeable = @expert
        put :update, id: knowledge_link.to_param, knowledge_link: knowledge_link, format: :json
      end

      it 'updates the knowledge_link' do
        knowledge_link.reload
        expect(knowledge_link.subject.id).to eq(@subject.id)
        expect(knowledge_link.knowledgeable.id).to eq(@expert.id)
      end

      it 'returns the knowledge_link as json' do
        expect(json).to have_key('subject')
        expect(json).to have_key('knowledgeable')
        expect(json).to have_key('knowledgeable_type')
      end
    end

    describe 'with invalid attriutes' do

      describe 'without a subject' do
        before(:each) do
          knowledge_link.subject = nil
          put :update, id: knowledge_link.to_param, knowledge_link: knowledge_link, format: :json
        end

        it 'does not update the knowledge_link' do
          knowledge_link.reload
          expect(knowledge_link.subject).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end

      describe 'without an expert' do
        before(:each) do
          knowledge_link.knowledgeable = nil
          put :update, id: knowledge_link.to_param, knowledge_link: knowledge_link, format: :json
        end

        it 'does not update the knowledge_link' do
          knowledge_link.reload
          expect(knowledge_link.knowledgeable).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'GET show' do
    let(:knowledge_link) { create(:expert_knowledge_link) }

    before(:each) do
      get :show, id: knowledge_link.to_param, format: :json
    end

    it 'should return the subject' do
      expect(json).to have_key('subject')
    end

    it 'should return the knowledgeable id and knowledgeable type' do
      expect(json).to have_key('knowledgeable')
      expect(json).to have_key('knowledgeable_id')
      expect(json).to have_key('knowledgeable_type')
    end

    it { should respond_with :ok }
  end
end
