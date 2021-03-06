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
    describe 'access allowed' do

      before(:each) do
        get :index, id: expert.to_param, format: :json
      end

      it { should respond_with 200 }
    end

  end

  describe 'access for non experts' do
    describe 'access allowed' do

      before(:each) do
        user.expert = nil
        user.save
        get :index, id: expert.to_param, format: :json
      end

      it { should respond_with 200 }
    end

    describe 'access denied' do
      before(:each) do
        expert.notes = "New notes"
        user.expert = nil
        put :update, id: expert.to_param, expert: expert, format: :json
      end

      it {should respond_with 401 }
    end

  end

  describe 'GET index' do
    before(:each) do
      get :index, id: expert.to_param, format: :json
    end

    it 'should return the expert in json format' do
      expect(json['knowledge_links'].size).to be(0)
    end

    it { should respond_with 200 }
  end

  describe 'GET show' do
    before(:each) do
      get :index, id: expert.to_param, format: :json
    end

    it 'should return the expert in json format' do
      expect(json).to have_key('knowledge_links')
    end

    it { should respond_with 200 }

  end

  describe 'GET subjects' do
    it 'returns no subjects when there are no subjects' do
      get :subjects, id: expert.to_param, format: :json
      expect(json.size).to be(0)
    end

    it 'can retrieve all existing subjects' do
      sub1 = create(:subject)
      sub2 = create(:subject)
      expert.subjects << sub1
      expert.subjects << sub2
      expert.save
      get :subjects, id: expert.to_param, format: :json
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
      get :subjects, id: different_expert.to_param, format: :json
      expect(json.size).to be(2)
    end
  end

  describe 'PUT update' do
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

    before(:each) do
      post :add_subject, id: expert.to_param, subject_id: subject.to_param, format: :json
    end

    it 'can add a subject to an expert' do
      expect(expert.subjects.size).to be(1)
      expect(expert.subjects.first.name).to eq(subject.name)
    end

    it 'returns the expert as json' do
      expect(json).to have_key('knowledge_links')
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
      post :remove_subject, id: expert.to_param, subject_id: subject.to_param, format: :json
      expect(expert.subjects.size).to be(0)
    end
  end

  describe 'POST set_subjects' do

    it 'can set the list of subjects for an expert' do
      sub1 = create(:subject)
      sub2 = create(:subject)
      sub3 = create(:subject)
      array = [sub1.id, sub2.id, sub3.id]
      post :set_subjects, id: expert.to_param, subject_list: array, format: :json
      expect(expert.subjects.size).to be 3
    end

    it 'can set the list of subjects for an expert to empty' do
      array = nil
      expert.subjects << create(:subject)
      expert.subjects << create(:subject)
      expert.save!
      expect(expert.subjects.size).to be 2
      post :set_subjects, id: expert.to_param, subject_list: array, format: :json
      expect(expert.subjects.size).to be 0
    end
  end

  describe 'POST add_company' do
    let(:company) { create(:company) }

    before(:each) do
      post :add_company, id: expert.to_param, company_id: company.to_param, format: :json
    end

    it 'can add a company to an expert' do
      expect(expert.companies.size).to be(1)
      expect(expert.companies.first.name).to eq(company.name)
    end

    it 'returns the expert as json' do
      expect(json).to have_key('employment_links')
    end
  end

  describe 'POST remove_company' do
    let(:company) { create(:company) }

    before(:each) do
      expert.companies << company
      expert.save
    end

    it 'can remove an existing company from an expert' do
      expect(expert.companies.size).to be 1
      post :remove_company, id: expert.to_param, company_id: company.to_param, format: :json
      expect(expert.companies.size).to be(0)
    end
  end

  describe 'POST set_companies' do
    it 'can set the list of companies for an expert' do
      comp1 = create(:company)
      comp2 = create(:company)
      comp3 = create(:company)
      array = [comp1.id, comp2.id, comp3.id]
      post :set_companies, id: expert.to_param, company_list: array, format: :json
      expert.reload
      expect(expert.companies.size).to be 3
    end

    it 'can set the list of companies for an expert to empty' do
      array = nil
      expert.companies << create(:company)
      expert.companies << create(:company)
      expert.save!
      expect(expert.companies.size).to be 2
      post :set_companies, id: expert.to_param, company_list: array, format: :json
      expect(expert.companies.size).to be 0
    end
  end

  describe 'GET search' do

    before(:all) do
      @sub_array = []
      @exp_array = []
      5.times do
        subject = create(:subject)
        @sub_array.push(subject)
        4.times do
          expert = create(:expert)
          expert.subjects << subject
          expert.save
          @exp_array.push(expert)
        end
      end
    end

    describe 'matching on subject' do

      it 'returns all experts if no subject_list is given' do
        get :search, format: :json
        expect(json.size).to be(10)
      end

      it 'finds experts with a matching subject' do
        subject = create(:subject)
        expert = create(:expert)
        expert.subjects << subject
        expert.save
        get :search, subject_list: [subject.to_param], format: :json
        expect(json.size).to be(1)
        expect(json[0]["notes"]).to eq(expert.notes)
      end

      it 'finds experts with matching subjects' do
        get :search, subject_list: [@sub_array.first.to_param, @sub_array.second.to_param], format: :json
        expect(json.size).to be(8)
      end

      it 'limits the number returned to 10 by default' do
        get :search, subject_list: [@sub_array.first.to_param, @sub_array.second.to_param, @sub_array.third.to_param, @sub_array.fourth.to_param], format: :json
        expect(json.size).to be(10)
      end

      it 'can find an arbitrary number of results' do
        get :search, limit: 18, subject_list: [@sub_array.first.to_param, @sub_array.second.to_param, @sub_array.third.to_param, @sub_array.fourth.to_param, @sub_array.fifth.to_param], format: :json
        expect(json.size).to be(18)
      end

      it 'can return an arbitrary number of results starting from not the first page' do
        get :search, limit: 5, page: 2, subject_list: [@sub_array.first.to_param, @sub_array.second.to_param], format: :json
        expect(json.size).to be(3)
      end
    end

    xdescribe 'limiting the results by location' do

    end
  end

  describe 'GET reviews' do
    before(:each) do
      expert.reviews.destroy_all
      expert.reviews << create(:review)
      expert.reviews << create(:review)
      expert.reviews << create(:review)

      @expert2 = create(:expert)
      @expert2.user = create(:user)
      @expert2.save!
      @expert2.reviews.destroy_all
      @expert2.reviews << create(:review)
      @expert2.reviews << create(:review)
      @expert2.save!
    end

    it 'should return the reviews of an expert' do
      get :reviews, id: expert.to_param, format: :json
      expect(json.size).to be 3
    end

    it 'should return the reviews of any expert' do
      get :reviews, id: @expert2.to_param, format: :json
      expect(json.size).to be 2
    end
  end
end
