class AddTimestampsToKnowledgeLinks < ActiveRecord::Migration
  def up
    change_table :knowledge_links do |t|
      t.timestamps
    end
  end

  def down
    remove_column :knowledge_links, :created_at
    remove_column :knowledge_links, :updated_at
  end
end
