class MakeKnowledgeLinksPolymorphic < ActiveRecord::Migration
  def change
    rename_column :knowledge_links, :expert_id, :knowledgeable_id
    add_column :knowledge_links, :knowledgeable_type, :string
  end
end
