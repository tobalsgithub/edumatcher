class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def submitted_reviews
    user = User.find(params[:id])
    respond_with user.reviews
  end

  def set_expert

    if current_user.expert == nil
      expert = Expert.create()
      current_user.expert = expert
      current_user.save
      redirect_to expert_path(expert)
    else
      respond_to do |format|
        format.json { render :json => { "errors" => "This user is already an expert" }, :status => :unprocessable_entity }
      end
    end
  end

  def set_educator
    if current_user.educator == nil
      educator = Educator.create()
      current_user.educator = educator
      current_user.save
      redirect_to educator_path(educator)
    else
      respond_to do |format|
        format.json { render :json => { "errors" => "This user is already an educator" }, :status => :unprocessable_entity }
      end
    end
  end
end
