class RenameTableExpertsSubjectsToKnowledgeLinks < ActiveRecord::Migration
  def change
    rename_table :experts_subjects, :knowledge_links
  end
end
