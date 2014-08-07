class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show, :update]
  respond_to :json

  def create
    @company = Company.new(company_params)
    respond_to do |format|
      if @company.save && @company.valid?
        format.json { render :json => @company, :status => :created }
      else
        format.json { render :json => { "errors" => @company.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.json { render :json => @company }
      else
        format.json { render :json => { "errors" => @company.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @company
  end

  def search
    if !params[:search_text] || params[:search_text] == ''
      respond_with []
    else
      text = ('%' + params[:search_text] + '%')
      companies = Company.where {name =~ text }
      respond_with companies
    end
  end

  private

  def company_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:company].permit(:name, :website)
  end

  def set_company
    @company = Company.find(params[:id])
  end

end
