class AddTimestampToClassroomEducators < ActiveRecord::Migration
  def up
    change_table :educator_staffings do |t|
      t.timestamps
    end
  end

  def down
    remove_column :educator_staffings, :created_at
    remove_column :educator_staffings, :updated_at
  end
end
