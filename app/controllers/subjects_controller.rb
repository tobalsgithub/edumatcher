class SubjectsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  before_action :set_subject, only: [:show, :update, :destroy]

  def index
    respond_with Subject.all
  end

  def create
    @subject = Subject.new(subject_params)
    respond_to do |format|
      if @subject.save && @subject.valid?
        format.json { render :json => @subject, :status => :created }
      else
        format.json { render :json => { "errors" => @subject.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.json { render :json => @subject }
      else
        format.json { render :json => { "errors" => @subject.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @subject
  end

  private

  def subject_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:subject].permit(:name)
  end

  def set_subject
    @subject = Subject.find(params[:id])
  end
end
