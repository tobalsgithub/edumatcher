class ExpertsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_expert?, :only => [:update]
  before_action :set_expert, :except => [:show, :search, :subjects]
  respond_to :json

  def index
    respond_with(@expert)
  end

  def show
    @expert = Expert.find(params[:id])
    respond_with(@expert)
  end

  def update
    if params[:expert][:companies]
      @expert.companies.clear
      params[:expert][:companies].each do |c|
        @expert.companies << Company.find(c.id)
      end
    end
    respond_to do |format|
      if @expert.update(expert_params)
        format.json { render :json => @expert, :status => 204 }
      else
        format.json { render :json => { "errors" => @expert.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def search
    limit = params[:limit] ? params[:limit].to_i : 10
    page = params[:page] ? params[:page].to_i : 1
    offset = (page - 1) * limit
    if params[:subject_list] == nil || params[:subject_list].size == 0
      experts = Expert.all.limit(limit).offset(offset)
    else
      experts = Expert.joins(:subjects).where('subjects.id' => params[:subject_list]).limit(limit).offset(offset)
    end
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
    if !params[:subject_list]
      respond_with @expert
    else
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
  end

  def set_companiess
    @expert.companies.clear
    if !params[:companies]
      respond_with @expert
    else
      params[:company_list].each do |id|
        @expert.companies << Company.find(id)
      end
      respond_to do |format|
        if @expert.save && @expert.valid?
          format.json { render :json => @expert }
        else
          format.json { render :json => { "errors" => @expert.errors }, :status => :unprocessable_entity }
        end
      end
    end
  end

  private

  def set_companies(company_list)
    @expert.companies.clear
    company_list.each do |id|
      @expert.companies << Company.find(id)
    end
  end

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
