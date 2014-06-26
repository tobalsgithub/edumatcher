class ExpertsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_expert?, :except => [:subjects]
  before_action :set_expert
  respond_to :json

  def index
    respond_with(expert_to_json)
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
        format.json { render :json => expert_to_json }
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
        format.json { render :json => expert_to_json }
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
        format.json { render :json => expert_to_json }
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
    params.permit(:notes, :subject_list, :subject_id)
    # json_params = ActionController::Parameters.new( JSON.parse(request.body.read ) )
    # json_params.permit(:notes, :subject_array, :subject_id)
  end

  def expert_to_json
    @expert.to_json(:include => :subjects)
  end
end
