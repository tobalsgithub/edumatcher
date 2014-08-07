class RenameTableClassroomsEducatorsToEducatorStaffings < ActiveRecord::Migration
  def change
    rename_table :classrooms_educators, :educator_staffings
  end
end
