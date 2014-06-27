class ExpertsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_expert?, :except => [:subjects]
  before_action :set_expert
  respond_to :json

  def index
    respond_with(@expert)
  end

  def show
    @expert = Expert.find(params[:id])
    respond_with(@expert)
  end

  def update
    respond_to do |format|
      if @expert.update(expert_params)
        format.json { render :json => @expert, :status => 204 }
      else
        format.json { render :json => { "errors" => @expert.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def search
    limit = params[:limit] || 10
    page = params[:page] || 1
    offset = (page - 1) * limit
    experts = Expert.joins(:subjects).where('subjects.id' => params[:subject_list]).limit(limit).offset(offset)
    respond_to do |format|
      format.json { render :json => experts }
    end
  end

  def subjects
    respond_with(Expert.find(params[:id]).subjects)
  end

  def add_subject
    #subject = Subject.find(params[:subject_id])
    @expert.subjects << Subject.find(params[:subject_id])
    respond_to do |format|
      if @expert.save && @expert.valid?
        @expert.reload
        format.json { render :json => @expert }
      else
        format.json { render :json => { "errors" => @expert.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def remove_subject
    subject = Subject.find(params[:subject_id])
    @expert.subjects.delete(subject)
    respond_to do |format|
      if @expert.save && @expert.valid?
        @expert.reload
        format.json { render :json => @expert }
      else
        format.json { render :json => { "errors" => @expert.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def set_subjects
    @expert.subjects.clear
    params[:subject_list].each do |id|
      @expert.subjects << Subject.find(id)
    end
    respond_to do |format|
      if @expert.save && @expert.valid?
        format.json { render :json => @expert }
      else
        format.json { render :json => { "errors" => @expert.errors }, :status => :unprocessable_entity }
      end
    end
  end

  private

  def is_expert?
    render :json => { "errors" => ["You are not an expert"] }, :status => :unauthorized unless current_user.expert
  end

  def set_expert
    @expert = current_user.expert
  end

  def expert_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:expert].permit(:notes)
  end
end
