class DropSchoolDistricts < ActiveRecord::Migration
  def change
    drop_table :educators_school_districts
    drop_table :school_districts
    drop_table :school_districts_schools
  end
end
