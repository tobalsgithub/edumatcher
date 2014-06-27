class EducatorsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_educator?
  before_action :set_educator
  respond_to :json

  def index
    respond_with(educator_to_json)
  end

  def show
    @educator = Expert.find(params[:id])
    respond_with(educator_to_json)
  end

  def update
    respond_to do |format|
      if @educator.update(educator_params)
        format.json { render :json => educator_to_json, :status => 204 }
      else
        format.json { render :json => { "errors" => @educator.errors }, :status => :unprocessable_entity }
      end
    end
  end

  # def subjects
  #   respond_with(Expert.find(params[:id]).subjects)
  # end
  #
  # def add_subject
  #   #subject = Subject.find(params[:subject_id])
  #   @educator.subjects << Subject.find(params[:subject_id])
  #   respond_to do |format|
  #     if @educator.save && @educator.valid?
  #       @educator.reload
  #       format.json { render :json => educator_to_json }
  #     else
  #       format.json { render :json => { "errors" => @educator.errors }, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # def remove_subject
  #   subject = Subject.find(params[:subject_id])
  #   @educator.subjects.delete(subject)
  #   respond_to do |format|
  #     if @educator.save && @educator.valid?
  #       @educator.reload
  #       format.json { render :json => educator_to_json }
  #     else
  #       format.json { render :json => { "errors" => @educator.errors }, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # def set_subjects
  #   @educator.subjects.clear
  #   params[:subject_list].each do |id|
  #     @educator.subjects << Subject.find(id)
  #   end
  #   respond_to do |format|
  #     if @educator.save && @educator.valid?
  #       format.json { render :json => educator_to_json }
  #     else
  #       format.json { render :json => { "errors" => @educator.errors }, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def is_educator?
    render :json => { "errors" => ["You are not an educator"] }, :status => :unauthorized unless current_user.educator
  end

  def set_educator
    @educator = current_user.educator
  end

  def educator_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:educator].permit(:notes)
  end

  def educator_to_json
    @educator.to_json
  end
end
