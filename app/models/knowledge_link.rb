class KnowledgeLink < ActiveRecord::Base
  belongs_to :subject
  belongs_to :knowledgeable, :polymorphic => true
end
