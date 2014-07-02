class RemoveSchoolIdColumnFromClassrooms < ActiveRecord::Migration
  def change
    remove_column :classrooms, :School_id
  end
end
