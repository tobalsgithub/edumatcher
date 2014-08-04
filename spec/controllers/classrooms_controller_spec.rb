require 'rails_helper'

RSpec.describe ClassroomsController, :type => :controller do

  let(:valid_attributes) { create(:classroom).attributes }

  let(:invalid_attributes) { {
    'name' => ''
  } }

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  let(:valid_session) { {} }

  let(:user) { create(:user) }
  let(:educator) { create(:educator) }
  let(:classroom) { create(:classroom) }
  let(:school) { create(:school) }

  before(:each) do
    user.confirm!
    user.educator = educator
    user.save
    sign_in user
  end

  describe 'POST create' do

    let(:classroom) { build(:classroom) }

    describe 'with valid attributes' do
      before(:each) do
        classroom.school = school
        post :create, classroom: classroom, format: :json
      end

      it "creates a new Classroom" do
        expect {
          post :create, classroom: classroom, format: :json
        }.to change(Classroom, :count).by(1)
      end

      it "returns the created classroom" do
        expect(json).to have_key('id')
        expect(json).to have_key('name')
      end

      it { should respond_with 201 }

      xdescribe 'with subject list' do
        before(:each) do
          classroom.subjects.delete_all
          classroom.subjects << create(:subject)
          classroom.subjects << create(:subject)
          # puts classroom_json
        end

        xit "creates a new Classroom" do
          expect {
            post :create, classroom: classroom, format: :json
          }.to change(Classroom, :count).by(1)
        end

        it 'returns the new classroom with subjects included' do
          post :create, classroom: classroom, format: :json
          expect(json).to have_key('subjects')
          expect(json['subjects'].size).to be(2)
        end
      end

    end

    describe 'with invalid attributes' do

      describe 'without a school' do

        before(:each) do
          classroom.school = nil
          post :create, classroom: classroom, format: :json
        end

        it 'does not create a new Classroom' do
          expect{
            post :create, classroom: classroom, format: :json
          }.to_not change(Classroom, :count)
        end

        it 'returns an error' do
          expect(json).to have_key('errors')
        end

        it { should respond_with :unprocessable_entity}
      end

      describe 'without a name' do
        before(:each) do
          classroom.name = nil
          post :create, classroom: classroom, format: :json
        end

        it 'does not create a new Classroom' do
          expect{
            post :create, classroom: classroom, format: :json
          }.to_not change(Classroom, :count)
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
        classroom.name = 'New name'
        classroom.website = 'http://www.newwebsite.com'
        put :update, id: classroom.to_param, classroom: classroom, format: :json
      end

      it 'updates the classroom' do
        classroom.reload
        expect(classroom.name).to eq('New name')
        expect(classroom.website).to eq('http://www.newwebsite.com')
      end

      it 'returns the classroom as json' do
        expect(json).to have_key('name')
        expect(json).to have_key('school_id')
      end
    end

    describe 'with invalid attriutes' do

      describe 'without a name' do
        before(:each) do
          classroom.name = nil
          put :update, id: classroom.to_param, classroom: classroom, format: :json
        end

        it 'does not update the classroom' do
          classroom.reload
          expect(classroom.name).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end

      describe 'without a school_id' do
        before(:each) do
          classroom.school = nil
          put :update, id: classroom.to_param, classroom: classroom, format: :json
        end

        it 'does not update the classroom' do
          classroom.reload
          expect(classroom.school).to_not be(nil)
        end

        it { should respond_with :unprocessable_entity}
      end
    end
  end

  describe 'GET show' do

    before(:each) do
      get :show, id: classroom.to_param, format: :json
    end

    it 'should return the classroom as json' do
      expect(json).to have_key('subjects')
    end

    it 'should return the school_id' do
      expect(json).to have_key('school_id')
    end

    it 'should include the school' do
      expect(json).to have_key('school')
      expect(json['school']).to have_key('name')
    end

    it { should respond_with :ok }
  end

  describe 'GET subjects' do
    it 'returns no subjects when there are no subjects' do
      classroom.subjects.delete_all
      get :subjects, id: classroom.to_param, format: :json
      expect(json.size).to be(0)
    end

    it 'can retrieve all existing subjects' do
      classroom.subjects.delete_all
      sub1 = create(:subject)
      sub2 = create(:subject)
      classroom.subjects << sub1
      classroom.subjects << sub2
      classroom.save
      get :subjects, id: classroom.to_param, format: :json
      expect(json.size).to be(2)
    end
  end

  describe 'POST add_subject' do
    let(:subject) { create(:subject) }

    before(:each) do
      post :add_subject, id: classroom.to_param, subject_id: subject.to_param, format: :json
    end

    it 'can add a subject to a classroom' do
      expect(classroom.subjects.size).to be(1)
      expect(classroom.subjects.first.name).to eq(subject.name)
    end

    it 'returns the classroom as json' do
      expect(json).to have_key('subjects')
    end
  end

  describe 'POST remove_subject' do
    let(:subject) { create(:subject) }

    before(:each) do
      classroom.subjects << subject
      classroom.save
    end

    it 'can remove an existing subject from an classroom' do
      expect(classroom.subjects.size).to be 1
      post :remove_subject, id: classroom.to_param, subject_id: subject.to_param, format: :json
      expect(classroom.subjects.size).to be(0)
    end
  end

  describe 'POST set_subjects' do

    before(:each) do

    end

    it 'can set the list of subjects for an classroom' do
      sub1 = create(:subject)
      sub2 = create(:subject)
      sub3 = create(:subject)
      array = [sub1.id, sub2.id, sub3.id]
      post :set_subjects, id: classroom.to_param, subject_list: array, format: :json
      expect(classroom.subjects.size).to be 3
    end

    it 'can set the list of subjects for a classroom to empty' do
      array = nil
      classroom.subjects << create(:subject)
      classroom.subjects << create(:subject)
      classroom.save!
      expect(classroom.subjects.size).to be 2
      post :set_subjects, id: classroom.to_param, subject_list: array, format: :json
      expect(classroom.subjects.size).to be 0
    end
  end

  describe 'GET search' do

    before(:all) do
      @sub_array = []
      @grade_level_array = []
      @class_array = []
      5.times do
        subject = create(:subject)
        @sub_array.push(subject)
        grade_level = create(:grade_level)
        @grade_level_array.push(grade_level)
        4.times do
          classroom = create(:classroom)
          classroom.subjects << subject
          classroom.grade_level = grade_level
          classroom.save
          @class_array.push(classroom)
        end
      end
    end

    describe 'matching on subject' do

      it 'returns all classrooms if no subject_list is given' do
        get :search, format: :json
        expect(json.size).to be(10)
      end

      it 'finds classrooms with a matching subject' do
        subject = create(:subject)
        classroom = create(:classroom)
        classroom.subjects << subject
        classroom.save
        get :search, subject_list: [subject.to_param], format: :json
        expect(json.size).to be(1)
        expect(json[0]["name"]).to eq(classroom.name)
      end

      it 'finds classrooms if the subject_list has more than just matching subjects' do
        subject = create(:subject)
        sub2 = create(:subject)
        classroom = create(:classroom)
        classroom.subjects << subject
        classroom.save
        get :search, subject_list: [subject.to_param, sub2.to_param], format: :json
        expect(json.size).to be(1)
        expect(json[0]["name"]).to eq(classroom.name)
      end

      it 'finds classrooms with matching subjects' do
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

    describe 'matching on grade level' do
      it 'returns all classrooms if no grade_level_list is given' do
        get :search, format: :json
        expect(json.size).to be(10)
      end

      it 'finds classrooms with a matching grade_level' do
        grade_level = create(:grade_level)
        classroom = create(:classroom)
        classroom.grade_level = grade_level
        classroom.save
        get :search, grade_level_list: [grade_level.to_param], format: :json
        expect(json.size).to be(1)
        expect(json[0]["name"]).to eq(classroom.name)
      end

      it 'finds classrooms if the grade_level_list has more than just matching grade_level' do
        grade_level = create(:grade_level)
        grade_level_2 = create(:grade_level)
        classroom = create(:classroom)
        classroom.grade_level = grade_level
        classroom.subjects << create(:subject)
        classroom.save
        get :search, grade_level_list: [grade_level.to_param, grade_level_2.to_param], format: :json
        expect(json.size).to be(1)
        expect(json[0]["name"]).to eq(classroom.name)
      end

      it 'finds classrooms with matching grade_level' do
        get :search, grade_level_list: [@grade_level_array.first.to_param, @grade_level_array.second.to_param], format: :json
        expect(json.size).to be(8)
      end

      it 'limits the number returned to 10 by default' do
        get :search, grade_level_list: [@grade_level_array.first.to_param, @grade_level_array.second.to_param, @grade_level_array.third.to_param, @grade_level_array.fourth.to_param], format: :json
        expect(json.size).to be(10)
      end

      it 'can find an arbitrary number of results' do
        get :search, limit: 18, grade_level_list: [@grade_level_array.first.to_param, @grade_level_array.second.to_param, @grade_level_array.third.to_param, @grade_level_array.fourth.to_param, @grade_level_array.fifth.to_param], format: :json
        expect(json.size).to be(18)
      end

      it 'can return an arbitrary number of results starting from not the first page' do
        get :search, limit: 5, page: 2, grade_level_list: [@grade_level_array.first.to_param, @grade_level_array.second.to_param], format: :json
        expect(json.size).to be(3)
      end
    end

    xdescribe 'limiting the results by location' do

    end

  end
end
