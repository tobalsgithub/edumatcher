class GradeLevelsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    respond_with GradeLevel.all
  end
end
