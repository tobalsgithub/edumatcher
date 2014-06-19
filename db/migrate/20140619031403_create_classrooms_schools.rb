class CreateClassroomsSchools < ActiveRecord::Migration
  def change
    create_table :classrooms_schools do |t|
      t.references :classroom, index: true
      t.references :school, index: true
    end
  end
end
