require 'rails_helper'

RSpec.describe EducatorsController, :type => :controller do

  let(:valid_attributes) { create(:classroom).attributes }

  let(:invalid_attributes) { {
    'name' => ''
  } }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:educator) { create(:educator) }
  let(:classroom) { create(:classroom) }

  before(:each) do
    user.confirm!
    user.educator = educator
    user.save
    sign_in user
  end

  describe 'access for educators' do

    before(:each) do
      get :index, format: :json
    end

    it { should respond_with 200 }

  end

  describe 'access for non educators' do
    before(:each) do
      user.educator = nil
      user.save
      get :index, format: :json
    end

    it { should respond_with 401 }

  end

  describe 'GET index' do
    before(:each) do
      get :index, format: :json
    end

    it 'should return the educator in json format' do
      expect(json).to have_key('notes')
    end

    it { should respond_with 200 }
  end

  describe 'GET show' do
    before(:each) do
      get :index, id: educator.to_param, format: :json
    end

    it 'should return the educator in json format' do
      expect(json).to have_key('notes')
    end

    it { should respond_with 200 }

  end

  describe 'PUT update' do
    before(:each) do
      educator.notes = "New notes"
      put :update, id: educator.to_param, educator: educator, format: :json
    end

    it 'updates the educator' do
      educator.reload
      expect(educator.notes).to eq('New notes')
    end

    it { should respond_with 204 }
  end

  # Currently not using subjects for educators. Maybe later
  # xdescribe 'POST add_subject' do
  #   let(:subject) { create(:subject) }
  #
  #   it 'can add a subject to an educator' do
  #     params = { subject_id: subject.to_param }
  #     post :add_subject, subject_id: subject.to_param, format: :json
  #     expect(educator.subjects.size).to be(1)
  #     expect(educator.subjects.first.name).to eq(subject.name)
  #   end
  # end
  #
  # xdescribe 'POST remove_subject' do
  #   let(:subject) { create(:subject) }
  #
  #   before(:each) do
  #     educator.subjects << subject
  #     educator.save
  #   end
  #
  #   it 'can remove an existing subject from an educator' do
  #     expect(educator.subjects.size).to be 1
  #     post :remove_subject, subject_id: subject.to_param, format: :json
  #     expect(educator.subjects.size).to be(0)
  #   end
  # end
  #
  # xdescribe 'POST set_subjects' do
  #
  #   before(:each) do
  #     sub1 = create(:subject)
  #     sub2 = create(:subject)
  #     sub3 = create(:subject)
  #     array = [sub1.id, sub2.id, sub3.id]
  #     post :set_subjects, subject_list: array, format: :json
  #   end
  #
  #   it 'can set the list of subjects for an expert' do
  #     expect(educator.subjects.size).to be 3
  #   end
  # end
end
