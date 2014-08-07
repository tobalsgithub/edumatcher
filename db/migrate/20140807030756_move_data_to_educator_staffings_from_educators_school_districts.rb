class MoveDataToEducatorStaffingsFromEducatorsSchoolDistricts < ActiveRecord::Migration
  def up
    execute "INSERT INTO educator_staffings(staffable_id, educator_id) SELECT school_district_id, educator_id FROM educators_school_districts;"
    execute "UPDATE educator_staffings SET staffable_type='SchoolDistrict' where staffable_type IS NULL;"
    drop_table :educators_school_districts
  end

  def down
    create_table :educators_school_districts do |t|
      t.integer :school_district_id
      t.integer :educator_id
    end
    execute "INSERT INTO educators_school_districts(school_district_id, educator_id) SELECT staffable_id, educator_id FROM educator_staffings WHERE staffable_type='SchoolDistrict';"
    execute "DELETE FROM educator_staffings WHERE staffable_type='SchoolDistrict';"
  end
end
