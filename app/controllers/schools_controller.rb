class SchoolsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  before_action :set_school, only: [:show, :update, :destroy]

  def create
    @school = School.new(school_params)
    respond_to do |format|
      if @school.save && @school.valid?
        format.json { render :json => @school, :status => :created }
      else
        format.json { render :json => { "errors" => @school.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @school.update(school_params)
        format.json { render :json => @school }
      else
        format.json { render :json => { "errors" => @school.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @school
  end

  private

  def school_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:school].permit(:name, :website, :location, :notes, :school_district_id)
  end

  def set_school
    @school = School.find(params[:id])
  end
end
