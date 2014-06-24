class CreateExpertsSubjects < ActiveRecord::Migration
  def change
    create_table :experts_subjects do |t|
      t.references :expert, index: true
      t.references :subject, index: true
    end
  end
end
