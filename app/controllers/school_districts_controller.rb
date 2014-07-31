class SchoolDistrictsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  before_action :set_school_district, only: [:show, :update, :destroy, :schools]

  def index
    respond_with SchoolDistrict.all
  end

  def create
    @school_district = SchoolDistrict.new(school_district_params)
    respond_to do |format|
      if @school_district.save && @school_district.valid?
        format.json { render :json => @school_district, :status => :created }
      else
        format.json { render :json => { "errors" => @school_district.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @school_district.update(school_district_params)
        format.json { render :json => @school_district }
      else
        format.json { render :json => { "errors" => @school_district.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @school_district
  end

  def schools
    schools = @school_district.schools
    respond_with schools
  end

  private

  def school_district_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:school_district].permit(:name, :website, :location, :notes)
  end

  def set_school_district
    @school_district = SchoolDistrict.find(params[:id])
  end
end
