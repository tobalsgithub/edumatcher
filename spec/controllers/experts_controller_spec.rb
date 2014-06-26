require 'rails_helper'

RSpec.describe ExpertsController, :type => :controller do

  let(:valid_attributes) { create(:expert).attributes }

  let(:invalid_attributes) { {
    'name' => ''
  } }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:expert) { create(:expert) }

  before(:each) do
    user.confirm!
    user.expert = expert
    user.save
    sign_in user
  end

  describe 'access for experts' do

    before(:each) do
      get :index, format: :json
    end

    it { should respond_with 200 }

  end

  describe 'access for non experts' do
    before(:each) do
      educator = create(:educator, user: user)
      user.expert = nil
      user.save
      get :index, format: :json
    end

    it { should respond_with 401 }

  end

  describe 'GET index' do
    before(:each) do
      get :index, format: :json
    end

    it 'should return the expert in json format' do
      expect(json['subjects'].size).to be(0)
    end

    it { should respond_with 200 }
  end

  describe 'GET show' do
    before(:each) do
      get :index, id: expert.to_param, format: :json
    end

    it 'should return the expert in json format' do
      expect(json).to have_key('subjects')
    end

    it { should respond_with 200 }

  end

  describe 'GET subjects' do
    it 'returns no subjects when there are no subjects' do
      get :subjects, id: expert.id, format: :json
      expect(json.size).to be(0)
    end

    it 'can retrieve all existing subjects' do
      sub1 = create(:subject)
      sub2 = create(:subject)
      expert.subjects << sub1
      expert.subjects << sub2
      expert.save
      get :subjects, id: expert.id, format: :json
      expect(json.size).to be(2)
    end

    it 'can retrieve all subjects for another expert' do
      sign_out user
      user2 = create(:user)
      educator = create(:educator)
      user2.confirm!
      user2.educator = educator
      user2.save
      sign_in user2
      different_expert = create(:expert)
      sub1 = create(:subject)
      sub2 = create(:subject)
      different_expert.subjects << sub1
      different_expert.subjects << sub2
      different_expert.save
      get :subjects, id: different_expert.id, format: :json
      expect(json.size).to be(2)
    end
  end

  describe 'PUT update' do
    let(:expert) { create(:expert) }
    before(:each) do
      expert.notes = "New notes"
      put :update, id: expert.to_param, expert: expert, format: :json
    end

    it 'updates the expert' do
      expert.reload
      expect(expert.notes).to eq('New notes')
    end

    it { should respond_with 204 }
  end

  describe 'POST add_subject' do
    let(:subject) { create(:subject) }

    it 'can add a subject to an expert' do
      params = { subject_id: subject.to_param }
      post :add_subject, subject_id: subject.to_param, format: :json
      expect(expert.subjects.size).to be(1)
      expect(expert.subjects.first.name).to eq(subject.name)
    end
  end

  describe 'POST remove_subject' do
    let(:subject) { create(:subject) }

    before(:each) do
      expert.subjects << subject
      expert.save
    end

    it 'can remove an existing subject from an expert' do
      expect(expert.subjects.size).to be 1
      post :remove_subject, subject_id: subject.to_param, format: :json
      expect(expert.subjects.size).to be(0)
    end
  end

  describe 'POST set_subjects' do

    before(:each) do
      sub1 = create(:subject)
      sub2 = create(:subject)
      sub3 = create(:subject)
      array = [sub1.id, sub2.id, sub3.id]
      post :set_subjects, subject_list: array, format: :json
    end

    it 'can set the list of subjects for an expert' do
      expect(expert.subjects.size).to be 3
    end
  end
end
