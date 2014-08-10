class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rating, only: [:show, :update, :destroy]
  respond_to :json

  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    respond_to do |format|
      if @rating.save && @rating.valid?
        format.json { render :json => @rating, :status => :created }
      else
        format.json { render :json => { "errors" => @rating.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.json { render :json => @rating }
      else
        format.json { render :json => { "errors" => @rating.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @rating
  end

  def destroy
    respond_to do |format|
      if @rating.destroy
        format.json { render :json => @rating }
      else
        format.json { render :json => { "errors" => @rating.errors }, :status => :unprocessable_entity }
      end
    end
  end

  private

  def rating_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:rating].permit(:title, :notes, :ratable_id, :ratable_type)
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end

end
