class KnowledgeLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_knowledge_link, only: [:show, :update, :destroy]
  respond_to :json

  def create
    @knowledge_link = KnowledgeLink.new(knowledge_link_params)
    respond_to do |format|
      if @knowledge_link.save && @knowledge_link.valid?
        format.json { render :json => @knowledge_link, :status => :created }
      else
        format.json { render :json => { "errors" => @knowledge_link.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @knowledge_link.update(knowledge_link_params)
        format.json { render :json => @knowledge_link }
      else
        format.json { render :json => { "errors" => @knowledge_link.errors }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    respond_with @knowledge_link
  end

  def destroy
    respond_to do |format|
      if @knowledge_link.destroy
        format.json { render :json => @knowledge_link }
      else
        format.json { render :json => { "errors" => @knowledge_link.errors }, :status => :unprocessable_entity }
      end
    end
  end

  private

  def knowledge_link_params
    json_params = ActionController::Parameters.new( JSON.parse(params.to_json) )
    json_params[:knowledge_link].permit(:subject_id, :knowledgeable_id, :knowledgeable_type)
  end

  def set_knowledge_link
    @knowledge_link = KnowledgeLink.find(params[:id])
  end

end
