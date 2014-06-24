class CreateClassroomsSubjects < ActiveRecord::Migration
  def change
    create_table :classrooms_subjects do |t|
      t.references :classroom, index: true
      t.references :subject, index: true
    end
  end
end
