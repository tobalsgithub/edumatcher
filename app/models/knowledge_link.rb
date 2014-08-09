class KnowledgeLink < ActiveRecord::Base
  belongs_to :subject
  belongs_to :knowledgeable, :polymorphic => true
  validates_presence_of :subject
  validates_presence_of :knowledgeable

  def as_json(options)
    super(:include => [:subject, :knowledgeable])
  end
end
