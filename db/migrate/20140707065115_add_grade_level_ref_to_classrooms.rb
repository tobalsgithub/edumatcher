class AddGradeLevelRefToClassrooms < ActiveRecord::Migration
  def change
    add_reference :classrooms, :grade_level, index: true
  end
end
