class MoveDataToKnowledgeLinksTableFromClassroomsSubjects < ActiveRecord::Migration
  def up
    execute "INSERT INTO knowledge_links(knowledgeable_id, subject_id) SELECT classroom_id, subject_id FROM classrooms_subjects;"
    execute "UPDATE knowledge_links SET knowledgeable_type='Classroom' where knowledgeable_type IS NULL;"
    drop_table :classrooms_subjects
  end

  def down
    create_table :classrooms_subjects do |t|
      t.integer :classroom_id
      t.integer :subject_id
    end
    execute "INSERT INTO classrooms_subjects(classroom_id, subject_id) SELECT knowledgeable_id, subject_id FROM knowledge_links WHERE knowledgeable_type='Classroom';"
    execute "DELETE FROM knowledge_links WHERE knowledgeable_type='Classroom';"
  end
end
