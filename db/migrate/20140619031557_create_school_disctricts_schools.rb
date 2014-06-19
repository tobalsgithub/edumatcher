class CreateSchoolDisctrictsSchools < ActiveRecord::Migration
  def change
    create_table :school_districts_schools do |t|
      t.references :SchoolDistrict, index: true
      t.references :school, index: true
    end
  end
end
