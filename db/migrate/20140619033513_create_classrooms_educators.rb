class CreateClassroomsEducators < ActiveRecord::Migration
  def change
    create_table :classrooms_educators do |t|
      t.references :classroom, index: true
      t.references :educator, index: true
    end
  end
end
