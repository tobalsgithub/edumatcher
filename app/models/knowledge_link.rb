class KnowledgeLink < ActiveRecord::Base
  belongs_to :subject
  belongs_to :knowledgeable, :polymorphic => true

  def as_json(options)
    super(:include => [:subject])
  end
end
