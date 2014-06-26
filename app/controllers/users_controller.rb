class UsersController < ApplicationController
  before_action :authenticate_user!

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
    respond_to do |format|
      if current_user.educator == nil
        educator = Expert.create()
        current_user.educator = educator
        current_user.save
        redirect_to educator_path(educator)
      else
        format.json { render :json => { "errors" => "This user is already an educator" }, :status => :unprocessable_entity }
      end
    end
  end
end
