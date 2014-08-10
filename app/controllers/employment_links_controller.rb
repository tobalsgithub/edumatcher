class EmploymentLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employment_link, only: [:show, :update, :destroy]
  respond_to :json

  def create
    @employment_link = EmploymentLink.new(employment_link_params)
    respond_to do |format|
      if @employment_link.save && @employment_link.valid?
        format.json { render :json => @employment_link, :status => :created }
      else
        format.json { render :json => { "errors" => @employment_link.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employment_link.update(employment_link_params)
        format.json { render :json => @employment_link }
      else
        format.json { render :json => { "errors" => @employment_link.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @employment_link
  end

  def destroy
    respond_to do |format|
      if @employment_link.destroy
        format.json { render :json => @employment_link }
      else
        format.json { render :json => { "errors" => @employment_link.errors }, :status => :unprocessable_entity }
      end
    end
  end

  private

  def employment_link_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:employment_link].permit(:company_id, :expert_id)
  end

  def set_employment_link
    @employment_link = EmploymentLink.find(params[:id])
  end

end
