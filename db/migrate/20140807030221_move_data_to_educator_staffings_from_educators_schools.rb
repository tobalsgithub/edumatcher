class MoveDataToEducatorStaffingsFromEducatorsSchools < ActiveRecord::Migration
  def up
    execute "INSERT INTO educator_staffings(staffable_id, educator_id) SELECT school_id, educator_id FROM educators_schools;"
    execute "UPDATE educator_staffings SET staffable_type='School' where staffable_type IS NULL;"
    drop_table :educators_schools
  end

  def down
    create_table :educators_schools do |t|
      t.integer :school_id
      t.integer :educator_id
    end
    execute "INSERT INTO educators_schools(school_id, educator_id) SELECT staffable_id, educator_id FROM educator_staffings WHERE staffable_type='School';"
    execute "DELETE FROM educator_staffings WHERE staffable_type='School';"
  end
end
