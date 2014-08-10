class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :update, :destroy]
  respond_to :json

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    respond_to do |format|
      if @review.save && @review.valid?
        format.json { render :json => @review, :status => :created }
      else
        format.json { render :json => { "errors" => @review.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.json { render :json => @review }
      else
        format.json { render :json => { "errors" => @review.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @review
  end

  def destroy
    respond_to do |format|
      if @review.destroy
        format.json { render :json => @review }
      else
        format.json { render :json => { "errors" => @review.errors }, :status => :unprocessable_entity }
      end
    end
  end

  private

  def review_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:review].permit(:title, :notes, :reviewable_id, :reviewable_type)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end
