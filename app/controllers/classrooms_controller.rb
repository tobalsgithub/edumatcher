class ClassroomsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  before_action :set_classroom, only: [:show, :update, :destroy, :add_subject, :remove_subject, :set_subjects]

  def create
    @classroom = Classroom.new(classroom_params)
    respond_to do |format|
      if @classroom.save && @classroom.valid?
        format.json { render :json => @classroom, :status => :created }
      else
        format.json { render :json => { "errors" => @classroom.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.json { render :json => @classroom }
      else
        format.json { render :json => { "errors" => @classroom.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @classroom
  end

  def search
    limit = params[:limit] ? params[:limit].to_i : 10
    page = params[:page] ? params[:page].to_i : 1
    offset = (page - 1) * limit
    subject_list = []
    grade_level_list = []
    if params[:grade_level_list] == nil || params[:grade_level_list].size == 0
      grade_level_list = GradeLevel.pluck(:id)
      grade_level_list.push(nil)
    else
      grade_level_list = params[:grade_level_list]
    end

    if params[:subject_list] == nil || params[:subject_list].size == 0
      classrooms = Classroom.where('classrooms.grade_level_id' => grade_level_list).limit(limit).offset(offset)
    else
      classrooms = Classroom.joins(:subjects).where('subjects.id' => params[:subject_list], 'classrooms.grade_level_id' => grade_level_list).limit(limit).offset(offset)
    end

    respond_to do |format|
      format.json { render :json => classrooms }
    end
  end

  def subjects
    respond_with(Classroom.find(params[:id]).subjects)
  end

  def add_subject
    @classroom.subjects << Subject.find(params[:subject_id])
    respond_to do |format|
      if @classroom.save && @classroom.valid?
        @classroom.reload
        format.json { render :json => @classroom.to_json }
      else
        format.json { render :json => { "errors" => @classroom.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def remove_subject
    subject = Subject.find(params[:subject_id])
    @classroom.subjects.delete(subject)
    respond_to do |format|
      if @classroom.save && @classroom.valid?
        @classroom.reload
        format.json { render :json => @classroom }
      else
        format.json { render :json => { "errors" => @classroom.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def set_subjects
    @classroom.subjects.clear
    if !params[:subject_list]
      respond_with @classroom
    else
      params[:subject_list].each do |id|
        @classroom.subjects << Subject.find(id)
      end
      respond_to do |format|
        if @classroom.save && @classroom.valid?
          format.json { render :json => @classroom }
        else
          format.json { render :json => { "errors" => @expert.errors }, :status => :unprocessable_entity }
        end
      end
    end    
  end

  private

  def classroom_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:classroom].permit(:name, :website, :location, :notes, :school_id, :subjects => [])
  end

  def set_classroom
    @classroom = Classroom.find(params[:id])
  end
end
